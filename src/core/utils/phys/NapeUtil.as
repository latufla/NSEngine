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
import nape.geom.GeomPolyIterator;
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

    public static function splitByLine(cP:CustomPolygon, p1:Point, p2:Point):Vector.<CustomPolygon>{
        var res:Vector.<CustomPolygon> = new Vector.<CustomPolygon>();
        var p:Polygon = cP.toPhysEngineObj() as Polygon;
        var gP:GeomPoly = GeomPoly.get(p.localVerts);
        var gPList:GeomPolyList = gP.cut(Vec2.fromPoint(p1), Vec2.fromPoint(p2)); // TODO: sick performance
        gP.dispose();
        var vertexes:Vector.<Point>;
        var it:GeomPolyIterator = gPList.iterator();
        while(it.hasNext()){
            var tmpP:Polygon = new Polygon(it.next());
            vertexes = vecPointFromVec2List(tmpP.localVerts);
            res.push(new CustomPolygon(vertexes));
        }
        return res;
    }

    public static function vertexesFromBD(bd:BitmapData):Vector.<Point>{
        var p:Polygon = convexPolygonFromBD(bd);
        return vecPointFromVec2List(p.localVerts);
    }

    private static function vecPointFromVec2List(vs:Vec2List):Vector.<Point>{
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
}
}
