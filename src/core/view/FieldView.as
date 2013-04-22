/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 21.04.13
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package core.view {
import core.utils.graphic.GraphicsEngineConnector;

import flash.display.Bitmap;

public class FieldView extends ViewBase{
    public function FieldView(texture:Bitmap = null) {
        super(texture);
    }

    public function draw():void{
        GraphicsEngineConnector.instance.addChildToScene(this);
    }
}
}
