/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 10.05.13
 * Time: 15:08
 * To change this template use File | Settings | File Templates.
 */
package fslicener.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.utils.assets.AssetsLib;
import core.utils.phys.CustomMaterial;

import fslicener.controller.FSControllerBase;
import fslicener.controller.FSFieldController;

import fslicener.model.FSObjectBase;

import fslicener.model.info.LevelInfo;

import fslicener.model.info.UserInfo;
import fslicener.model.info.WaveInfo;
import fslicener.model.info.WaveObjectInfo;
import fslicener.utils.LevelInfoLib;
import fslicener.utils.assets.FSAssetsHeap;

public class GameProcessBehavior extends BehaviorBase{

    private var _levelInfo:LevelInfo;
    private var _userInfo:UserInfo;
    private var _time:Number = 0;

    public function GameProcessBehavior(userInfo:UserInfo) {
        _userInfo = userInfo;
        _levelInfo = LevelInfoLib.getLevelInfoById(_userInfo.level);
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        _time +=step;

        var wave:WaveInfo = _levelInfo.waves[0];
        var objInfo:WaveObjectInfo;
        for (var i:uint = 0; i < wave.objects.length; i++){
            objInfo = wave.objects[i];
            if(_time > objInfo.timeout){
                applyCreateObject(objInfo);
                wave.objects.splice(i, 1);
            }
        }
    }

    private function applyCreateObject(info:WaveObjectInfo):void {
        var res:FSObjectBase = FSObjectBase.fromBitmapData(info.position, AssetsLib.instance.getAssetBy(FSAssetsHeap.APPLE_BORDERS).bitmapData, new CustomMaterial(1, 0, 0, 0.03, 0.01), 1);
        res.libDesc = info.name;
        res.points = info.points;

        var resC:FSControllerBase = FSControllerBase.create(res);

        var fieldC:FSFieldController = _controller as FSFieldController;
        fieldC.add(resC);

        res.applyImpulse(info.impulse);
        res.applyAngularImpulse(info.angularImpulse);
    }
}
}