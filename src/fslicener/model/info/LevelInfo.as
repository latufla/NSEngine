/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info {
import fslicener.model.info.WaveInfo;

public class LevelInfo {

    private var _waves:Vector.<WaveInfo>;
    public function LevelInfo(params:Object) {
        init(params);
    }

    private function init(params:Object):void {
        _waves = new Vector.<WaveInfo>();
        var n:uint = params.length;
        for(var i:uint = 0; i < n; i++){
            _waves.push(new WaveInfo(params[i]));
        }
    }

    public function toString():String{
        return _waves.toString();
    }
}
}
