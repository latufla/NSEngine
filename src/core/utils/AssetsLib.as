/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package core.utils {

import flash.display.Bitmap;

public class AssetsLib {

    public static const BALL:String = "ball";
    [Embed(source="../../../assets/ball.png")]
    private const BallViewClass:Class


    public static const LEVEL_1:String = "level1";
    [Embed(source="../../../assets/levels/1/level.jpg")]
    private const Level1ViewClass:Class

    public static const LEVEL_BORDERS_1:String = "levelBorders1";
    [Embed(source="../../../assets/levels/1/borders.png")]
    private const LevelBorders1ViewClass:Class


    public static const RAT_RUN:String = "ratRun";
    [Embed(source="../../../assets/ratRun.png")]
    private const RatRunViewClass:Class;

    [Embed(source="../../../assets/ratRunDesc.xml", mimeType="application/octet-stream")]
    private const RatRunXMLClass:Class;


    public static const RAT_MOVE:String = "ratMove";
    [Embed(source="../../../assets/ratMove.png")]
    private const RatMoveViewClass:Class;

    [Embed(source="../../../assets/ratMoveDesc.xml", mimeType="application/octet-stream")]
    private const RatMoveXMLClass:Class;


    private var _assets:Array/* String -> Class */;
    private var _assetsDesc:Array/* String -> XML */;

    private static var _instance:AssetsLib;

    public function AssetsLib() {
        init();
    }

    public static function get instance():AssetsLib {
        if(!_instance)
            _instance = new AssetsLib();

        return _instance;
    }

    public function getAssetBy(name:String):Bitmap{
        var asset:Bitmap;
        try{
            asset = new _assets[name]();
        } catch (e:Error){
            trace("AssetsLib -> getAssetBy(): no asset with name: " + name);
        }

        return asset;
    }

    public function getDescBy(name:String):XML{
        var desc:XML;
        try{
            desc = XML(new _assetsDesc[name]());
        } catch (e:Error){
            trace("AssetsLib -> getDescBy(): no desc with name: " + name);
        }

        return desc;
    }

    private function init():void {
        _assets = [];
        _assetsDesc = [];

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
