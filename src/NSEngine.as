package {

import core.controller.ControllerBase;
import core.controller.FieldController;
import core.model.Field;
import core.model.ObjectBase;
import core.utils.assets.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import core.utils.phys.CustomMaterial;
import core.view.FieldView;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Point;

import nape.util.BitmapDebug;

import sqballs.SQEngine;
import sqballs.utils.Config;
import sqballs.utils.LevelsLib;
import sqballs.utils.assets.SQAssetsHeap;


[SWF(width="1024", height="768", backgroundColor="#000000", frameRate="60")]
public class NSEngine extends Sprite {

    [Embed(source="../assets/fruits/appleBorders.png")]
    private const AppleViewClass:Class;

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
//        new SQEngine();

        AssetsLib.instance.init(new SQAssetsHeap());

        var asset:Bitmap = AssetsLib.instance.getAssetBy(SQAssetsHeap.LEVEL_BORDERS_1);
        var field:Field = new Field(asset.bitmapData);
        field.libDesc = SQAssetsHeap.LEVEL_1;
        var fieldController:FieldController = FieldController.create(field);

        var fruit:ObjectBase = ObjectBase.fromBitmapData(new Point(150, 150), Bitmap(new AppleViewClass()).bitmapData, new CustomMaterial(), 1);
        var fruitC:ControllerBase = ControllerBase.create(fruit);
        fieldController.add(fruitC);

        fieldController.draw();

        var view:BitmapDebug = new BitmapDebug(1024, 768);
        fieldController.doStep(1/ 60, view);
        view.display.alpha = 0.5;
        addChild(view.display);
    }
}
}
