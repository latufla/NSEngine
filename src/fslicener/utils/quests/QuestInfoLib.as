/**
 * Created with IntelliJ IDEA.
 * User: Васильев
 * Date: 01.06.13
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */
package fslicener.utils.quests {
import fslicener.model.info.quest.QuestInfo;

public class QuestInfoLib {

    public static function get quests():Vector.<QuestInfo>{
        var res:Vector.<QuestInfo> = new <QuestInfo>[new QuestInfo()];
        return res;
    }

}
}
