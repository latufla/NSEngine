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
    private var _impulse:Point;
    private var _angularImpulse:Number;
    private var _points:int;
    private var _timeout:Number;

    public function WaveObjectInfo() {
    }

    public static function create(params:Object = null):WaveObjectInfo{
        var res:WaveObjectInfo = new WaveObjectInfo();
        if(!params)
            return res;

        res.name = params["name"];

        var pos:Array = params["position"].split(":");
        res.position = new Point(pos[0], pos[1]);

        var imp:Array = params["impulse"].split(":");
        res.impulse = new Point(imp[0], imp[1]);

        res.angularImpulse = params["angularImpulse"];
        res.points = params["points"];
        res.timeout = params["timeout"];
        return res;
    }

    public function clone():WaveObjectInfo{
        var res:WaveObjectInfo = WaveObjectInfo.create();
        res.name = _name;
        res.position = _position.clone();
        res.impulse = _impulse.clone();
        res.angularImpulse = _angularImpulse;
        res.points = _points;
        res.timeout = _timeout;
        return res;
    }

    public function get name():String {
        return _name;
    }

    public function get position():Point {
        return _position;
    }

    public function get impulse():Point {
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

    public function set name(value:String):void {
        _name = value;
    }

    public function set position(value:Point):void {
        _position = value;
    }

    public function set impulse(value:Point):void {
        _impulse = value;
    }

    public function set angularImpulse(value:Number):void {
        _angularImpulse = value;
    }

    public function set points(value:int):void {
        _points = value;
    }

    public function set timeout(value:Number):void {
        _timeout = value;
    }
}
}
