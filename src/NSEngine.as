package {

import core.controller.ControllerBase;
import core.controller.FieldController;
import core.model.Field;
import core.model.ObjectBase;
import core.utils.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import core.utils.phys.CustomCircle;
import core.utils.phys.CustomMaterial;
import core.utils.phys.CustomPolygon;
import core.utils.phys.CustomShape;
import core.view.AnimatedView;
import core.view.FieldView;
import core.view.SequenceView;
import core.view.ViewBase;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import nape.util.BitmapDebug;


public class NSEngine extends Sprite {

    private var _debugView:BitmapDebug = new BitmapDebug(700, 700);

    public function NSEngine() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        GraphicsEngineConnector.instance.init(stage);
        GraphicsEngineConnector.instance.start(onStarted);
    }

    private function onStarted(e:*):void {
        var borders:Bitmap = AssetsLib.instance.getAssetBy(AssetsLib.LEVEL_BORDERS_1);
        var field:Field = new Field(borders.bitmapData);
        field.libDesc = AssetsLib.LEVEL_1;

        var fieldController:FieldController = FieldController.create(field);

        // circle
        var circle:ObjectBase = ObjectBase.create(new Point(100, 100), new <CustomShape>[new CustomCircle(50)], new CustomMaterial(), 1);
        circle.libDesc = AssetsLib.BALL;
        (circle.shapes[0] as CustomCircle).radius = 30;
        circle.updateShapes();

        var circleController:ControllerBase = ControllerBase.create(circle);
        circleController.draw();

        fieldController.add(circleController);

        // rect
        var rect:ObjectBase = ObjectBase.create(new Point(200, 100), new <CustomShape>[new CustomPolygon(0, 0, 100, 100)], new CustomMaterial(), 1);
        rect.libDesc = AssetsLib.BALL;
        (rect.shapes[0] as CustomPolygon).size = new Rectangle(0, 0, 70, 100);
        rect.updateShapes();

        var rectController:ControllerBase = ControllerBase.create(rect);
        rectController.draw();

        fieldController.add(rectController);

        fieldController.startBehaviors();

        fieldController.doStep(1/60, _debugView);
        fieldController.draw();


        rect.position = new Point(200, 200);
        fieldController.doStep(1/60, _debugView);
        fieldController.draw();

        _debugView.display.alpha = 0.5;
        addChild(_debugView.display);
    }

//    private function onStarted(e:*):void {
//
//        var asset:Bitmap = AssetsLib.instance.getAssetBy(AssetsLib.LEVEL_1);
//        var field:FieldView = new FieldView(asset);
//        field.draw();
//
//        asset = AssetsLib.instance.getAssetBy(AssetsLib.BALL);
//        var view:ViewBase = new ViewBase(asset);
//
//        field.addChild(view);
//
//        view.x = 75;
//        view.y = 75;
//        view.pivotX = 50;
//        view.pivotY = 50;
//
//        view.width = 150;
//        view.height = 150;
//
//        var aL:AssetsLib = AssetsLib.instance;
//
//        var sequence:SequenceView = new SequenceView(aL.getAssetBy(AssetsLib.RAT_RUN), aL.getDescBy(AssetsLib.RAT_RUN))
//        var animatedView:AnimatedView = new AnimatedView();
//        animatedView.addAnimation("ratRun", sequence);
//
//        var sequence2:SequenceView = new SequenceView(aL.getAssetBy(AssetsLib.RAT_MOVE), aL.getDescBy(AssetsLib.RAT_MOVE))
//        animatedView.addAnimation("ratMove", sequence2);
//
//        animatedView.gotoAndPlay("ratRun");
//        animatedView.gotoAndPlay("ratRun");
//        animatedView.gotoAndPlay("ratMove");
//
//        field.addChild(animatedView);
////        sequence.play();
//
////        trace(field.removeChildAt(2));
////        field.removeChild(sequence);
//        trace(sequence.isPlaying, sequence2.isPlaying);
//
////        field.pivot = new Point(300, 300);
////        field.rotation = Math.PI / 2;
//
//        trace(view.bounds, view.parent, field.parent, field.numChildren);
//    }
}
}
