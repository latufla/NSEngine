/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 25.03.13
 * Time: 17:57
 * To change this template use File | Settings | File Templates.
 */
package core.utils.phys {

import nape.geom.Vec2;
import nape.shape.Circle;
import nape.shape.Shape;

public class CustomCircle extends CustomShape {

    private var _radius:uint;

    public function CustomCircle(radius:uint) {
        _radius = radius;
    }

    override public function toPhysEngineObj():Shape{
        return new Circle(_radius, new Vec2(_radius, _radius));
    }

    public function get radius():uint {
        return _radius;
    }

    public function set radius(value:uint):void {
        _radius = value;
    }
}
}
