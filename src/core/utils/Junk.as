/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 01.05.13
 * Time: 13:54
 * To change this template use File | Settings | File Templates.
 */
package core.utils {
public class Junk {
    public function Junk() {
    }

//    private function onStarted(e:*):void {
//        AssetsLib.instance.init(new SQAssetsHeap());
//        new Engine();

//        AssetsLib.instance.init(new SQAssetsHeap());
//
//        var field:Field = LevelsLib.getFieldByLevel();
//        var fieldController:FieldController = FieldController.create(field);
//
//        // circle
//         var circle:ObjectBase = ObjectBase.create(new Point(100, 100), new <CustomShape>[new CustomCircle(50)], new CustomMaterial(), 1);
//        circle.libDesc = SQAssetsHeap.BALL;
//        (circle.shapes[0] as CustomCircle).radius = 30;
//
//        var circleController:ControllerBase = ControllerBase.create(circle);
//        circleController.draw();
//
//        fieldController.add(circleController);
//
//        // rect
//        var vs:Vector.<Point> = CustomPolygon.rect(new Rectangle(0, 0, 100, 100));
//        var rect:ObjectBase = ObjectBase.create(new Point(200, 100), new <CustomShape>[new CustomPolygon(vs)], new CustomMaterial(), 1);
//        rect.libDesc = SQAssetsHeap.BALL;
//
//        vs = CustomPolygon.rect(new Rectangle(0, 0, 120, 80));
//        (rect.shapes[0] as CustomPolygon).vertexes = vs;
//
//        var rectController:ControllerBase = ControllerBase.create(rect);
//        rectController.draw();
//
//        fieldController.add(rectController);
//
//        fieldController.startBehaviors();
//
//        fieldController.doStep(1/60, _debugView);
//        fieldController.draw();
//
//
//        rect.position = new Point(200, 200);
//        fieldController.doStep(1/60, _debugView);
//        fieldController.draw();
//
//        _debugView.display.alpha = 0.5;
//        addChild(_debugView.display);
//    }

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
