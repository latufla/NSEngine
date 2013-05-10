/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 15:04
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model.info {
public class UserInfo {

    private var _level:uint;
    private var _wave:uint;
    private var _points:uint;

    public function UserInfo() {
    }

    public function get level():uint {
        return _level;
    }

    public function set level(value:uint):void {
        _level = value;
    }

    public function get wave():uint {
        return _wave;
    }

    public function set wave(value:uint):void {
        _wave = value;
    }

    public function get points():uint {
        return _points;
    }

    public function set points(value:uint):void {
        _points = value;
    }
}
}
