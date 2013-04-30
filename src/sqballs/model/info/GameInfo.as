/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model.info {
import core.utils.MathUtil;

import flash.geom.Point;
import flash.geom.Rectangle;

import sqballs.utils.Config;

public class GameInfo {

    private static const BALL_PLACE_OFFSET:int = 5;
    private var _player:UserInfo;
    private var _users:Vector.<UserInfo>;

    public function GameInfo(player:UserInfo){
        _player = player;
    }

    public function toString():String{
        return "{ users: " + _users + "}";
    }

    public function refresh():void{
        _users = generateAndPlaceUsers(_player);
    }

    public function get users():Vector.<UserInfo> {
        return _users;
    }

    public function set users(value:Vector.<UserInfo>):void {
        _users = value;
    }

    // TODO: think about Knapsack problem and nonrect generate
    // TODO: don`t generate lose-lose map
    private function generateAndPlaceUsers(player:UserInfo):Vector.<UserInfo>{
        var rect:Rectangle = Config.levelRect;
        var mBRad:int = Config.ballRadiusSteps[Config.ballRadiusSteps.length - 1] + BALL_PLACE_OFFSET;
        var cRectSide:int = (2 * mBRad);
        var vCount:uint = rect.width / cRectSide;
        var hCount:uint = rect.height / cRectSide;

        var anchors:Vector.<Point> = new Vector.<Point>();
        var centerOffset:Point = new Point(rect.x + mBRad, rect.y + mBRad);
        for (var i:int = 0; i < vCount; i++) {
            for (var j:int = 0; j < hCount; j++) {
                anchors.push(new Point(centerOffset.x + i * cRectSide, centerOffset.y + j * cRectSide));
            }
        }
        anchors.sort(MathUtil.randomize);

        var userInfo:UserInfo = player;
        var info:UserInfo;
        var users:Vector.<UserInfo> = new <UserInfo>[BotInfo.create(1, "ball1", anchors.shift(), Config.ballRadiusSteps[0], BotInfo.SMART)];
        var anchor:Point;
        var rnd:int;
        var k:int = 2;
        while(anchors.length != 0 && k++ <= Config.maxBallsCount){
            anchor = anchors.shift();
            if(userInfo){
                userInfo.initialPosition = anchor;
                info = userInfo;
                userInfo = null;
            }else{
                rnd = Math.random() * Config.ballRadiusSteps.length;
                info = BotInfo.create(i, "ball" + i, anchor, Config.ballRadiusSteps[rnd], BotInfo.SMART);
            }
            users.push(info);
        }

        return users;
    }
}
}
