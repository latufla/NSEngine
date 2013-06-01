/**
 * Created with IntelliJ IDEA.
 * User: Васильев
 * Date: 01.06.13
 * Time: 16:23
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info.quest {
import fslicener.model.FSObjectBase;

public class QuestGoalInfo {

    public static var SLICE:String = "slice";

    private var _action:String = SLICE;
    private var _needCount:uint = 5;
    // action with any object of this class
    private var _target:Class = FSObjectBase;

    private var _doneCount:uint = 0;

    public function QuestGoalInfo() {
    }

    public function get action():String {
        return _action;
    }

    public function set action(value:String):void {
        _action = value;
    }

    public function get target():Class {
        return _target;
    }

    public function set target(value:Class):void {
        _target = value;
    }

    public function get needCount():uint {
        return _needCount;
    }

    public function set needCount(value:uint):void {
        _needCount = value;
    }

    public function get doneCount():uint {
        return _doneCount;
    }

    public function set doneCount(value:uint):void {
        _doneCount = value;
    }

    public function get completed():Boolean{
        return _doneCount >= _needCount;
    }
}
}
