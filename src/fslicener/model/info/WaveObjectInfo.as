/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 12:43
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info {
import flash.geom.Point;

public class WaveObjectInfo {
    private var _name:String;
    private var _position:Point;
    private var _impulse:Number;
    private var _angularImpulse:Number;
    private var _points:int;
    private var _timeout:Number;

    public function WaveObjectInfo(params:Object) {
        _name = params["name"];

        var pos:Array = params["position"].split(":");
        _position = new Point(pos[0], pos[1]);

        _impulse = params["impulse"];
        _angularImpulse = params["angularImpulse"];
        _points = params["points"];
        _timeout = params["timeout"];
    }

    public function get name():String {
        return _name;
    }

    public function get position():Point {
        return _position;
    }

    public function get impulse():Number {
        return _impulse;
    }

    public function get angularImpulse():Number {
        return _angularImpulse;
    }

    public function get points():int {
        return _points;
    }

    public function get timeout():Number {
        return _timeout;
    }

    public function toString():String{
        return "{ name: " + _name + " position: " + _position + " impulse: " + _impulse + " angularImpulse: " + _angularImpulse + " points: " + _points + " timeout: " + _timeout + " }";
    }
}
}
