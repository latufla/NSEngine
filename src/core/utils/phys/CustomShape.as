/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 15.01.13
 * Time: 16:16
 * To change this template use File | Settings | File Templates.
 */
package core.utils.phys {
import flash.geom.Point;

import nape.shape.Shape;

public class CustomShape {

    protected var _shape:Shape;

    public function CustomShape() {
        init();
    }

    protected function init():void {
        PhysEngineConnector.instance.initShape(this);
    }

    public function updatePhysEngineObj(s:Shape):void{
        s.body.align();
    }

    public function toPhysEngineObj():Shape{
        return null;
    }

    public function clone():CustomShape{
        return null;
    }

    public function get localCOM():Point{
        return PhysEngineConnector.instance.getShapeLocalCOM(this);
    }

    public function get fieldCOM():Point{
        return PhysEngineConnector.instance.getShapeWorldCOM(this);
    }
}
}
