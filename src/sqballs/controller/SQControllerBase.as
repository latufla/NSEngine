/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 18:59
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {
import core.controller.ControllerBase;

import flash.geom.Point;

import sqballs.model.SQObjectBase;

public class SQControllerBase extends ControllerBase{

    public function SQControllerBase() {
        super();
    }

//    override protected function align():void {
//        var obj:SQObjectBase = _object as SQObjectBase;
//        _view.pivotX = obj.pivotX;
//        _view.pivotY = obj.pivotY;
//
//        var pos:Point = _object.position;
//        _view.x = pos.x;
//        _view.y = pos.y;
//
//        _view.rotation = _object.rotation;
//    }

}
}
