/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import flash.display.Sprite;

public class FlashAssetsLib {

    public static const DIALOG_WINDOW:String = "dialogWindow";
    [Embed(source="../../../assets/gui/GUI.swf", symbol="DialogWindowView")]
    private const DialogWindowClass:Class;

    public static const REFRESH_BUTTON:String = "refreshButton";
    [Embed(source="../../../assets/gui/GUI.swf", symbol="RefreshButton")]
    private const RefreshViewClass:Class;

    public static const PRELOADER_VIEW:String = "preloaderView";
    [Embed(source="../../../assets/gui/GUI.swf", symbol="PreloaderView")]
    private const PreloaderViewClass:Class;

    private var _assets:Array/* String -> MovieClip`s */;

    private static var _instance:FlashAssetsLib;
    public function FlashAssetsLib() {
        init();
    }

    public static function get instance():FlashAssetsLib{
        _instance ||= new FlashAssetsLib();
        return _instance;
    }

    private function init():void {
        _assets = [];
        _assets[DIALOG_WINDOW] = DialogWindowClass;
        _assets[REFRESH_BUTTON] = RefreshViewClass;
        _assets[PRELOADER_VIEW] = PreloaderViewClass;
    }

    public function getAssetClassBy(name:String):Class{
        var asset:Class;
        try{
            asset = _assets[name];
        } catch (e:Error){
            trace("FlashAssetsLib -> getAssetBy(): no asset class with name: " + name);
        }

        return asset;
    }

    public function createAssetBy(className:String):*{
        var asset:Class = getAssetClassBy(className);
        return new asset() as Sprite;
    }
}
}
