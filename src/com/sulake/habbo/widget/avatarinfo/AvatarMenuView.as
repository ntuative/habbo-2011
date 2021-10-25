package com.sulake.habbo.widget.avatarinfo
{

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    import flash.geom.Point;

    public class AvatarMenuView extends AvatarInfoView
    {

        protected static const var_4666: uint = 0;
        protected static const var_4667: uint = 1;
        protected static const var_4668: uint = 2;

        protected var _data: AvatarInfoData;
        protected var var_2590: uint = 0;

        public function AvatarMenuView(param1: AvatarInfoWidget, param2: int, param3: String, param4: int, param5: int, param6: AvatarInfoData)
        {
            super(param1, param2, param3, param4, param5, false);
            this._data = param6;
            var_2820 = (XmlAsset(_widget.assets.getAssetByName("avatar_menu_widget")).content as XML);
        }

        override public function dispose(): void
        {
            if (_window)
            {
                _window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseHoverEvent);
                _window.removeEventListener(WindowMouseEvent.var_626, this.onMouseHoverEvent);
            }

            super.dispose();
        }

        override protected function createWindow(): void
        {
            if (!_widget || !_widget.assets || !_widget.windowManager)
            {
                return;
            }

            _window = (_widget.windowManager.buildFromXML(var_2820, 0) as IWindowContainer);
            if (!_window)
            {
                return;
            }

            _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseHoverEvent);
            _window.addEventListener(WindowMouseEvent.var_626, this.onMouseHoverEvent);
            setImageAsset(_window.findChildByName("pointer") as IBitmapWrapperWindow, "arrow_down_gray");
            _window.findChildByName("name").caption = _userName;
            _window.findChildByName("link_moderate").procedure = this.buttonEventProc;
            _window.findChildByName("link_show_actions").procedure = this.buttonEventProc;
            _window.findChildByName("link_more_actions").procedure = this.buttonEventProc;
            this.updateButtons();
            _window.visible = false;
        }

        protected function updateButtons(): void
        {
            var _loc2_: int;
            var _loc3_: int;
            var _loc4_: int;
            var _loc5_: String;
            var _loc6_: Boolean;
            var _loc1_: IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
            _loc1_.procedure = this.buttonEventProc;
            if (this._data.isOwnUser)
            {
                _loc1_.visible = false;
            }
            else
            {
                _loc1_.autoArrangeItems = false;
                _loc2_ = _loc1_.numListItems;
                _loc3_ = 0;
                while (_loc3_ < _loc2_)
                {
                    _loc1_.getListItemAt(_loc3_).visible = false;
                    _loc3_++;
                }

                if (this.var_2590 == var_4666)
                {
                    _window.findChildByName("link_moderate").visible = false;
                    _window.findChildByName("link_show_actions").visible = false;
                    _window.findChildByName("link_more_actions").visible = true;
                }

                if (this.var_2590 == var_4666 || this.var_2590 == var_4667)
                {
                    _loc1_.getListItemByName("friend").visible = true;
                    if (this._data.canBeAskedAsFriend)
                    {
                        _loc1_.getListItemByName("friend").enable();
                    }
                    else
                    {
                        _loc1_.getListItemByName("friend").disable();
                        this.var_2590 = var_4667;
                    }

                }

                if (this.var_2590 == var_4667)
                {
                    _window.findChildByName("link_moderate").visible = true;
                    _window.findChildByName("link_show_actions").visible = false;
                    _window.findChildByName("link_more_actions").visible = false;
                    _loc4_ = this._data.respectLeft;
                    _widget.localizations.registerParameter("infostand.button.respect", "count", _loc4_.toString());
                    _loc1_.getListItemByName("respect").visible = true;
                    if (_loc4_ > 0)
                    {
                        _loc1_.getListItemByName("respect").enable();
                    }
                    else
                    {
                        _loc1_.getListItemByName("respect").disable();
                    }

                    _loc1_.getListItemByName("trade").visible = true;
                    if (this._data.canTrade)
                    {
                        _loc1_.getListItemByName("trade").enable();
                    }
                    else
                    {
                        _loc1_.getListItemByName("trade").disable();
                    }

                    switch (this._data.canTradeReason)
                    {
                        case RoomWidgetUserInfoUpdateEvent.var_1809:
                            _loc5_ = "${infostand.button.trade.tooltip.shutdown}";
                            break;
                        case RoomWidgetUserInfoUpdateEvent.var_1810:
                            _loc5_ = "${infostand.button.trade.tooltip.tradingroom}";
                            break;
                        default:
                            _loc5_ = "";
                    }

                    IInteractiveWindow(_loc1_.getListItemByName("trade")).toolTipCaption = _loc5_;
                    _loc1_.getListItemByName("whisper").visible = true;
                    if (this._data.amIOwner)
                    {
                        _loc1_.getListItemByName("give_rights").visible = !this._data.hasFlatControl;
                        _loc1_.getListItemByName("remove_rights").visible = this._data.hasFlatControl;
                    }
                    else
                    {
                        _loc1_.getListItemByName("give_rights").visible = false;
                        _loc1_.getListItemByName("remove_rights").visible = false;
                    }

                }

                if (this.var_2590 == var_4668)
                {
                    _window.findChildByName("link_moderate").visible = false;
                    _window.findChildByName("link_show_actions").visible = true;
                    _window.findChildByName("link_more_actions").visible = false;
                    _loc1_.getListItemByName("ignore").visible = !this._data.isIgnored;
                    _loc1_.getListItemByName("unignore").visible = this._data.isIgnored;
                    _loc1_.getListItemByName("kick").visible = (this._data.amIOwner || this._data.amIController || this._data.amIAnyRoomController) && this._data.canBeKicked;
                    _loc1_.getListItemByName("ban").visible = (this._data.amIOwner || this._data.amIAnyRoomController) && this._data.canBeKicked;

                    _loc6_ = _widget.configuration != null && _widget.configuration.getKey("infostand.report.show", "0") == "1";

                    _loc1_.getListItemByName("report").visible = _loc6_;
                }

                _loc1_.autoArrangeItems = true;
                _loc1_.visible = true;
            }

        }

        private function buttonEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "friend":
                        return;
                    case "respect":
                        return;
                    case "give_rights":
                        return;
                    case "remove_rights":
                        return;
                    case "trade":
                        return;
                    case "whisper":
                        return;
                    case "unignore":
                        return;
                    case "ignore":
                        return;
                    case "kick":
                        return;
                    case "report":
                        return;
                    case "ban":
                        return;
                    case "link_moderate":
                        this.var_2590 = var_4668;
                        this.updateButtons();
                        return;
                    case "link_show_actions":
                        this.var_2590 = var_4666;
                        this.updateButtons();
                        return;
                    case "link_more_actions":
                        this.var_2590 = var_4667;
                        this.updateButtons();
                        return;
                }

            }

        }

        protected function onMouseHoverEvent(param1: WindowMouseEvent): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                var_4658 = true;
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_626)
                {
                    if (!_window.hitTestGlobalPoint(new Point(param1.stageX, param1.stageY)))
                    {
                        var_4658 = false;
                    }

                }

            }

        }

    }
}
