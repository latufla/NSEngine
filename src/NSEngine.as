package {

import core.controller.ControllerBase;
import core.controller.FieldController;
import core.model.Field;
import core.model.ObjectBase;
import core.utils.DisplayObjectUtil;
import core.utils.assets.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import core.utils.phys.CustomMaterial;
import core.view.ViewBase;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
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

    private var _fieldC:FieldController;
    private var _fruit:ObjectBase;
    private var _view:BitmapDebug;
    private function onStarted(e:*):void {
//        new SQEngine();

        AssetsLib.instance.init(new SQAssetsHeap());

        var asset:Bitmap = AssetsLib.instance.getAssetBy(SQAssetsHeap.LEVEL_BORDERS_1);
        var field:Field = new Field(asset.bitmapData);
        field.libDesc = SQAssetsHeap.LEVEL_1;
        _fieldC = FieldController.create(field);

        _fruit = ObjectBase.fromBitmapData(new Point(150, 150), Bitmap(new AppleViewClass()).bitmapData, new CustomMaterial(), 1);
        var fruitC:ControllerBase = ControllerBase.create(_fruit);
        _fieldC.add(fruitC);

        _view = new BitmapDebug(1024, 768);
        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
        _view.display.alpha = 0.5;
        addChild(_view.display);

        stage.addEventListener(MouseEvent.CLICK, onClick);

        var view:Bitmap = AssetsLib.instance.getAssetBy(SQAssetsHeap.APPLE);
        var appleView:ViewBase = new ViewBase(view);


        var slicesApple:Vector.<ViewBase> = appleView.splitByLine(new Point(0, 30), new Point(70, 99));
        _fieldC.view.addChild(slicesApple[0]);
        _fieldC.view.addChild(slicesApple[1]);
    }

    var i:int = 0;
    private function onClick(e:MouseEvent):void {
        var objects:Vector.<ObjectBase> = _fruit.splitByLine(new Point(0, 0), new Point(250, 250));

        objects.shift();
        if(objects.length == 0)
            return;

        var sC:ControllerBase = ControllerBase.create(objects[0]);
       _fieldC.add(sC);

        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
    }
}
}
