/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 14:42
 * To change this template use File | Settings | File Templates.
 */
package sqballs {

import core.utils.DisplayObjectUtil;
import core.utils.FPSCounter;
import core.utils.assets.AssetsLib;

import flash.display.MovieClip;
import flash.display.Sprite;

import sqballs.utils.Config;
import sqballs.utils.assets.SQAssetsHeap;


public class Engine extends Sprite{

    private var _preloader:MovieClip;
    private var _scene:SceneController;

    public function Engine() {
        init();
    }

    private function init():void {
        showPreloader();
        Config.load(onCompleteLoadConfig, onErrorLoadConfig);
    }

    private function onCompleteLoadConfig():void {
        initScene();
    }

    // we may show error screen, stop playin` etc.
    // but use default config instead
    private function onErrorLoadConfig():void {
        initScene();
    }

    private function initScene():void {
        removePreloader();

        _scene = new SceneController();
        Config.stage.addChild(new FPSCounter(5, 2));
    }

    private function showPreloader():void{
        _preloader = AssetsLib.instance.getAssetBy(SQAssetsHeap.PRELOADER_VIEW);
        _preloader.play();
        Config.stage.addChild(_preloader);
        DisplayObjectUtil.alignByCenter(_preloader, Config.DEFAULT_VIEWPORT_SIZE.width, Config.DEFAULT_VIEWPORT_SIZE.height);
    }

    private function removePreloader():void{
        _preloader.stop();
        DisplayObjectUtil.tryRemove(_preloader);
    }


}
}
