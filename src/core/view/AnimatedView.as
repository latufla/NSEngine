/**
 * Created with IntelliJ IDEA.
 * User: La
 * Date: 22.04.13
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package core.view {
import core.utils.DisplayObjectUtil;

public class AnimatedView extends ViewBase{

    protected var _list:Array;
//    protected var _curLabel:String;

    public function AnimatedView() {
        super();
    }

    override protected function init():void{
        super.init();
        _list = [];
    }

    public function addAnimation(label:String, sequence:SequenceView):void{
        _list[label] = sequence;
    }

    public function removeAnimation(label:String):void{
        delete _list[label];
    }

    public function gotoAndPlay(label:String):void{
        var s:SequenceView = _list[label];
        if(!s)
            return;

        DisplayObjectUtil.removeAll(this);
        s.play();
        addChild(s);
    }

    public function gotoAndStop(label:String):void{
        var s:SequenceView = _list[label];
        if(!s)
            return;

        DisplayObjectUtil.removeAll(this);
        s.stop();
        addChild(s);
    }
}
}
