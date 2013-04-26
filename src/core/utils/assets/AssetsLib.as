/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package core.utils.assets {

import flash.display.Bitmap;

public class AssetsLib {

    private var _heap:AssetsHeap;

    private static var _instance:AssetsLib;
    public function AssetsLib() {
    }

    public static function get instance():AssetsLib {
        _instance ||= new AssetsLib();
        return _instance;
    }

    public function init(heap:AssetsHeap):void{
        _heap = heap;
    }

    public function getAssetBy(name:String):Bitmap{
        var asset:Bitmap;
        try{
            asset = new _heap.assets[name]();
        } catch (e:Error){
            trace("AssetsLib -> getAssetBy(): no asset with name: " + name);
        }

        return asset;
    }

    public function getDescBy(name:String):XML{
        var desc:XML;
        try{
            desc = XML(new _heap.assetsDesc[name]());
        } catch (e:Error){
            trace("AssetsLib -> getDescBy(): no desc with name: " + name);
        }

        return desc;
    }
}
}
