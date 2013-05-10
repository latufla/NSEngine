/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info {

public class LevelInfo {

    private var _waves:Vector.<WaveInfo>;
    public function LevelInfo() {
    }

    public static function create(params:Object = null):LevelInfo{
        var res:LevelInfo = new LevelInfo();
        res.waves = new Vector.<WaveInfo>();
        if(!params)
            return res;

        var n:uint = params.length;
        for(var i:uint = 0; i < n; i++){
            res.waves.push(WaveInfo.create(params[i]));
        }
        return res;
    }

    public function clone():LevelInfo{
        var res:LevelInfo = LevelInfo.create();
        var n:uint = _waves.length;
        for (var i:uint = 0; i < n; i++){
            res.waves.push(_waves[i].clone());
        }
        return res;
    }

    public function toString():String{
        return _waves.toString();
    }

    public function get waves():Vector.<WaveInfo> {
        return _waves;
    }

    public function set waves(value:Vector.<WaveInfo>):void {
        _waves = value;
    }
}
}
