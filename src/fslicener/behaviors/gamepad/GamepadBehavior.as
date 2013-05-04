/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:48
 * To change this template use File | Settings | File Templates.
 */
package fslicener.behaviors.gamepad {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;

import flash.events.MouseEvent;

import fslicener.utils.Config;

public class GamepadBehavior extends BehaviorBase{

    // default keys
    private static const TAP:String = "tap";

    private static const IDLE:String = "idle";

    private var _shouldSetIdle:Boolean;
    private var _activeKeys:Array;

    public function GamepadBehavior() {
        super();
        init();
    }

    private function init():void {
        _activeKeys = [];
        _activeKeys[TAP] = [IDLE];
    }

    override public function start(c:ControllerBase):void{
        super.start(c);

        Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        Config.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    private function onMouseUp(e:MouseEvent):void {
        var info:Object = _activeKeys[TAP][1];
        info.b = {x: e.stageX, y: e.stageY};
        _activeKeys[TAP] = [MouseEvent.MOUSE_UP, info];
    }

    private function onMouseDown(e:MouseEvent):void {
        _activeKeys[TAP] = [MouseEvent.MOUSE_DOWN,  {a: {x: e.stageX, y: e.stageY}}];
    }

    override public function doStep(step:Number):void{
        if(!_enabled)
            return;

        super.doStep(step);

        if(_shouldSetIdle)
            _activeKeys[TAP] = [IDLE];

        _shouldSetIdle = _activeKeys[TAP][0] == MouseEvent.MOUSE_UP;
    }

    override public function stop():void{
        super.stop();

        _activeKeys[TAP] = [IDLE];
        Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        Config.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    public function get touched():Boolean{
        return _activeKeys[TAP] && _activeKeys[TAP][0] == MouseEvent.MOUSE_UP;
    }

    public function get touchInfo():Object{
        if(touched)
            return _activeKeys[TAP][1];

        return null;
    }
}
}
