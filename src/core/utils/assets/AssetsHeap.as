/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 26.04.13
 * Time: 11:11
 * To change this template use File | Settings | File Templates.
 */
package core.utils.assets {
public class AssetsHeap {

    protected var _assets:Array/* String -> Class */;
    protected var _assetsDesc:Array/* String -> XML */;

    public function AssetsHeap() {
        init();
    }

    protected function init():void {
        _assets = [];
        _assetsDesc = [];
    }

    public function get assets():Array {
        return _assets;
    }

    public function get assetsDesc():Array {
        return _assetsDesc;
    }
}
}
