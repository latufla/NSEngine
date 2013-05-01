/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 16.01.13
 * Time: 19:39
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {

import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.controller.FieldController;
import core.model.Field;
import core.utils.phys.CustomMaterial;

import sqballs.behaviors.control.ai.AIControlBehavior;
import sqballs.behaviors.control.user.UserControlBehavior;
import sqballs.behaviors.gameplay.BallAbsorbBehavior;
import sqballs.behaviors.gameplay.BallMoveBehavior;
import sqballs.model.Ball;
import sqballs.model.SQField;
import sqballs.model.info.BotInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;
import sqballs.utils.assets.SQAssetsHeap;

public class SQFieldController extends FieldController{

    public function SQFieldController(field:SQField) {
        super(field);
    }

    override protected function init():void {
        super.init();

        Config.fieldController = this;
        createBalls(field);
    }

    override public function doStep(step:Number, debugView:* = null):void{
        super.doStep(step, debugView);

//        if(!field.raceIsFinished)
//            field.updateRaceProgress();
    }

    public function get playerBallController():BallController{
        return getBallControllerByUserInfo(field.player);
    }

    public function getBallControllerByUserInfo(p:UserInfo):BallController{
        var ratCs:Vector.<ControllerBase> = getControllersByClass(BallController);
        var res:Vector.<ControllerBase> = ratCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e.object.name == p.name;
        });

        if(res.length > 0)
            return res[0] as BallController;

        return null;
    }


    private function get field():SQField{
        return _object as SQField;
    }

    private function createBalls(f:SQField):void {
        var ball:Ball;
        var bhs:Vector.<BehaviorBase>;
        var info:UserInfo;
        var n:uint = f.racers.length;
        for(var i:uint = 0; i < n; i++){
            info = f.racers[i];
            ball = Ball.create(SQAssetsHeap.BALL, info.initialPosition, info.initialRadius, new CustomMaterial());
            ball.color = Config.playerBallColor;
            ball.name = info.name;

            if(info is BotInfo)
                bhs = new <BehaviorBase>[new AIControlBehavior(), new BallMoveBehavior(), new BallAbsorbBehavior()];
            else
                bhs = new <BehaviorBase>[new UserControlBehavior(), new BallMoveBehavior(), new BallAbsorbBehavior()];

            add(BallController.create(ball, bhs));
        }
    }

}
}
