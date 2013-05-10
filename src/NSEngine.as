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
import fslicener.behaviors.gameplay.GameProcessBehavior;

import fslicener.behaviors.gameplay.SliceResolveBehavior;
import fslicener.controller.FSControllerBase;
import fslicener.controller.FSFieldController;
import fslicener.model.FSField;
import fslicener.model.FSObjectBase;
import fslicener.model.info.LevelInfo;
import fslicener.model.info.UserInfo;

import fslicener.utils.Config;
import fslicener.utils.LevelInfoLib;
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
        var field:FSField = new FSField(asset.bitmapData);
        field.libDesc = FSAssetsHeap.LEVEL_1;
        _fieldC = FSFieldController.create(field);
        _fieldC.addBehaviorsPack(new <BehaviorBase>[new UserControlBehavior(), new SliceResolveBehavior(), new GameProcessBehavior(new UserInfo())]);
        _fieldC.startBehaviors();

//        _fruit = FSObjectBase.fromBitmapData(new Point(150, 130), Bitmap(new AppleViewClass()).bitmapData, new CustomMaterial(), 1);
//        _fruit.libDesc = FSAssetsHeap.APPLE;
//        _fruit.rotation = Math.PI / 4;
//        _fruitC = FSControllerBase.create(_fruit);
//        _fieldC.add(_fruitC);


        _view = new BitmapDebug(1024, 768);
        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
        _view.display.alpha = 0.5;
        addChild(_view.display);

        stage.addEventListener(Event.ENTER_FRAME, onEF);

        var lI:LevelInfo = LevelInfoLib.getLevelInfoById();
        var clonedLI:LevelInfo = lI.clone();
        trace(clonedLI);
    }

    private function onEF(e:Event):void {
        _fieldC.doStep(1/ 60, _view);
        _fieldC.draw();
    }
}
}
