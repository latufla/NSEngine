/**
 * Created with IntelliJ IDEA.
 * User: Васильев
 * Date: 01.06.13
 * Time: 16:23
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info.quest {
public class QuestRewardInfo {

    private var _points:uint = 20;
    private var _awarded:Boolean;

    public function QuestRewardInfo() {
    }

    public function get points():uint {
        return _points;
    }

    public function set points(value:uint):void {
        _points = value;
    }

    public function get awarded():Boolean {
        return _awarded;
    }

    public function set awarded(value:Boolean):void {
        _awarded = value;
    }
}
}
