/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control.user {
import core.controller.ControllerBase;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;
import sqballs.behaviors.gamepad.GamepadBehavior;

public class UserControlBehavior extends ControlBehavior{

    private static const MAGNITUDE_MULTIPLIER:uint = 12;

    private var _gamepad:GamepadBehavior;

    public function UserControlBehavior() {
        init();
    }

    private function init():void {
        _gamepad = new GamepadBehavior();
    }

    override public function start(c:ControllerBase):void{
        super.start(c);
        _gamepad.start(c);
    }

    override public function doStep(step:Number):void{
        if(!_enabled)
            return;

        super.doStep(step);
        _gamepad.doStep(step);
    }

    override public function stop():void{
        super.stop();
        _gamepad.stop();
    }

    override public function get moveFrom():Point{
        if(!_gamepad.touched)
            return null;

        var info:Object = _gamepad.touchInfo;
        var pos:Point = new Point(info.x, info.y);
        return pos;
    }

    override public function get magnitude():int{
        if(!_gamepad.touched)
            return 0;

        return MAGNITUDE_MULTIPLIER * _gamepad.touchInfo.touchLength;
    }
}
}
