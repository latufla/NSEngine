/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 26.03.13
 * Time: 16:07
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.utils.phys.CustomCircle;
import core.utils.phys.CustomMaterial;
import core.utils.phys.CustomShape;
import core.utils.phys.PhysEngineConnector;

import flash.geom.Point;
import flash.geom.Rectangle;

import sqballs.utils.Config;

public class Ball extends SQObjectBase{

    public static const DEFAULT_RADIUS:uint = 80;
    private static const DEFAULT_SHAPE:CustomCircle = new CustomCircle(DEFAULT_RADIUS);

    protected var _radius:uint = DEFAULT_RADIUS;
    protected var _defenceRadius:uint = 200;
    protected var _color:uint = Config.playerBallColor;
    protected var _rectSize:Rectangle;

    public function Ball() {
        super();
        _rectSize = new Rectangle();
    }

    public static function create(libDesc:String, pos:Point, radius:int, material:CustomMaterial):Ball{
        var obj:Ball = new Ball();
        obj.libDesc = libDesc;
        obj.shapes = new <CustomShape>[DEFAULT_SHAPE];
        obj.material = material;
        obj.position = pos;
        obj.radius = radius;
        return obj;
    }

    public function get radius():uint {
        return _radius;
    }

    public function set radius(value:uint):void {
        _radius = value;
        _rectSize.width = _rectSize.height = _radius * 2;

        PhysEngineConnector.instance.resizeTopmostCircle(this, _radius);
    }

    public function get area():Number {
        return Math.PI * Math.pow(_radius, 2);
    }

    public function set area(value:Number):void {
        radius = Math.pow(value / Math.PI, .5);
    }

    public function get rectSize():Rectangle {
        return _rectSize;
    }

    public function get color():uint {
        return _color;
    }

    public function set color(value:uint):void {
        _color = value;
    }

    public function isInDefenceRadius(obj:Ball):Boolean{
        var distance:int = getDistanceTo(obj);
        return distance <= _defenceRadius;
    }

    public function getDistanceTo(obj:Ball):uint{
        var distanceV:Point = this.position.subtract(obj.position);
        return distanceV.length - obj.radius - this.radius;
    }
}
}
