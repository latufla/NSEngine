/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control.ai {
import core.controller.ControllerBase;
import core.utils.CollectionUtils;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;
import sqballs.controller.BallController;
import sqballs.model.Ball;
import sqballs.utils.Config;

//TODO: divide into strategic and triggerin layers
// TODO: change vec when wall
public class AIControlBehavior extends ControlBehavior{
    private static const DEFAULT_AVOID_MAGNITUDE:int = 4;
    private static const DEFAULT_ASPIRE_MAGNITUDE:int = 4;

    private var _moveFrom:Point;
    private var _magnitude:int;

    public function AIControlBehavior() {
        super();
    }

    override public function stop():void{
        super.stop();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        var b:Ball = _controller.object as Ball;
        if(b)
            resolveGeneralRoute(b);
    }

    private function resolveGeneralRoute(b:Ball):void {
        var enemyCs:Vector.<ControllerBase> = Config.fieldController.getControllersByClass(BallController);
        CollectionUtils.removeElement(enemyCs, _controller);

        var avoid:Point = resolveAvoidBehavior(b, enemyCs);
        var aspire:Point = resolveAspireBehavior(b, enemyCs);

        if(avoid) {
            _moveFrom = avoid;
            _magnitude = DEFAULT_AVOID_MAGNITUDE;
        }else if(aspire){
            _moveFrom = aspire;
            _magnitude = DEFAULT_ASPIRE_MAGNITUDE;
        } else{
            _moveFrom = null
            _magnitude = 0;
        }
    }

    private function resolveAspireBehavior(b:Ball, enemyCs:Vector.<ControllerBase>):Point {
        var bArea:int = b.area;
        var allSmallerBallCs:Vector.<ControllerBase> = enemyCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return int((e.object as Ball).area) < bArea;
        });

        allSmallerBallCs.sort(sortOnDistance);

        // aspire to closest
        if(allSmallerBallCs.length > 0){
            var bPos:Point = b.position;
            return bPos.add(bPos.subtract(allSmallerBallCs[0].object.position));
        }

        return null;
    }

    // TODO: extract boolean condition
    private function resolveAvoidBehavior(b:Ball, enemyCs:Vector.<ControllerBase>):Point {
        var enemyCs:Vector.<ControllerBase> = Config.fieldController.getControllersByClass(BallController);
        CollectionUtils.removeElement(enemyCs, _controller);

        var playerBallC:ControllerBase = Config.fieldController.playerBallController;
        var bArea:int = b.area;
        var allInRadiusAndBigger:Vector.<ControllerBase> = enemyCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            var b2:Ball = e.object as Ball;
            return b.isInDefenceRadius(b2) && (int((b2).area) > bArea || (e == playerBallC && int((b2).area) == bArea));
        });

        allInRadiusAndBigger.sort(sortOnDistance);

        // run from closest bigger ball
        if(allInRadiusAndBigger.length > 0)
            return allInRadiusAndBigger[0].object.position;

        return null;
    }

    override public function get moveFrom():Point {
        return _moveFrom;
    }

    override public function get magnitude():int {
        return _magnitude;
    }

    private function sortOnDistance(a:ControllerBase, b:ControllerBase):int{
        var aDist:uint = (a.object as Ball).getDistanceTo(_controller.object as Ball);
        var bDist:uint = (b.object as Ball).getDistanceTo(_controller.object as Ball);

        if(aDist < bDist)
            return -1;
        else if(aDist > bDist)
            return 1;

        return 0;
    }

}
}
