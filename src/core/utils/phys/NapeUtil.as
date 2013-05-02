/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package core.utils.phys {

import flash.display.BitmapData;
import flash.geom.Point;

import nape.geom.AABB;
import nape.geom.GeomPoly;
import nape.geom.GeomPolyList;
import nape.geom.IsoFunction;
import nape.geom.MarchingSquares;
import nape.geom.Vec2;
import nape.geom.Vec2List;
import nape.phys.Body;
import nape.shape.Polygon;

public class NapeUtil {
    public function NapeUtil() {
    }

    public static function vertexesFromBD(bd:BitmapData):Vector.<Point>{
        var p:Polygon = convexPolygonFromBD(bd);
        var vs:Vec2List = p.localVerts;
        var vertexes:Vector.<Point> = new Vector.<Point>();
        var n:uint = vs.length;
        for (var i:int = 0; i < n; i++) {
            var v:Vec2 = vs.at(i);
            vertexes.push(v.toPoint());
        }
        return vertexes;
    }

    private static function convexPolygonFromBD(bd:BitmapData):Polygon{
        var tDet:ThresholdDetector = new ThresholdDetector(bd, 0x80);
        var b:AABB = tDet.bounds;
        var ps:GeomPolyList = MarchingSquares.run(tDet, b, Vec2.weak(8, 8));
        return new Polygon(ps.at(0));
    }


    public static function bodyFromBitmapData(bd:BitmapData):Body{
        var bdIso:ThresholdDetector = new ThresholdDetector(bd, 0x80);
        return run(bdIso, bdIso.bounds);
    }

    private static function run(iso:IsoFunction, bounds:AABB, granularity:Vec2 = null, quality:int = 2, simplification:Number = 1.5):Body {
        granularity ||= Vec2.weak(8, 8);

        var body:Body = new Body();
        var polys:GeomPolyList = MarchingSquares.run(iso, bounds, granularity, quality);
        for (var i:int = 0; i < polys.length; i++) {
            var p:GeomPoly = polys.at(i);

            var qolys:GeomPolyList = p.simplify(simplification).convexDecomposition(true);
            for (var j:int = 0; j < qolys.length; j++) {
                var q:GeomPoly = qolys.at(j);
                body.shapes.add(new Polygon(q));
                q.dispose();
            }
            qolys.clear();
            p.dispose();
        }
        polys.clear();

        var pivot:Vec2 = body.localCOM.mul(-1);
        body.translateShapes(pivot);
        return body;
    }


//    // use marching squares to create fruits polys from bitmaps
//    // with cellsize of whole fruit image
//    MarchingSquares.run();
//
//    // get shape from ObjectBase, create geom poly
//    var shape:Polygon = new Polygon(Polygon.box(10, 10));
//    var gPoly:GeomPoly = GeomPoly.get(shape.localVerts);
//    // cut it and create 2 ObjectBase
//    gPoly.cut()
//
//    var p:Polygon = new Polygon(Polygon.regular()); // transform circle to poly
}
}
