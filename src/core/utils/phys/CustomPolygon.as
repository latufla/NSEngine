/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 15.01.13
 * Time: 16:17
 * To change this template use File | Settings | File Templates.
 */
package core.utils.phys {
import flash.geom.Point;
import flash.geom.Rectangle;

import nape.geom.Vec2;

import nape.geom.Vec2List;

import nape.shape.Polygon;
import nape.shape.Shape;

public class CustomPolygon extends CustomShape{

    private var _vertexes:Vector.<Point>;
    public function CustomPolygon(vertexes:Vector.<Point>) {
        _vertexes = vertexes.concat();
    }

    public static function rect(size:Rectangle):Vector.<Point>{
        return new <Point>[new Point(size.x, size.y), new Point(size.width, size.y), new Point(size.width, size.height), new Point(0, size.height)];
    }

    override public function toPhysEngineObj():Shape{
        return new Polygon(vertexesAsVec2List);
    }

    override protected function updatePhysEngineObj(s:Shape):void{
        var vs:Vec2List = vertexesAsVec2List;

        while(!(s as Polygon).localVerts.empty()){
            (s as Polygon).localVerts.pop();
        }

        while(!vs.empty()){
            (s as Polygon).localVerts.push(vs.shift());
        }
        super.updatePhysEngineObj(s);
    }

    override public function clone():CustomShape{
        return new CustomPolygon(_vertexes.concat());
    }

    public function get vertexes():Vector.<Point> {
        return _vertexes;
    }

    public function set vertexes(value:Vector.<Point>):void {
        _vertexes = value;
        updatePhysEngineObj(_shape);
    }

    private function get vertexesAsVec2List():Vec2List{
        var vs:Vec2List = new Vec2List();
        var n:uint = _vertexes.length;
        for(var i:uint = 0; i < n; i++){
            vs.push(new Vec2(_vertexes[i].x, _vertexes[i].y));
        }
        return vs;
    }
}
}
