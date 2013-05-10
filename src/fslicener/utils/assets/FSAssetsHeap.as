/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.05.13
 * Time: 0:12
 * To change this template use File | Settings | File Templates.
 */
package fslicener.utils.assets {
import core.utils.assets.AssetsHeap;

public class FSAssetsHeap extends AssetsHeap{

    public static const LEVEL_1:String = "level1";
    [Embed(source="../../../../assets/levels/1/level.jpg")]
    private const Level1ViewClass:Class;

    public static const LEVEL_BORDERS_1:String = "levelBorders1";
    [Embed(source="../../../../assets/levels/1/borders.png")]
    private const LevelBorders1ViewClass:Class;

    public static const APPLE:String = "apple";
    [Embed(source="../../../../assets/fruits/apple.png")]
    private const AppleViewClass:Class;

    public static const APPLE_BORDERS:String = "appleBorders";
    [Embed(source="../../../../assets/fruits/appleBorders.png")]
    private const AppleBordersClass:Class;


    public function FSAssetsHeap() {
    }

    override protected function init():void{
        super.init();

        _assets[APPLE] = AppleViewClass;
        _assets[APPLE_BORDERS] = AppleBordersClass;

        _assets[LEVEL_1] = Level1ViewClass;
        _assets[LEVEL_BORDERS_1] = LevelBorders1ViewClass;
    }
}
}
