package com.sulake.habbo.widget.purse
{

    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.messages.RoomWidgetGetPurseData;
    import com.sulake.habbo.widget.events.RoomWidgetPurseUpdateEvent;

    import flash.events.IEventDispatcher;

    import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;

    public class PurseWidget extends RoomWidgetBase
    {

        private const var_4899: int = 3;
        private const var_4901: uint = 4291993382;
        private const var_4902: uint = 0xFFC08500;
        private const var_4903: uint = 4285767869;
        private const var_4904: uint = 4283664040;

        private var _view: IWindowContainer;
        private var var_2696: int;
        private var var_4900: int;

        public function PurseWidget(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IHabboLocalizationManager)
        {
            var _loc5_: IWindowContainer;
            var _loc6_: Array;
            var _loc7_: IWindow;
            super(param1, param2, param3);
            var _loc4_: XmlAsset = param2.getAssetByName("purse_widget") as XmlAsset;
            if (_loc4_)
            {
                this._view = (param1.buildFromXML(_loc4_.content as XML, 1) as IWindowContainer);
                _loc5_ = this._view.desktop;
                this._view.x = _loc5_.width - this._view.width - this.var_4899;
                this._view.y = this.var_4899;
                this._view.visible = false;
                this._view.findChildByName("credits_container")
                        .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCreditsClick);
                this._view.findChildByName("pixels_container")
                        .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPixelsClick);
                _loc6_ = [];
                this._view.groupChildrenWithTag("ORANGE", _loc6_, true);
                for each (_loc7_ in _loc6_)
                {
                    _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onOrangeMouseOver);
                    _loc7_.addEventListener(WindowMouseEvent.var_626, this.onOrangeMouseOut);
                }

                _loc6_ = [];
                this._view.groupChildrenWithTag("BLUE", _loc6_, true);
                for each (_loc7_ in _loc6_)
                {
                    _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onBlueMouseOver);
                    _loc7_.addEventListener(WindowMouseEvent.var_626, this.onBlueMouseOut);
                }

            }

        }

        override public function initialize(param1: int = 0): void
        {
            messageListener.processWidgetMessage(new RoomWidgetGetPurseData());
            if (this._view)
            {
                this._view.visible = true;
            }

        }

        override public function dispose(): void
        {
            if (disposed)
            {
                return;
            }

            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            }

            super.dispose();
        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (!param1)
            {
                return;
            }

            param1.addEventListener(RoomWidgetPurseUpdateEvent.var_150, this.onCreditBalance);
            param1.addEventListener(RoomWidgetPurseUpdateEvent.var_152, this.onPixelBalance);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetPurseUpdateEvent.var_150, this.onCreditBalance);
            param1.removeEventListener(RoomWidgetPurseUpdateEvent.var_152, this.onPixelBalance);
        }

        private function onCreditBalance(param1: RoomWidgetPurseUpdateEvent): void
        {
            this.var_2696 = param1.balance;
            if (this._view)
            {
                this._view.findChildByName("credits").caption = this.var_2696.toString();
                this._view.findChildByName("credits_shadow").caption = this.var_2696.toString();
            }

        }

        private function onPixelBalance(param1: RoomWidgetPurseUpdateEvent): void
        {
            this.var_4900 = param1.balance;
            if (this._view)
            {
                this._view.findChildByName("pixels").caption = this.var_4900.toString();
                this._view.findChildByName("pixels_shadow").caption = this.var_4900.toString();
            }

        }

        private function onCreditsClick(param1: WindowMouseEvent): void
        {
            messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.var_1282));
        }

        private function onPixelsClick(param1: WindowMouseEvent): void
        {
            messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.var_1283));
        }

        private function onOrangeMouseOver(param1: WindowMouseEvent): void
        {
            param1.window.color = this.var_4902;
        }

        private function onOrangeMouseOut(param1: WindowMouseEvent): void
        {
            param1.window.color = this.var_4901;
        }

        private function onBlueMouseOver(param1: WindowMouseEvent): void
        {
            param1.window.color = this.var_4904;
        }

        private function onBlueMouseOut(param1: WindowMouseEvent): void
        {
            param1.window.color = this.var_4903;
        }

    }
}
