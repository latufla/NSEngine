package {

import core.utils.assets.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import nape.util.BitmapDebug;

import sqballs.SQEngine;

import sqballs.utils.Config;
import sqballs.utils.assets.SQAssetsHeap;


[SWF(width="1024", height="768", backgroundColor="#000000", frameRate="60")]
public class NSEngine extends Sprite {

    private var _debugView:BitmapDebug = new BitmapDebug(700, 700);

    public function NSEngine() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        Config.stage = stage;

        GraphicsEngineConnector.instance.init(stage);
        GraphicsEngineConnector.instance.start(onStarted);
    }

    private function onStarted(e:*):void {

        new SQEngine();
    }
}
}
