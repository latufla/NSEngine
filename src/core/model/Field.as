/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package core.model {
import core.utils.phys.PhysEngineConnector;

import flash.display.BitmapData;
import flash.geom.Point;

public class Field extends ObjectBase{

    private var _gravity:Point = new Point(0, 0);
    private var _border:BitmapData;

    public function Field(border:BitmapData) {
        _border = border;
        super();
    }

    override protected function init():void{
        PhysEngineConnector.instance.createBorders(this, _border);
    }

    public function get gravity():Point {
        return _gravity;
    }

    public function set gravity(value:Point):void {
        _gravity = value;
    }
}
}
