/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.05.13
 * Time: 10:37
 * To change this template use File | Settings | File Templates.
 */
package fslicener.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.controller.FieldController;
import core.utils.DisplayObjectUtil;

import flash.geom.Point;

import fslicener.behaviors.control.ControlBehavior;
import fslicener.controller.FSControllerBase;
import fslicener.utils.Config;

public class SliceResolveBehavior extends BehaviorBase{
    public function SliceResolveBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var controlBehavior:ControlBehavior = _controller.getBehaviorByClass(ControlBehavior) as ControlBehavior;
        if(!controlBehavior)
            return;

        var slice:Vector.<Point> = controlBehavior.slice;
        if(slice)
            applySlice(slice);
    }

    private function applySlice(s:Vector.<Point>):void {
        var fieldC:FieldController = _controller as FieldController;
        if(!fieldC)
            return;

        var cs:Vector.<ControllerBase> = fieldC.getControllersByClass(FSControllerBase);
        for each(var p:FSControllerBase in cs){
            var res:Vector.<FSControllerBase> = p.slice(s[0], s[1]);
            trace("res", res);
            if(res)
                fieldC.remove(p);

            for each(var k:FSControllerBase in res){
                fieldC.add(k);
            }
        }

        DisplayObjectUtil.removeAll(Config.stage);
        cs = fieldC.getControllersByClass(FSControllerBase);
        for each(var p:FSControllerBase in cs){
            Config.stage.addChild(p.view.texture);
        }
    }
}
}
