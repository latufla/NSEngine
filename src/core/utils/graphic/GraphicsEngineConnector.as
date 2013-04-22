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
import core.view.SequenceView;
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
import starling.display.MovieClip;


import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class GraphicsEngineConnector {

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
        _classes[SequenceView] = MovieClip;

        _starling = new Starling(StarlingSceneView, stage);
    }

    public function start(onStarted:Function):void{
        _starling.start();
        _starling.addEventListener(Event.ROOT_CREATED, onStarted);
    }

    public function stop():void{
        _starling.stop();
    }

    public function initView(view:ViewBase, texture:Bitmap = null, texture_desc:XML = null):void{
        var ViewClass:Class = _classes[(view as Object).constructor];
        if(!ViewClass)
            return;

        // sprite can be without texture
        if(!texture_desc){
            _views[view] ||= new ViewClass();

            if(texture)
                _views[view].addChild(Image.fromBitmap(texture));

            return;
        }

        // movie clip needs texture and texture_desc
        if(texture){
            var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(texture), texture_desc);
            _views[view] ||= new MovieClip(atlas.getTextures());
        }
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
        var p:DisplayObjectContainer = _views[parent] as DisplayObjectContainer;
        var c:DisplayObject = _views[child];
        if(p && c)
            p.addChild(c);
    }

    public function removeChild(child:ViewBase):void{
        var c:DisplayObject = _views[child];
        DisplayObjectUtil.tryRemove(c);
    }

    public function removeChildAt(parent:ViewBase, index:uint):void{
        var p:DisplayObjectContainer = _views[parent];
        if(p)
            p.removeChildAt(index);
    }

    public function addChildToScene(child:ViewBase):void{
        var p:DisplayObjectContainer = StarlingSceneView.instance;
        var c:DisplayObject = _views[child];
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
        var c:DisplayObject = _views[child];
        var p:DisplayObjectContainer = c.parent;
        for (var s:* in _views){
            if(_views[s] == p)
                return s;
        }
        return null;
    }


    // MOVIE CLIP
    public function playSequence(s:SequenceView):void{
        var p:MovieClip = _views[s];
        if(p){
            p.play();
            Starling.juggler.add(p);
        }
    }

    public function pauseSequence(s:SequenceView):void{
        var p:MovieClip = _views[s];
        if(p)
            p.pause();
    }

    public function stopSequence(s:SequenceView):void{
        var p:MovieClip = _views[s];
        if(p){
            p.stop();
            Starling.juggler.remove(p);
        }
    }

    public function getSequenceIsPlaying(s:SequenceView):Boolean{
        var p:MovieClip = _views[s] as MovieClip;
        return p && p.isPlaying;
    }
    // END MOVIE CLIP

}
}
