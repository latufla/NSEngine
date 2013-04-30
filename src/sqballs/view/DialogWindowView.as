/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package sqballs.view {
import core.utils.DisplayObjectUtil;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import sqballs.utils.FlashAssetsLib;
import sqballs.utils.FontUtil;
import sqballs.utils.tr.en.Tr;

public class DialogWindowView extends Sprite{

    private var _container:DisplayObjectContainer;
    private var _okButtonCallback:Function;
    private var _cancelButtonCallback:Function;
    private var _closeButtonCallback:Function;

    public function DialogWindowView() {
        super();
        init();
    }

    private function init():void{
        _container = FlashAssetsLib.instance.createAssetBy(FlashAssetsLib.DIALOG_WINDOW) as DisplayObjectContainer;
        addChild(_container);

        closeButton.buttonMode =  closeButton.useHandCursor = true;

        cancelButton.buttonMode =  cancelButton.useHandCursor = true;
        cancelButton.mouseChildren = false;
        FontUtil.initDefaultField(cancelButton.label, Tr.cancelButtonText);

        okButton.buttonMode =  okButton.useHandCursor = true;
        okButton.mouseChildren = false;
        FontUtil.initDefaultField(okButton.label, Tr.okButtonText);

        contentField.autoSize = TextFieldAutoSize.LEFT;
        FontUtil.initDefaultField(contentField, Tr.defaultDialogWindowText);

        addEventListeners();
    }

    public function applyNoDeny():void{
        cancelButton.visible = closeButton.visible = false;
        DisplayObjectUtil.alignByCenter(okButton, _container.width);
    }

     public function get contentField():TextField{
        return _container["contentField"];
    }

    public function get closeButton():MovieClip{
        return _container["closeButton"];
    }

    // TODO: use normal buttons
    public function get cancelButton():MovieClip{
        return _container["cancelButton"];
    }

    public function get okButton():MovieClip{
        return _container["okButton"];
    }

    public function set okButtonCallback(value:Function):void {
        _okButtonCallback = value;
    }

    public function set cancelButtonCallback(value:Function):void {
        _cancelButtonCallback = value;
    }

    public function set closeButtonCallback(value:Function):void {
        _closeButtonCallback = value;
    }

    protected function addEventListeners():void {
        closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
        cancelButton.addEventListener(MouseEvent.CLICK, onCancelButtonClick);
        okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);
    }

    protected function removeEventListeners():void {
        closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClick);
        cancelButton.removeEventListener(MouseEvent.CLICK, onCancelButtonClick);
        okButton.removeEventListener(MouseEvent.CLICK, onOkButtonClick);
    }

    protected function onCloseButtonClick(e:MouseEvent = null):void {
        DisplayObjectUtil.tryRemove(this);
        removeEventListeners();

        if(_closeButtonCallback)
            _closeButtonCallback();
    }

    protected function onCancelButtonClick(e:MouseEvent = null):void {
        DisplayObjectUtil.tryRemove(this);
        removeEventListeners();

        if(_cancelButtonCallback)
            _cancelButtonCallback();
    }

    protected function onOkButtonClick(e:MouseEvent = null):void {
        DisplayObjectUtil.tryRemove(this);
        removeEventListeners();

        if(_okButtonCallback)
            _okButtonCallback();
    }
}
}
