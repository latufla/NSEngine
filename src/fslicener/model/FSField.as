/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 21:23
 * To change this template use File | Settings | File Templates.
 */
package fslicener.model {
import core.model.Field;

import flash.display.BitmapData;

public class FSField extends Field{

    private var _pivotX:Number = 1024 / 2;
    private var _pivotY:Number = 768 / 2;

    public function FSField(border:BitmapData) {
        super(border);
    }

    public function get pivotX():Number {
        return _pivotX;
    }

    public function get pivotY():Number {
        return _pivotY;
    }
}
}
