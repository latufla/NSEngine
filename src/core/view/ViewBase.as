/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:32
 * To change this template use File | Settings | File Templates.
 */
package core.view {
import core.utils.graphic.GraphicsEngineConnector;

import flash.display.Bitmap;

import flash.geom.Point;
import flash.geom.Rectangle;


public class ViewBase {

    protected var _name:String;
    protected var _texture:Bitmap;
    public function ViewBase(texture:Bitmap = null) {
        _texture = texture;
        init();
    }

    protected function init():void{
        GraphicsEngineConnector.instance.initView(this, _texture);
    }

    public function addChild(child:ViewBase):void{
        GraphicsEngineConnector.instance.addChild(this, child);
    }

    public function removeChild(child:ViewBase):void{
        if(child is SequenceView)
            (child as SequenceView).stop();

        GraphicsEngineConnector.instance.removeChild(child);
    }

    public function removeChildAt(index:uint):void{
        var removedChild:ViewBase = GraphicsEngineConnector.instance.removeChildAt(this, index);
        if(removedChild is SequenceView)
            (removedChild as SequenceView).stop();
    }

    public function get parent():ViewBase{
        return GraphicsEngineConnector.instance.getParent(this);
    }

    public function get numChildren():uint{
        return GraphicsEngineConnector.instance.getNumChildren(this);
    }

    // POSITION
    public function get x():Number{
        return  GraphicsEngineConnector.instance.getX(this);
    }

    public function set x(value:Number):void{
        GraphicsEngineConnector.instance.setX(this, value);
    }

    public function get y():Number{
        return  GraphicsEngineConnector.instance.getY(this);
    }

    public function set y(value:Number):void{
        GraphicsEngineConnector.instance.setY(this, value);
    }

    public function get position():Point{
        return  GraphicsEngineConnector.instance.getPosition(this);
    }

    public function set position(value:Point):void{
        GraphicsEngineConnector.instance.setPosition(this, value);
    }
    // END POSITION


    // SIZE
    public function get width():Number{
        return  GraphicsEngineConnector.instance.getWidth(this);
    }

    public function set width(value:Number):void{
        GraphicsEngineConnector.instance.setWidth(this, value);
    }

    public function get height():Number{
        return  GraphicsEngineConnector.instance.getHeight(this);
    }

    public function set height(value:Number):void{
        GraphicsEngineConnector.instance.setHeight(this, value);
    }

    public function get size():Rectangle{
        return  GraphicsEngineConnector.instance.getSize(this);
    }

    public function set size(value:Rectangle):void{
        GraphicsEngineConnector.instance.setSize(this, value);
    }
    // END SIZE


    // ROTATION
    public function get rotation():Number{
        return  GraphicsEngineConnector.instance.getRotation(this);
    }

    public function set rotation(value:Number):void{
        GraphicsEngineConnector.instance.setRotation(this, value);
    }
    // END ROTATION


    // PIVOT
    public function get pivotX():Number{
        return  GraphicsEngineConnector.instance.getPivotX(this);
    }

    public function set pivotX(value:Number):void{
        GraphicsEngineConnector.instance.setPivotX(this, value);
    }

    public function get pivotY():Number{
        return  GraphicsEngineConnector.instance.getPivotY(this);
    }

    public function set pivotY(value:Number):void{
        GraphicsEngineConnector.instance.setPivotY(this, value);
    }

    public function get pivot():Point{
        return  GraphicsEngineConnector.instance.getPivot(this);
    }

    public function set pivot(value:Point):void{
        GraphicsEngineConnector.instance.setPivot(this, value);
    }
    // END PIVOT

    public function get scaleX():Number{
        return  GraphicsEngineConnector.instance.getScaleX(this);
    }

    public function get scaleY():Number{
        return  GraphicsEngineConnector.instance.getScaleY(this);
    }


    public function get bounds():Rectangle{
        return GraphicsEngineConnector.instance.getBounds(this);
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }
}
}
