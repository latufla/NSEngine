/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 15:08
 * To change this template use File | Settings | File Templates.
 */
package fslicener.behaviors.gameplay {
import core.behaviors.BehaviorBase;

public class GameResultResolveBehavior extends BehaviorBase{

    private var _time:Number = 0;
    public function GameResultResolveBehavior() {
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        _time +=step;


    }
}
}