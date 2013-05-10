/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 16:19
 * To change this template use File | Settings | File Templates.
 */
package fslicener.controller {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.controller.FieldController;
import core.utils.phys.PhysEngineConnector;

import fslicener.model.FSField;

public class FSFieldController extends FieldController {
    public function FSFieldController(object:FSField) {
        super(object);
    }

    public static function create(obj:FSField, behaviors:Vector.<BehaviorBase> = null):FSFieldController{
        var c:FSFieldController = new FSFieldController(obj);
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }
        return c;
    }


    override public function doStep(step:Number, debugView:* = null):void{
        for each(var p:ControllerBase in _controllers){
            p.doBehaviorsStep(step);
        }

        PhysEngineConnector.instance.doStep(this, step, debugView);
    }

    override protected function align():void{
        super.align();

        var f:FSField = _object as FSField;
        _view.pivotX = f.pivotX;
        _view.pivotY = f.pivotY;

        _view.rotation = f.rotation;
    }
}
}
