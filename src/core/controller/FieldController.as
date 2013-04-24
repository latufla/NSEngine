/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.03.13
 * Time: 14:35
 * To change this template use File | Settings | File Templates.
 */
package core.controller {
import core.behaviors.BehaviorBase;
import core.model.Field;
import core.model.ObjectBase;
import core.utils.CollectionUtils;
import core.utils.DisplayObjectUtil;
import core.utils.phys.PhysEngineConnector;
import core.view.FieldView;

import flash.geom.Point;


public class FieldController extends ControllerBase{

    protected var _controllers:Vector.<ControllerBase>;

    public function FieldController(object:Field) {
        _object = object;
        super();
    }

    public static function create(obj:Field, behaviors:Vector.<BehaviorBase> = null):FieldController{
        var c:FieldController = new FieldController(obj);
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }
        return c;
    }


    override protected function init():void {
        super.init();

        _controllers = new Vector.<ControllerBase>();
        PhysEngineConnector.instance.initField(this);

        add(this);
    }

    override public function draw():void{
        super.draw();

        for each(var p:ControllerBase in _controllers){
            if(p == this)
                continue;

            p.draw();
            _view.addChild(p.view);
        }
    }

    override protected function initContent():void{
        _view ||= new FieldView(_object.createAsset());
        (_view as FieldView).draw();
    }

    public function add(c:ControllerBase):void{
        PhysEngineConnector.instance.addObjectToField(this, c.object);
        _controllers.push(c);
        c.startBehaviors();
    }

    public function remove(c:ControllerBase):void{
        c.stopBehaviors();

        PhysEngineConnector.instance.destroyObject(c.object);
        CollectionUtils.removeElement(_controllers, c);
        DisplayObjectUtil.tryRemove(c.view);
    }

    public function destroy():void{
        while(_controllers.length != 0){
            remove(_controllers[0]);
        }

        clear();
        PhysEngineConnector.instance.destroyField(this);
    }

    public function doStep(step:Number, debugView:* = null):void{
        for each(var p:ControllerBase in _controllers){
            p.doBehaviorsStep(step);
            p.object.applyTerrainFriction(0.2, 0.01, step);
        }

        PhysEngineConnector.instance.doStep(this, step, debugView);
    }

    public function getControllerByObject(obj:ObjectBase):ControllerBase{
        for each(var p:ControllerBase in _controllers){
            if(p.object == obj)
                return p;
        }

        return null;
    }

    public function getControllerByBehavior(b:BehaviorBase):ControllerBase{
        for each(var p:ControllerBase in _controllers){
            if(p.hasBehavior(b))
                return p;
        }

        return null;
    }

    public function getControllersByBehaviorClass(bClass:Class):Vector.<ControllerBase>{
        return _controllers.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e.getBehaviorByClass(bClass);
        });
    }

    public function getControllersByClass(cls:Class):Vector.<ControllerBase>{
        return _controllers.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e is cls;
        });
    }


}
}
