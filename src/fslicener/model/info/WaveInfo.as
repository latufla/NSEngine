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
    public function WaveInfo() {
    }

    public static function create(params:Object = null):WaveInfo{
        var res:WaveInfo = new WaveInfo();
        res.objects = new Vector.<WaveObjectInfo>();
        if(!params)
            return res;

        var n:uint = params.length;
        for (var i:uint = 0; i < n; i++){
            res.objects.push(WaveObjectInfo.create(params[i]));
        }
        return res;
    }

    public function clone():WaveInfo{
        var res:WaveInfo = WaveInfo.create();
        var n:uint = _objects.length;
        for (var i:uint = 0; i < n; i++){
            res.objects.push(_objects[i].clone());
        }
        return res;
    }

    public function toString():String{
        return _objects.toString();
    }

    public function get objects():Vector.<WaveObjectInfo> {
        return _objects;
    }

    public function set objects(value:Vector.<WaveObjectInfo>):void {
        _objects = value;
    }
}
}
