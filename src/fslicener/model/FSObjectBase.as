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

    override public function splitByLine(a:Point, b:Point):Vector.<ObjectBase>{
        var res:Vector.<ObjectBase> = super.splitByLine(a, b);
        var fsObj:FSObjectBase;
        var n:uint = res.length;
        for (var i:int = 0; i < n; i++) {
            fsObj = res[i] as FSObjectBase;
            fsObj && (fsObj.points = _points / n);
        }
        return res;
    }
}
}
