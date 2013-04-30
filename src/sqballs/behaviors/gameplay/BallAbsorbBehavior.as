/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 26.03.13
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.model.ObjectBase;

import sqballs.controller.BallController;
import sqballs.controller.SQFieldController;
import sqballs.model.Ball;
import sqballs.utils.Color;
import sqballs.utils.Config;

public class BallAbsorbBehavior extends BehaviorBase{

    private static const COLOR_CHANGE_STEP:Number = .2;

    public function BallAbsorbBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var b:Ball = _controller.object as Ball;
        var playerBallC:BallController = Config.fieldController.playerBallController as BallController;
        if(!(b && playerBallC))
            return;

        var pB:Ball = playerBallC.object as Ball;
        if(!pB || pB == b)
            return;

        var bArea:int = b.area; // better for comparision
        var pBArea:int = pB.area
        var ratio:Number = (bArea / pBArea) / 2; // need between 0 and 1
        ratio = ratio < 1 ? ratio : 1;
        ratio = int(ratio / COLOR_CHANGE_STEP) * COLOR_CHANGE_STEP; // avoid often color changes
        b.color = Color.interpolateColor(Config.enemyBallColors[0], Config.enemyBallColors[1], ratio);
    }

    override public function start(c:ControllerBase):void{
        super.start(c);

        _controller.object.addInteractionListeners(onBeginInteraction);
    }

    override public function stop():void{
        _controller.object.removeInteractionListeners();

        super.stop();
    }

    override protected function onBeginInteraction(obj1:ObjectBase, obj2:ObjectBase):void{
        var b1:Ball = obj1 as Ball;
        var b2:Ball = obj2 as Ball;

        if(!shouldAbsorb(b1,  b2))
            return;

        b1.area = b1.area + b2.area; // TODO: use tween utils

        var c:ControllerBase = Config.fieldController.getControllerByObject(obj2);
        if(c)
            Config.fieldController.remove(c);
    }

    private function shouldAbsorb(b1:Ball, b2:Ball):Boolean{
        var playerBallC:BallController = (Config.fieldController as SQFieldController).playerBallController as BallController;
        var playerBall:Ball = playerBallC ? playerBallC.object as Ball : null;

        return b1 && b2 && ((b1.area > b2.area) || (b1.area == b2.area && b2 != playerBall));
    }

}
}
