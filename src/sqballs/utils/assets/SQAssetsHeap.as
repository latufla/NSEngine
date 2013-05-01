/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 26.04.13
 * Time: 11:14
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils.assets {
import core.utils.assets.AssetsHeap;

public class SQAssetsHeap extends AssetsHeap{

    public static const DIALOG_WINDOW:String = "dialogWindow";
    [Embed(source="../../../../assets/gui/GUI.swf", symbol="DialogWindowView")]
    private const DialogWindowClass:Class;

    public static const REFRESH_BUTTON:String = "refreshButton";
    [Embed(source="../../../../assets/gui/GUI.swf", symbol="RefreshButton")]
    private const RefreshViewClass:Class;

    public static const PRELOADER_VIEW:String = "preloaderView";
    [Embed(source="../../../../assets/gui/GUI.swf", symbol="PreloaderView")]
    private const PreloaderViewClass:Class;

    public static const BALL:String = "ball";
    [Embed(source="../../../../assets/ball.png")]
    private const BallViewClass:Class;

    public static const LEVEL_1:String = "level1";
    [Embed(source="../../../../assets/levels/1/level.jpg")]
    private const Level1ViewClass:Class;

    public static const LEVEL_BORDERS_1:String = "levelBorders1";
    [Embed(source="../../../../assets/levels/1/borders.png")]
    private const LevelBorders1ViewClass:Class;


    public static const RAT_RUN:String = "ratRun";
    [Embed(source="../../../../assets/ratRun.png")]
    private const RatRunViewClass:Class;

    [Embed(source="../../../../assets/ratRunDesc.xml", mimeType="application/octet-stream")]
    private const RatRunXMLClass:Class;


    public static const RAT_MOVE:String = "ratMove";
    [Embed(source="../../../../assets/ratMove.png")]
    private const RatMoveViewClass:Class;

    [Embed(source="../../../../assets/ratMoveDesc.xml", mimeType="application/octet-stream")]
    private const RatMoveXMLClass:Class;

    public function SQAssetsHeap() {
        super();
    }

    override protected function init():void{
        super.init();

        _assets[DIALOG_WINDOW] = DialogWindowClass;
        _assets[REFRESH_BUTTON] = RefreshViewClass;
        _assets[PRELOADER_VIEW] = PreloaderViewClass;

        _assets[BALL] = BallViewClass;
        _assets[LEVEL_1] = Level1ViewClass;
        _assets[LEVEL_BORDERS_1] = LevelBorders1ViewClass;

        _assets[RAT_RUN] = RatRunViewClass;
        _assetsDesc[RAT_RUN] = RatRunXMLClass;

        _assets[RAT_MOVE] = RatMoveViewClass;
        _assetsDesc[RAT_MOVE] = RatMoveXMLClass;
    }
}
}
