package {

import core.utils.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import core.view.FieldView;
import core.view.ViewBase;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;


public class NSEngine extends Sprite {
    public function NSEngine() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void {
        GraphicsEngineConnector.instance.init(stage);
        GraphicsEngineConnector.instance.start(onStarted);
    }

    private function onStarted(e:*):void {

        var asset:Bitmap = AssetsLib.instance.getAssetBy(AssetsLib.LEVEL_1);
        var field:FieldView = new FieldView(asset);
        field.draw();

        asset = AssetsLib.instance.getAssetBy(AssetsLib.BALL);
        var view:ViewBase = new ViewBase(asset);

        field.addChild(view);

        view.x = 75;
        view.y = 75;
        view.pivotX = 50;
        view.pivotY = 50;

        view.width = 150;
        view.height = 150;

//        field.removeChild(view);

//        field.pivot = new Point(300, 300);
//        field.rotation = Math.PI / 2;

        trace(view.bounds, view.parent, field.parent, field.numChildren);
    }
}
}
