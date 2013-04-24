/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 22.04.13
 * Time: 14:06
 * To change this template use File | Settings | File Templates.
 */
package core.utils {
public class CollectionUtils {

    public static function getKeys(c:*):Array{
        var res:Array = [];
        for(var p:* in c){
            res.push(p);
        }
        return res;
    }

    public static function getValues(c:*):Array{
        var res:Array = [];
        for each(var p:* in c){
            res.push(p);
        }
        return res;
    }

    public static function getKeyByValue(c:*, value:*):*{
        for (var s:* in c){
            if(c[s] == value)
                return s;
        }
        return null;
    }

    public static function removeElement(v:*, e:*):void{
        if(!v)
            return;

        var idx:int = v.indexOf(e);
        if(idx != -1)
            v.splice(idx, 1);
    }
}
}
