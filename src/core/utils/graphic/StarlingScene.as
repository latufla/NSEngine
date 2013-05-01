/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 21.04.13
 * Time: 14:42
 * To change this template use File | Settings | File Templates.
 */
package core.utils.graphic {
import starling.display.Sprite;

public class StarlingScene extends Sprite{

    public static var _instance:StarlingScene;
    public function StarlingScene() {
        _instance = this;
    }

    public static function get instance():StarlingScene {
        return _instance;
    }

}
}
