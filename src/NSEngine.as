package {

import core.utils.AssetsLib;
import core.utils.graphic.GraphicsEngineConnector;
import core.view.AnimatedView;
import core.view.FieldView;
import core.view.SequenceView;
import core.view.ViewBase;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.events.Event;


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

        var aL:AssetsLib = AssetsLib.instance;

        var sequence:SequenceView = new SequenceView(aL.getAssetBy(AssetsLib.RAT_RUN), aL.getDescBy(AssetsLib.RAT_RUN))
        var animatedView:AnimatedView = new AnimatedView();
        animatedView.addAnimation("ratRun", sequence);

        var sequence2:SequenceView = new SequenceView(aL.getAssetBy(AssetsLib.RAT_MOVE), aL.getDescBy(AssetsLib.RAT_MOVE))
        animatedView.addAnimation("ratMove", sequence2);

        animatedView.gotoAndPlay("ratRun");
        animatedView.gotoAndPlay("ratRun");
        animatedView.gotoAndPlay("ratMove");

        field.addChild(animatedView);
//        sequence.play();

//        trace(field.removeChildAt(2));
//        field.removeChild(sequence);
        trace(sequence.isPlaying, sequence2.isPlaying);

//        field.pivot = new Point(300, 300);
//        field.rotation = Math.PI / 2;

        trace(view.bounds, view.parent, field.parent, field.numChildren);
    }
}
}
