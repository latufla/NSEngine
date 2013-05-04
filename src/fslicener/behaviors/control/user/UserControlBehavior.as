/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package fslicener.behaviors.control.user {
import core.controller.ControllerBase;

import flash.geom.Point;

import fslicener.behaviors.control.ControlBehavior;
import fslicener.behaviors.gamepad.GamepadBehavior;

public class UserControlBehavior extends ControlBehavior{

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

    override public function get slice():Vector.<Point>{
        if(!_gamepad.touched)
            return null;

        var info:Object = _gamepad.touchInfo;
        return new <Point>[new Point(info.a.x, info.a.y), new Point(info.b.x, info.b.y)];
    }
}
}
