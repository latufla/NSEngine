/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:17
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;
import sqballs.model.Ball;
import sqballs.model.SQObjectBase;

//locomotion
public class BallMoveBehavior extends BehaviorBase{

    public static const MAX_MAGNITUDE:int = 250;
    public static const STOPPAGE_MIN_VELOCITY:int = 10;

    public function BallMoveBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var controlBehavior:ControlBehavior = _controller.getBehaviorByClass(ControlBehavior) as ControlBehavior;
        if(!controlBehavior)
            return;

        var obj:SQObjectBase = _controller.object as Ball;
        if(!obj)
            return;

        var moveFrom:Point = controlBehavior.moveFrom;
        if(moveFrom)
            applyRun(obj, moveFrom, controlBehavior.magnitude);
        else
            applyStoppage(obj);
    }

    private function applyRun(obj:SQObjectBase, moveFrom:Point, magnitude:int):void{
        var pos:Point = obj.position;
        pos = pos.subtract(moveFrom);
        pos.normalize(1);

        if(magnitude > MAX_MAGNITUDE)
            magnitude = MAX_MAGNITUDE;

        pos.x *= magnitude * obj.mass;
        pos.y *= magnitude * obj.mass;

        obj.applyImpulse(pos);
    }


    private function applyStoppage(obj:ObjectBase):void {
        var vel:int = obj.velocity.length; // whatever is small
        if(vel > 0 && vel <= STOPPAGE_MIN_VELOCITY)
            obj.velocity = new Point();
    }
}
}
