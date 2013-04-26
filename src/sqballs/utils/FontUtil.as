/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 28.03.13
 * Time: 0:19
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import flash.text.TextField;
import flash.text.TextFormat;

public class FontUtil {
    [Embed(source="../../../assets/fonts/ARLRDBD.TTF", fontName = "myArial", mimeType = "application/x-font", unicodeRange = "U+0020-007E", fontWeight="normal", fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")]
    private var myArialFont:Class;

    public function FontUtil() {
    }

    public static function setDefaultFont(tField:TextField, size:uint = 16):void{
        tField.embedFonts = true;
        tField.defaultTextFormat = new TextFormat("myArial", size);
    }

    public static function initDefaultField(tF:TextField, text:String, size:uint = 16):void{
        FontUtil.setDefaultFont(tF, size);
        tF.textColor = 0xFFFFFF;
        tF.text = text
    }
}
}
