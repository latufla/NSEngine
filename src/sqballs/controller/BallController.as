/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 27.03.13
 * Time: 8:47
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;
import core.utils.DisplayObjectUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;

import sqballs.model.Ball;

import starling.display.DisplayObject;
import starling.display.Image;

public class BallController extends SQControllerBase{

    private var _initialContentView:DisplayObject;
    private var _prevColor:uint;

    public function BallController() {
        super();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):BallController{
        var c:BallController = new BallController();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }

    // TODO: pool of initial ball views
    // used PixelMask to overlay initial ball, but
    // was performance lack on weak laptops, when more than 10 balls
    // http://wiki.graphic-framework.org/extensions/pixelmask
//    override protected function redrawContent():void{
//        _initialContentView ||= _view.asset as DisplayObject;
//        clear();
//
//        var b:Ball = _object as Ball;
        // draw skin bigger, than ball
//        var bd:BitmapData = DisplayObjectUtil.createCircle(new Point(b.pivotX, b.pivotY), Ball.DEFAULT_RADIUS, b.color);
//        var ballImage:Image = Image.fromBitmap(new Bitmap(bd, "auto", true));
//        _view.addChild(ballImage);
//
//        _prevColor = b.color;
//    }

    override protected function align():void{
        super.align();

        var b:Ball = _object as Ball;
        _view.width = b.rectSize.width;
        _view.height = b.rectSize.height;
    }

//    override protected function get shouldRedrawContent():Boolean{
//        var b:Ball = _object as Ball;
//        if(b)
//            return _prevColor != b.color;
//
//        return false;
//    }
}
}
