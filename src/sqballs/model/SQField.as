/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 29.04.13
 * Time: 18:50
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.model.Field;

import flash.display.BitmapData;

import sqballs.model.info.BotInfo;

import sqballs.model.info.UserInfo;

public class SQField extends Field{
    protected var _racers:Vector.<UserInfo>;

    public function SQField(border:BitmapData, racers:Vector.<UserInfo>) {
        super(border);
        _racers = racers;
    }

    public function get player():UserInfo{
        var res:Vector.<UserInfo> = _racers.filter(function (e:UserInfo, i:int, v:Vector.<UserInfo>):Boolean{
            return !(e is BotInfo);
        });

        if(res.length > 0)
            return res[0];

        return null;
    }

    public function get racers():Vector.<UserInfo> {
        return _racers;
    }
}
}
