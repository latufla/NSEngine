/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 21.04.13
 * Time: 11:28
 * To change this template use File | Settings | File Templates.
 */
package core.utils.graphic {
import core.utils.DisplayObjectUtil;
import core.view.FieldView;
import core.view.ViewBase;

import flash.display.Bitmap;

import flash.display.Stage;

import flash.geom.Point;
import flash.geom.Rectangle;

import flash.utils.Dictionary;

import starling.core.Starling;

import starling.display.DisplayObject
import starling.display.DisplayObjectContainer;
import starling.display.Image;


import starling.display.Sprite;
import starling.events.Event;

public class GraphicsEngineConnector {

    public static const BALL:String = "ball";
    [Embed(source="../../../../assets/ball.png")]
    private const BallViewClass:Class

    private static var _classes:Dictionary;

    private static var _instance:GraphicsEngineConnector;

    private var _views:Dictionary; // ViewBase -> starling DisplayObject
    private var _starling:Starling;

    public function GraphicsEngineConnector() {
    }

    public static function get instance():GraphicsEngineConnector {
        _instance ||= new GraphicsEngineConnector();
        return _instance;
    }

    public function init(stage:Stage):void {
        _views = new Dictionary();

        _classes = new Dictionary();
        _classes[ViewBase] = Sprite;
        _classes[FieldView] = Sprite;

        _starling = new Starling(StarlingSceneView, stage);
    }

    public function start(onStarted:Function):void{
        _starling.start();
        _starling.addEventListener(Event.ROOT_CREATED, onStarted);
    }

    public function stop():void{
        _starling.stop();
    }

    public function initView(view:ViewBase, texture:Bitmap):void{
        var ViewClass:Class = _classes[(view as Object).constructor];
        if(!ViewClass)
            return;

        _views[view] ||= new ViewClass();

        initViewWithBitmap(view, texture);
    }

    private function initViewWithBitmap(view:ViewBase, texture:Bitmap):void{
        var v:DisplayObjectContainer = _views[view];
        if((v is Sprite) && texture)
            v.addChild(Image.fromBitmap(texture));
    }


    // POSITION
    public function getX(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.x;
    }

    public function setX(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.x = value;
    }

    public function getY(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.y;
    }

    public function setY(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.y = value;
    }

    public function getPosition(view:ViewBase):Point{
        var v:DisplayObject = _views[view];
        return new Point(v.x, v.y);
    }

    public function setPosition(view:ViewBase, pos:Point):void{
        var v:DisplayObject = _views[view];
        v.x = pos.x;
        v.y = pos.y;
    }
    // END POSITION


    // SIZE
    public function getWidth(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.width;
    }

    public function setWidth(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.width = value;
    }

    public function getHeight(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.height;
    }

    public function setHeight(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.height = value;
    }

    public function getSize(view:ViewBase):Rectangle{
        var v:DisplayObject = _views[view];
        return new Rectangle(0, 0, v.width, v.height);
    }

    public function setSize(view:ViewBase, size:Rectangle):void{
        var v:DisplayObject = _views[view];
        v.width = size.width;
        v.height = size.height;
    }
    // END SIZE


    // ROTATION
    public function getRotation(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.rotation;
    }

    public function setRotation(view:ViewBase, rotation:Number):void{
        var v:DisplayObject = _views[view];
        v.rotation = rotation;
    }
    // END ROTATION


    // PIVOT
    public function getPivotX(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.pivotX;
    }

    public function setPivotX(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.pivotX = value;
    }

    public function getPivotY(view:ViewBase):Number{
        var v:DisplayObject = _views[view];
        return v.pivotY;
    }

    public function setPivotY(view:ViewBase, value:Number):void{
        var v:DisplayObject = _views[view];
        v.pivotY = value;
    }


    public function setPivot(view:ViewBase, pivot:Point):void{
        var v:DisplayObject = _views[view];
        v.pivotX = pivot.x;
        v.pivotY = pivot.y;
    }

    public function getPivot(view:ViewBase):Point{
        var v:DisplayObject = _views[view];
        return new Point(v.pivotX, v.pivotY);
    }
    // END PIVOT


    // DISPLAY LIST
    public function getBounds(view:ViewBase):Rectangle{
        var v:DisplayObject = _views[view];
        return v.bounds;
    }

    public function addChild(parent:ViewBase, child:ViewBase):void{
        var p:DisplayObjectContainer = _views[parent];
        var c:DisplayObjectContainer = _views[child];
        if(p && c)
            p.addChild(c);
    }

    public function removeChild(child:ViewBase):void{
        var c:DisplayObjectContainer = _views[child];
        DisplayObjectUtil.tryRemove(c);
    }

    public function removeChildAt(child:ViewBase, index:uint):void{
        var c:DisplayObjectContainer = _views[child];
        if(c)
            c.removeChildAt(index);
    }

    public function addChildToScene(child:ViewBase):void{
        var p:DisplayObjectContainer = StarlingSceneView.instance;
        var c:DisplayObjectContainer = _views[child];
        if(p && c)
            p.addChild(c);
    }

    public function removeChildFromScene(child:ViewBase):void{
        var c:DisplayObjectContainer = _views[child];
        DisplayObjectUtil.tryRemove(c);
    }

    public function getNumChildren(parent:ViewBase):uint{
        var p:DisplayObjectContainer = _views[parent];
        return p.numChildren
    }

    public function getParent(child:ViewBase):ViewBase{
        var c:DisplayObjectContainer = _views[child];
        var p:DisplayObjectContainer = c.parent;
        for (var s:* in _views){
            if(_views[s] == p)
                return s;
        }
        return null;
    }

}
}
