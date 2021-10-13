package com.sulake.habbo.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import flash.events.Event;

    public class MeMenuDanceView implements IMeMenuView 
    {

        private var _habboClubRequired:Array = [2, 3, 4];
        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;

        public function init(param1:MeMenuWidget, param2:String):void
        {
            this._widget = param1;
            this.createWindow(param2);
        }

        public function dispose():void
        {
            this._widget = null;
            this._window.dispose();
            this._window = null;
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        private function createWindow(param1:String):void
        {
            var _loc4_:IItemListWindow;
            var _loc5_:XmlAsset;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:Boolean;
            var _loc10_:IWindow;
            var _loc2_:XmlAsset = (this._widget.assets.getAssetByName("memenu_dance") as XmlAsset);
            Logger.log(("Me Menu Dance View: " + _loc2_));
            this._window = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IWindowContainer);
            if (this._window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this._window.name = param1;
            var _loc3_:Array = [];
            _loc3_.push(this._window.findChildByName("stop_dancing_button"));
            _loc3_.push(this._window.findChildByName("back_btn"));
            for each (_loc10_ in _loc3_)
            {
                if (_loc10_ != null)
                {
                    _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                };
            };
            _loc4_ = (this._window.findChildByName("buttonContainer") as IItemListWindow);
            _loc5_ = (this._widget.assets.getAssetByName("memenu_dance_button") as XmlAsset);
            if (_loc4_ != null)
            {
                _loc7_ = 1;
                while (_loc7_ <= 4)
                {
                    _loc8_ = _loc7_;
                    _loc9_ = false;
                    if (RoomWidgetDanceMessage.var_1829.indexOf(_loc8_) >= 0)
                    {
                        _loc9_ = this._widget.allowHabboClubDances;
                    }
                    else
                    {
                        _loc9_ = true;
                    };
                    if (_loc9_)
                    {
                        _loc10_ = (this._widget.windowManager.buildFromXML((_loc5_.content as XML)) as IWindow);
                        _loc10_.name = (("dance_" + _loc7_) + "_button");
                        _loc10_.caption = (("${widget.memenu.dance" + _loc7_) + "}");
                        _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                        _loc4_.addListItemAt(_loc10_, (_loc4_.numListItems - 1));
                        if (this._widget.hasEffectOn)
                        {
                            _loc10_.disable();
                        }
                        else
                        {
                            _loc10_.enable();
                        };
                    };
                    _loc7_++;
                };
            };
            var _loc6_:IWindow = this._window.findChildByName("club_info");
            if (((!(_loc6_ == null)) && (this._widget.isHabboClubActive)))
            {
                _loc6_.visible = false;
            };
            this._widget.mainContainer.addChild(this._window);
        }

        private function onResized(param1:WindowEvent):void
        {
            this._window.x = 0;
            this._window.y = 0;
        }

        private function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:String;
            var _loc4_:String;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc3_:IWindow = (param1.target as IWindow);
            _loc4_ = _loc3_.name;
            switch (_loc4_)
            {
                case "dance_1_button":
                case "dance_2_button":
                case "dance_3_button":
                case "dance_4_button":
                    _loc5_ = _loc4_.split("_");
                    _loc6_ = parseInt(_loc5_[1]);
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(_loc6_));
                    this._widget.isDancing = true;
                    this._widget.hide();
                    return;
                case "stop_dancing_button":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage.var_1819));
                    this._widget.isDancing = false;
                    this._widget.hide();
                    return;
                case "back_btn":
                    this._widget.changeView(MeMenuWidget.var_1291);
                    return;
                default:
                    Logger.log(("Me Menu Dance View: unknown button: " + _loc4_));
            };
        }

        private function onAlertClicked(param1:IAlertDialog, param2:Event):void
        {
            param1.dispose();
        }

    }
}