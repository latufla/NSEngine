/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 15:47
 * To change this template use File | Settings | File Templates.
 */
package fslicener.utils {
import fslicener.model.info.LevelInfo;

public class LevelInfoLib {

    public static function getLevelInfoById(id:uint = 0):LevelInfo{
        return getDemoLevelInfo();
    }

    public static function getDemoLevelInfo():LevelInfo {
        var source:String = '[' +
                '[{"name": "apple", "position": "100:200", "impulse":"10:0", "angularImpulse":"25", "points":"20", "timeout": "1"},' +
                '{"name": "apple", "position": "700:200", "impulse":"-10:0", "angularImpulse":"-25", "points":"20", "timeout": "1"}],' +

                '[{"name": "apple", "position":"100:200", "impulse":"100:100", "angularImpulse":"20", "points":"20", "timeout": "1"},' +
                '{"name": "apple", "position":"100:200", "impulse":"100:100", "angularImpulse":"20", "points":"20", "timeout": "5"},' +
                '{"name": "apple", "position":"100:200", "impulse":"100:100", "angularImpulse":"20", "points":"20", "timeout": "10"}]' +
                ']';

        var json:Object = JSON.parse(source);
        var res:LevelInfo = LevelInfo.create(json);
        return res;
    }
}
}
