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
import core.utils.phys.PhysEngineConnector;

import flash.display.BitmapData;

import flash.geom.Point;

public class FSObjectBase extends ObjectBase {

    private var _pivotX:int = 32;
    private var _pivotY:int = 39;

    private var _points:uint = 40;

    public function FSObjectBase() {
        super();
    }

    override protected function init():void {
        PhysEngineConnector.instance.initObject(this);
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

    public function splitByLine(a:Point, b:Point, closedGaps:Boolean = false):Vector.<FSObjectBase>{
        if(!(_shapes && _shapes[0] && _shapes[0] is CustomPolygon && _shapes.length == 1))
            return null;

        var initialShape:CustomPolygon = (_shapes[0] as CustomPolygon);
        var ps:Vector.<CustomPolygon> = initialShape.splitByLine(a, b, closedGaps);
        if(!ps || ps.length < 2)
            return null;


        var pos:Point = position;
        var n:uint = ps.length;
        for (var i:int = 0; i < n; i++) {
            _shapes[i] = ps[i];
        }
        shapes = _shapes;
        position = pos;

        var objects:Vector.<FSObjectBase> = new <FSObjectBase>[];
        var com:Point;
        var obj:FSObjectBase;
        for (i = 0; i < n; i++) {
            com = ps[i].localCOM;
            obj = FSObjectBase.create(ps[i].fieldCOM, new <CustomShape>[ps[i]], _material.clone(), _interactionGroup);
            obj.pivotX = com.x;
            obj.pivotY = com.y;
            obj.rotation = rotation;
            obj.points = _points;
            obj.velocity = velocity;
            obj.angularVelocity = angularVelocity;
            objects.push(obj);
        }

        shapes = new <CustomShape>[initialShape];
        position = pos;

        return objects;
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
