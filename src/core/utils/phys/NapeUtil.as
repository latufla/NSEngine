/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package core.utils.phys {

import core.utils.MathUtil;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

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

    public static function getBounds(cP:CustomPolygon):Rectangle{
        var p:Polygon = cP.toPhysEngineObj() as Polygon;
        var gP:GeomPoly = GeomPoly.get(p.localVerts);
        return gP.bounds().toRect();
    }

    public static function splitByLine(cP:CustomPolygon, p1:Point, p2:Point, closedGaps:Boolean = false):Vector.<CustomPolygon>{
        var res:Vector.<CustomPolygon> = new Vector.<CustomPolygon>();
        var p:Polygon = cP.toPhysEngineObj() as Polygon;
        var gP:GeomPoly = GeomPoly.get(p.localVerts);
        var gPList:GeomPolyList = gP.cut(Vec2.fromPoint(p1), Vec2.fromPoint(p2), closedGaps, closedGaps); // TODO: sick performance
        gP.dispose();
        var vertexes:Vector.<Point>;
        var it:GeomPolyIterator = gPList.iterator();
        while(it.hasNext()){
            gP = it.next();
            if(!isValidGeomPoly(gP)) //can`t split, cause one is invalid
                return null;

            var tmpP:Polygon = new Polygon(gP);
            vertexes = vecPointFromVec2List(tmpP.localVerts);
            res.push(new CustomPolygon(vertexes));
        }

        swapByHalfPlanes(res, p1, p2);  // determination
        return res;
    }

    private static function swapByHalfPlanes(res:Vector.<CustomPolygon>, p1:Point, p2:Point):void {
        res.sort(sorter);

        function sorter(a:CustomPolygon, b:CustomPolygon):int{
            var aSign:int = halfPlaneSign(a, p1, p2);
            var bSign:int = halfPlaneSign(b, p1, p2);
            if(aSign > bSign)
                return -1;
            else if(aSign < bSign)
                return 1;

            return 0;
        }
    }

    private static function halfPlaneSign(cP:CustomPolygon, p1:Point, p2:Point):int{
        var sign:int;
        for each(var p:Point in cP.vertexes){
            var hPlaneK:int = (p2.x - p1.x) * (p.y - p1.y) - (p2.y - p1.y) * (p.x - p1.x);
            sign = hPlaneK != 0 ? hPlaneK / MathUtil.abs(hPlaneK) : sign;
            if(sign != 0)
                break;
        }
        return sign;
    }

    private static function isValidGeomPoly(p:GeomPoly):Boolean {
        if(p.isDegenerate() || !p.isConvex()){
            trace(false, p);
            return false;
        }

        return true;
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
        var ps:GeomPolyList = MarchingSquares.run(tDet, b, Vec2.weak(1, 1), 10);
        var p:GeomPoly = ps.at(0).simplify(1.5);
        trace(p.isConvex(), p);
        return new Polygon(p);
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

//        body.align();
        var pivot:Vec2 = body.localCOM.mul(-1);
        body.translateShapes(pivot);
        return body;
    }
}
}
