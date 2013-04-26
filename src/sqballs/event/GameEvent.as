/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
package sqballs.event {
import core.event.CustomEvent;

public class GameEvent extends CustomEvent{

    public static var NEED_BRAWL:String = "needBrawl";
    public static var NEED_BRAWL_RESULT:String = "needBrawlResult";

    public function GameEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false){
        super(type, data, bubbles, cancelable);
    }
}
}
