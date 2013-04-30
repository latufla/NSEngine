/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 27.03.13
 * Time: 22:01
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.utils.CollectionUtils;
import core.utils.EventHeap;

import sqballs.controller.BallController;
import sqballs.controller.SQFieldController;
import sqballs.event.GameEvent;
import sqballs.model.Ball;

public class GameResultResolveBehavior extends BehaviorBase{
    public static const VICTORY:String = "victory";
    public static const DEFEAT:String = "defeat";

    public function GameResultResolveBehavior() {
        super();
    }

    // TODO: extract victory and defeat definition into functions
    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var fieldC:SQFieldController = _controller as SQFieldController;
        if(!fieldC)
            return;

        // no user ball - defeat
        var playerBallC:BallController = fieldC.playerBallController;
        if(!playerBallC){
            applyBrawlResult(DEFEAT);
            return;
        }

        // area more or equal all enemy areas summ
        var ballCs:Vector.<ControllerBase> = fieldC.getControllersByClass(BallController);
        CollectionUtils.removeElement(ballCs, playerBallC);
        var enemyAreasSumm:int = 0;
        for each(var p:ControllerBase in ballCs){
            enemyAreasSumm += (p.object as Ball).area;
        }

        var playerB:Ball = playerBallC.object as Ball;
        var pBArea:int = playerB.area;
        if(pBArea >= enemyAreasSumm){
            applyBrawlResult(VICTORY);
            return;
        }

        // player area less than every enemy area
        var smallerBallsCs:Vector.<ControllerBase> = ballCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return int((e.object as Ball).area) <= pBArea;
        });

        if(smallerBallsCs.length == 0)
            applyBrawlResult(DEFEAT);
    }

    private function applyBrawlResult(result:String):void {
        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL_RESULT, {result:result}));
    }
}
}
