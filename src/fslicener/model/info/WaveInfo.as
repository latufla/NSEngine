/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info {
public class WaveInfo {

    private var _objects:Vector.<WaveObjectInfo>;
    public function WaveInfo(params:Object) {
        init(params);
    }

    private function init(params:Object):void {
        _objects = new Vector.<WaveObjectInfo>();
        var n:uint = params.length;
        for (var i:uint = 0; i < n; i++){
            _objects.push(new WaveObjectInfo(params[i]));
        }
    }

    public function toString():String{
        return _objects.toString();
    }
}
}
