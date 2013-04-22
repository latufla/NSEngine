/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 22.04.13
 * Time: 12:05
 * To change this template use File | Settings | File Templates.
 */
package core.view {
import core.utils.graphic.GraphicsEngineConnector;

import flash.display.Bitmap;

public class SequenceView extends ViewBase{

    private var _desc:XML;
    public function SequenceView(texture:Bitmap, desc:XML) {
        _desc = desc;
        super(texture);
    }

    override protected function init():void{
        GraphicsEngineConnector.instance.initView(this, _texture, _desc);
        stop();
    }

    public function play():void{
        GraphicsEngineConnector.instance.playSequence(this);
    }

    public function pause():void{
        GraphicsEngineConnector.instance.pauseSequence(this);
    }

    public function stop():void{
        GraphicsEngineConnector.instance.stopSequence(this);
    }

    public function get isPlaying():Boolean{
        return GraphicsEngineConnector.instance.getSequenceIsPlaying(this);
    }
}
}
