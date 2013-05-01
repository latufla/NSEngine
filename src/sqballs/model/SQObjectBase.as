/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 13:36
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.controller.ControllerBase;
import core.model.ObjectBase;

import sqballs.utils.Config;


public class SQObjectBase extends ObjectBase {

    public function SQObjectBase() {
        super();
    }

    override public function get controller():ControllerBase{
        return Config.fieldController.getControllerByObject(this);
    }
}
}
