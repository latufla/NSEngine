/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:27
 * To change this template use File | Settings | File Templates.
 */
package core.controller {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;
import core.utils.CollectionUtils;
import core.utils.DisplayObjectUtil;
import core.view.ViewBase;


public class ControllerBase {

    protected var _view:ViewBase;
    protected var _object:ObjectBase;

    protected var _behaviors:Vector.<BehaviorBase>;

    public function ControllerBase() {
        init();
    }

    protected function init():void {
        _behaviors ||= new Vector.<BehaviorBase>();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):ControllerBase{
        var c:ControllerBase = new ControllerBase();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }

    public function addBehavior(b:BehaviorBase):void{
        _behaviors.push(b);
    }

    public function removeBehavior(b:BehaviorBase):void{
        b.stop();
        CollectionUtils.removeElement(b, _behaviors);
    }

    public function startBehaviors():void{
        for each(var p:BehaviorBase in _behaviors){
            p.start(this);
        }
    }

    public function startBehaviorByClass(bClass:Class):void{
        var b:BehaviorBase = getBehaviorByClass(bClass);
        if(b)
            b.start(this);
    }

    public function stopBehaviors():void{
        for each(var p:BehaviorBase in _behaviors){
            p.stop();
        }
    }

    public function doBehaviorsStep(step:Number):void{
        for each(var p:BehaviorBase in _behaviors){
            p.doStep(step);
        }
    }

    public function getBehaviorByClass(bClass:Class):BehaviorBase{
        for each(var p:BehaviorBase in _behaviors){
            if(p is bClass)
                return p;
        }

        return null;
    }

    // not class but concrete behavior
    public function hasBehavior(b:BehaviorBase):Boolean{
        return _behaviors.indexOf(b) != -1;
    }


    public function draw():void{
        if(!_object)
            return;

        initContent();

        if(shouldRedrawContent)
            redrawContent();

        align();
    }

    protected function initContent():void {
        _view ||= new ViewBase(_object.createAsset());
    }

    protected function get shouldRedrawContent():Boolean{
        return false;
    }

    protected function redrawContent():void {

    }

    protected function align():void{
        _view.position = _object.position;

        _view.pivotX = (_view.width / 2) / _view.scaleX; // always center point, unconnected to phys
        _view.pivotY =  (_view.height / 2) / _view.scaleY;

        // change _view width  when override if needed
    }

    public function clear():void{
        DisplayObjectUtil.removeAll(_view);
    }

    public function get view():ViewBase {
        return _view;
    }

    public function set view(value:ViewBase):void {
        _view = value;
    }

    public function get object():ObjectBase {
        return _object;
    }

    public function set object(value:ObjectBase):void {
        _object = value;
    }
}
}
