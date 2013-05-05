package {

import core.behaviors.BehaviorBase;
import core.controller.FieldController;
import core.model.Field;
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

import fslicener.behaviors.control.user.UserControlBehavior;

import fslicener.behaviors.gameplay.SliceResolveBehavior;
import fslicener.controller.FSControllerBase;
import fslicener.model.FSObjectBase;

import fslicener.utils.Config;
import fslicener.utils.assets.FSAssetsHeap;

import nape.util.BitmapDebug;

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
    private var _fruit:FSObjectBase;
    private var _fruitC:FSControllerBase;
    private var _view:BitmapDebug;
    private function onStarted(e:*):void {
//        new SQEngine();

        AssetsLib.instance.init(new FSAssetsHeap());

        var asset:Bitmap = AssetsLib.instance.getAssetBy(FSAssetsHeap.LEVEL_BORDERS_1);
        var field:Field = new Field(asset.bitmapData);
        field.libDesc = FSAssetsHeap.LEVEL_1;
        _fieldC = FieldController.create(field);
        _fieldC.addBehaviorsPack(new <BehaviorBase>[new UserControlBehavior(), new SliceResolveBehavior()]);
        _fieldC.startBehaviors();

        _fruit = FSObjectBase.fromBitmapData(new Point(150, 130), Bitmap(new AppleViewClass()).bitmapData, new CustomMaterial(), 1);
        _fruit.libDesc = FSAssetsHeap.APPLE;
        _fruit.rotation = Math.PI / 4;
        _fruitC = FSControllerBase.create(_fruit);
        _fieldC.add(_fruitC);


        _view = new BitmapDebug(1024, 768);
        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
        _view.display.alpha = 0.5;
        addChild(_view.display);

        stage.addEventListener(Event.ENTER_FRAME, onEF);

        var view:Bitmap = AssetsLib.instance.getAssetBy(FSAssetsHeap.APPLE);
        var appleView:ViewBase = new ViewBase(view);

        var slicesApple:Vector.<ViewBase> = appleView.splitByLine(new Point(0, 30), new Point(70, 99));
        _fieldC.view.addChild(slicesApple[0]);
        _fieldC.view.addChild(slicesApple[1]);

        var line:Sprite = new Sprite();
        with(line.graphics){
            beginFill(0xFF0000);
            lineStyle(1, 0xFF0000);
            moveTo(0, 0);
            lineTo(250, 210);
            moveTo(0, 250);
            lineTo(250, 0);
            endFill();
        }
        addChild(line);
    }

    private function onEF(e:Event):void {
        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
    }
}
}
