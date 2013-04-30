/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 21:21
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model.info {
import flash.geom.Point;

public class UserInfo {
    protected var _id:uint;
    protected var _name:String = "noName";

    protected var _initialPosition:Point;
    protected var _initialRadius:uint;

    public function UserInfo(id:uint, name:String) {
        _id = id;
        _name = name;
    }

    public static function create(id:uint, name:String, initialPosition:Point, initialRadius:uint):UserInfo{
        var info:UserInfo = new UserInfo(id, name);
        info.initialPosition = initialPosition;
        info.initialRadius = initialRadius;
        return info;
    }

    public function get name():String {
        return _name;
    }

    public function get id():uint {
        return _id;
    }

    public function toString():String{
        return "{ id: " + _id  +
                ", name: " + _name +
                ", initialPosition: " + _initialPosition +
                ", initialRadius: " + _initialRadius + " }";
    }

    public function get initialPosition():Point {
        return _initialPosition;
    }

    public function set initialPosition(value:Point):void {
        _initialPosition = value;
    }

    public function get initialRadius():uint {
        return _initialRadius;
    }

    public function set initialRadius(value:uint):void {
        _initialRadius = value;
    }
}
}
