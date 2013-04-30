/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 13:36
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.controller.ControllerBase;
import core.model.ObjectBase;

import sqballs.utils.Config;


public class SQObjectBase extends ObjectBase {
    protected var _pivotX:int = 80;
    protected var _pivotY:int = 80;

    public function SQObjectBase() {
        super();
    }


    override public function get controller():ControllerBase{
        return Config.fieldController.getControllerByObject(this);
    }

    public function get pivotX():int {
        return _pivotX;
    }

    public function set pivotX(value:int):void {
        _pivotX = value;
    }

    public function get pivotY():int {
        return _pivotY;
    }

    public function set pivotY(value:int):void {
        _pivotY = value;
    }
}
}
