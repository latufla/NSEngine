/**
 * Created with IntelliJ IDEA.
 * User: Васильев
 * Date: 01.06.13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info.quest {

public class QuestInfo {

    // get all rewards after finishing last goal
    private var _goals:Vector.<QuestGoalInfo>;
    private var _rewards:Vector.<QuestRewardInfo>;

    public function QuestInfo() {
        init();
    }

    private function init():void {
        _goals = new <QuestGoalInfo>[new QuestGoalInfo()];
        _rewards = new <QuestRewardInfo>[new QuestRewardInfo()];
    }

    public function process(action:String, target:Class):void{
        if(finished)
            return;

        if(!completed){
            var gs:Vector.<QuestGoalInfo> = incompleteGoals;
            gs.forEach(function(item:QuestGoalInfo, index:uint, vector:Vector.<QuestGoalInfo>):void{
                if(item.action == action && item.target == target)
                    item.doneCount++;
            });
        }

        if(completed){
            // awards rewards
            var rs:Vector.<QuestRewardInfo> = notAwardedRewards;
            rs.forEach(function(item:QuestRewardInfo, index:uint, vector:Vector.<QuestRewardInfo>):void{
                item.awarded = true;
            });
        }
    }

    public function get goals():Vector.<QuestGoalInfo> {
        return _goals;
    }

    public function set goals(value:Vector.<QuestGoalInfo>):void {
        _goals = value;
    }

    public function get rewards():Vector.<QuestRewardInfo> {
        return _rewards;
    }

    public function set rewards(value:Vector.<QuestRewardInfo>):void {
        _rewards = value;
    }

    public function get completed():Boolean{
        return incompleteGoals.length == 0;
    }

    public function get finished():Boolean{
        return completed && notAwardedRewards.length == 0;
    }

    protected function get incompleteGoals():Vector.<QuestGoalInfo>{
        return _goals.filter(function(item:QuestGoalInfo, index:uint, vector:Vector.<QuestGoalInfo>):Boolean{
            return !item.completed;
        });
    }

    protected function get notAwardedRewards():Vector.<QuestRewardInfo>{
        return _rewards.filter(function(item:QuestRewardInfo, index:uint, vector:Vector.<QuestRewardInfo>):Boolean{
            return !item.awarded;
        });
    }

}
}
