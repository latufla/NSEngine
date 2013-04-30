/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 20.02.13
 * Time: 14:15
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;

import sqballs.model.SQObjectBase;

public class DeathBehavior extends BehaviorBase{

    private var _recoverTimeout:Number = 1000;
    private var _recoverId:uint;

    public function DeathBehavior() {
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

//        var obj:SQObjectBase = _controller.object as SQObjectBase;
//        if(obj.ammunition.health <=0 && obj.controller)
//            applyDeath(obj);
    }

    // TODO: think about standart clone
    private function applyDeath(obj:SQObjectBase):void {
//        var pos:Point = obj.position;
//        GuiUtil.showStaticText(Config.stage, new Point(pos.x, pos.y), "BAAAAANG!!!", 30, 0xFF0000);
//
//        var recoveryObj:SQObjectBase = SQObjectBase.create(obj.libDesc, obj.position, obj.shapes, obj.material, obj.interactionGroup);
//        recoveryObj.name = obj.name;
//        recoveryObj.ammunition = obj.ammunition;
//        var recoveryC:SQControllerBase = SQControllerBase.create(recoveryObj, obj.controller.behaviors);
//        Config.fieldController.remove(obj.controller);
//
//        _recoverId = setTimeout(function ():void{
//            clearTimeout(_recoverId);
//
//            WaypointManager.instance.correctToNextWaypointWhenRespawn(recoveryObj);
//            obj.ammunition.health = 100;
//            Config.fieldController.add(recoveryC);
//        }, _recoverTimeout);
    }

}
}
