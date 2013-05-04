/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 03.05.13
 * Time: 22:23
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model {
import core.model.ObjectBase;
import core.utils.phys.CustomMaterial;
import core.utils.phys.CustomPolygon;
import core.utils.phys.CustomShape;
import core.utils.phys.NapeUtil;

import flash.display.BitmapData;

import flash.geom.Point;

public class FSObjectBase extends ObjectBase {

    private var _pivotX:int = 43;
    private var _pivotY:int = 58;

    private var _points:uint = 10;

    public function FSObjectBase() {
        super();
    }

    public static function create(pos:Point, shapes:Vector.<CustomShape>, material:CustomMaterial, interactionGroup:uint):FSObjectBase{
        var obj:FSObjectBase = new FSObjectBase();
        obj.shapes = shapes;
        obj.material = material;
        obj.position = pos;
        obj.interactionGroup = interactionGroup;

        return obj;
    }

    public static function fromBitmapData(pos:Point, polyBD:BitmapData, material:CustomMaterial, interactionGroup:uint):FSObjectBase{
        var vertexes:Vector.<Point> = NapeUtil.vertexesFromBD(polyBD);
        var obj:FSObjectBase = FSObjectBase.create(pos, new <CustomShape>[new CustomPolygon(vertexes)], material, interactionGroup);
        return obj;
    }

    public function get points():uint {
        return _points;
    }

    public function set points(value:uint):void {
        _points = value;
    }

    public function splitByLine(a:Point, b:Point):Vector.<FSObjectBase>{
        var _objects:Vector.<FSObjectBase> = new <FSObjectBase>[this];
        if(!(_shapes && _shapes[0] && _shapes[0] is CustomPolygon && _shapes.length == 1))
            return _objects;

        var p1:CustomPolygon = _shapes[0] as CustomPolygon;
        var ps:Vector.<CustomPolygon> = p1.splitByLine(a, b);

        if(!(ps && ps[0]))
            return _objects;

        var pos:Point = position;
        p1 = _shapes[0] as CustomPolygon;
        var p2:CustomPolygon = ps.shift();
        p1.vertexes = p2.vertexes;
        position = pos;

        var obj:FSObjectBase;
        var n:uint = ps.length;
        for (var i:int = 0; i < n; i++) {
            obj = FSObjectBase.create(pos, new <CustomShape>[ps[i]], _material.clone(), _interactionGroup);
            _objects.push(obj);
        }

        var n:uint = _objects.length;
        for (var i:int = 0; i < n; i++) {
            _objects[i].points = _points / n;
        }
        return _objects;
    }

    public function get pivotX():int{
        return _pivotX;
    }

    public function get pivotY():int{
        return _pivotY;
    }

    public function set pivotX(value:int):void {
        _pivotX = value;
    }

    public function set pivotY(value:int):void {
        _pivotY = value;
    }
}
}
