/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.05.13
 * Time: 11:16
 * To change this template use File | Settings | File Templates.
 */
package fslicener.controller {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.model.ObjectBase;
import core.view.ViewBase;

import flash.geom.Point;

import fslicener.model.FSObjectBase;

public class FSControllerBase extends ControllerBase{
    public function FSControllerBase() {
        super();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):FSControllerBase{
        var c:FSControllerBase = new FSControllerBase();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }

    override protected function align():void{
        super.align();

        var obj:FSObjectBase = _object as FSObjectBase;
        _view.pivotX = obj.pivotX;
        _view.pivotY =  obj.pivotY;

        _view.rotation = _object.rotation;
    }

    public function slice(a:Point, b:Point):Vector.<FSControllerBase>{
        if(!(_object && _view))
            return null;

        var obj:FSObjectBase = _object as FSObjectBase;
        var locA:Point = _view.globalToLocal(a);
        var locB:Point = _view.globalToLocal(b);
        var objects:Vector.<FSObjectBase> = obj.splitByLine(locA, locB, true);
        if(!objects)
            return null;

        var views:Vector.<ViewBase> = _view.splitByLine(locA, locB);
        if(!views)
            return null;


        var res:Vector.<FSControllerBase> = new <FSControllerBase>[];
        var n:uint = objects.length;
        for (var i:int = 0; i < n; i++) {
            var c:FSControllerBase = FSControllerBase.create(objects[i]);
            c.view = views[i];
            res.push(c);
        }
        return res;
    }
}
}
