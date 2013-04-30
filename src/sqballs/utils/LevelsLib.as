/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 18.03.13
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {

import core.model.Field;
import core.utils.assets.AssetsLib;

import flash.display.Bitmap;
import flash.display.BitmapData;

import sqballs.model.SQField;

import sqballs.utils.assets.SQAssetsHeap;

public class LevelsLib {

    public function LevelsLib() {
    }

    public static function getFieldByLevel(l:uint = 1):SQField{
        var border:BitmapData = Bitmap(AssetsLib.instance.getAssetBy(SQAssetsHeap.LEVEL_BORDERS_1)).bitmapData;
        var f:SQField = new SQField(border, Config.gameInfo.users);
        trace("Config.gameInfo.users", Config.gameInfo.users);
        f.libDesc = SQAssetsHeap.LEVEL_1;
        trace(f.racers);
        return f;
    }
}
}
