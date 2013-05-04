/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 17.02.13
 * Time: 13:54
 * To change this template use File | Settings | File Templates.
 */
package core.utils {
import core.utils.phys.CustomPolygon;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class DisplayObjectUtil {

    public static function tryRemove(view:*):void{
        if(view && view.parent)
            view.parent.removeChild(view);
    }

    public static function removeAll(view:*):void{
        while(view.numChildren != 0)
            view.removeChildAt(0);
    }

    public static function createCircle(center:Point, radius:uint, color:uint):BitmapData{
        var c:Shape = new Shape();
        c.graphics.beginFill(color, 1);
        c.graphics.drawCircle(center.x, center.y, radius);
        c.graphics.endFill();

        var bd:BitmapData = new BitmapData(radius * 2, radius * 2, true, 0xFFFFFF);
        bd.draw(c);

        return bd;
    }

    public static function alignByCenter(view:*, parentWidth:int = 0, parentHeight:int = 0):void{
        if(!view)
            return;

        if(parentWidth != 0)
            view.x = parentWidth / 2 - view.width / 2;

        if(parentHeight != 0)
            view.y = parentHeight / 2 - view.height / 2
    }


    public static function rgbToHex(r:int, g:int, b:int):uint{
        return (r << 16) | (g << 8) | b;
    }

    public static function splitBitmapByLine(bmp:Bitmap, a:Point, b:Point):Vector.<Bitmap>{
        var boundPoly:CustomPolygon = new CustomPolygon(CustomPolygon.rect(bmp.getBounds(bmp)));
        var ps:Vector.<CustomPolygon> = boundPoly.splitByLine(a, b);
         var res:Vector.<Bitmap> = new Vector.<Bitmap>();
        var n:uint = ps.length;
        for(var i:uint = 0; i < n; i++){
            var p:CustomPolygon = ps[i];
            var path:Array = createPath(p.vertexes);
            var bounds:Rectangle = p.bounds;
            var bd:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
            bd.draw(refreshSplitedView(path, bmp), new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
            res.push(new Bitmap(bd));
        }
        return res;
    }

    private static var _view:Sprite = new Sprite();
    private static var _container:Sprite = new Sprite();
    private static var _mask:Sprite = new Sprite();
    private static function refreshSplitedView(path:Array, masked:Bitmap):Sprite {
        DisplayObjectUtil.removeAll(_container);

        with(_mask.graphics){
            clear();
            beginFill(0xFF0000);
            drawPath(path[0], path[1]);
            endFill();
        }
        _view.addChild(_container);
        _view.addChild(_mask);
        _container.mask = _mask;
        _container.addChild(masked);
        return _view;
    }

    private static function createPath(vertexes:Vector.<Point>):Array {
        var squareCommands:Vector.<int> = new Vector.<int>();
        squareCommands[0] = 1;

        var squareCoords:Vector.<Number> = new Vector.<Number>();
        for(var i:uint = 0, j:uint = 0; i < vertexes.length; i++, j += 2){
            if(i > 0)
                squareCommands[i] = 2;

            squareCoords[j] = vertexes[i].x;
            squareCoords[j + 1] = vertexes[i].y;
        }

        return [squareCommands, squareCoords];
    }
}
}
