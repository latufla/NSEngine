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

public class Field extends ObjectBase{

    private var _border:BitmapData;

    public function Field(border:BitmapData) {
        _border = border;
        super();
    }

    override protected function init():void{
        PhysEngineConnector.instance.createBorders(this, _border);
    }
}
}
