/**
 * Created with IntelliJ IDEA.
 * User: Васильев
 * Date: 01.06.13
 * Time: 16:33
 * To change this template use File | Settings | File Templates.
 */
package fslicener.managers {
import core.utils.EventHeap;

import fslicener.model.info.quest.QuestInfo;
import fslicener.utils.quests.QuestInfoLib;

import nape.geom.Vec2;

public class QuestManager {

    private var _quests:Vector.<QuestInfo>;

    private static var _instance:QuestManager;
    public function QuestManager() {
        init();
    }

    public static function get instance():QuestManager {
        return _instance;
    }

    private function init():void {
        _quests = QuestInfoLib.quests;
    }

    public function process(action:String, target:Class):void{
        incompleteQuests.forEach(function(item:QuestInfo, index:uint, vector:Vector.<QuestInfo>):void{
            item.process(action, target);
        });
    }

    protected function incompleteQuests():Vector.<QuestInfo>{
        return _quests.filter(function(item:QuestInfo, index:uint, vector:Vector.<QuestInfo>):Boolean{
            return !item.completed;
        });
    }
}
}
