/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 20:12
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import core.utils.DisplayObjectUtil;

import flash.display.Stage;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLRequest;

import sqballs.SceneController;
import sqballs.controller.SQFieldController;
import sqballs.model.info.GameInfo;

public class Config {

    public static const EXTERNAL_CONFIG:String = "../../../config.txt";
    public static const FPS:uint = 60;
    public static const DEBUG:Boolean = true; // show phys debug layer
    public static const DEFAULT_VIEWPORT_SIZE:Rectangle = new Rectangle(0, 0, 1024, 768);

      // in game
    public static var stage:Stage;

    public static var fieldController:SQFieldController;
    public static var sceneController:SceneController;
    public static var gameInfo:GameInfo;
   // --------

    // pretend to be external
    public static var playerBallColor:uint = 0xFFFFFF;
    public static var enemyBallColors:Array = [0x0000FF, 0xFF0000];

    public static var ballRadiusSteps:Array = [20, 30, 40];
    public static var playerBallRadius:uint = ballRadiusSteps[1];

    public static var levelRect:Rectangle = new Rectangle(44, 40, 935, 668);
    public static var maxBallsCount:uint = 10; // if all can`t be placed, it`ll be less
    //--------

    // external update part
    private static var _loadHandlers:Array = [];
    public static function load(onComplete:Function, onError:Function):void{
        _loadHandlers = [onComplete, onError];

        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, onLoadComplete);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError);

        var rq:URLRequest = new URLRequest(Config.EXTERNAL_CONFIG);
        loader.load(rq);
    }

    private static function onLoadComplete(e:Event):void{
        try{
            var loader:URLLoader =  URLLoader(e.target);
            var jsonData:Object = JSON.parse(loader.data);
            update(jsonData);
            _loadHandlers[0]();
        }catch(err:Error){
            onLoadError();
        }
    }

    private static function update(jsonData:Object):void{
        var colorArr:Array = jsonData["user"]["color"];
        Config.playerBallColor = DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2]);

        colorArr = jsonData["enemy"]["color1"];
        var enemyColors:Array = [DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2])];

        colorArr = jsonData["enemy"]["color2"];
        enemyColors.push(DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2]));

        Config.enemyBallColors = enemyColors;
        Config.maxBallsCount = jsonData["maxBallsCount"];
    }

    private static function onLoadError(err:* = null):void{
        var cb:Function = _loadHandlers[1];
        if(cb)
            cb();
    }

}
}
