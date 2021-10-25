package com.sulake.habbo.session
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.display.BitmapData;

    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;

    import flash.geom.Rectangle;

    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class GroupDetailsView
    {

        private var _sessionManager: SessionDataManager;
        private var var_4420: IWindowContainer;
        private var var_4421: int = -1;

        public function GroupDetailsView(param1: SessionDataManager)
        {
            this._sessionManager = param1;
        }

        public function showGroupDetails(param1: int): void
        {
            this.var_4421 = param1;
            this.showGroupInfoDialog(param1);
        }

        private function showGroupInfoDialog(param1: int): void
        {
            var _loc3_: XmlAsset;
            var _loc4_: IWindow;
            var _loc5_: Array;
            var _loc6_: String;
            var _loc7_: IWindow;
            var _loc8_: IBitmapWrapperWindow;
            var _loc9_: BitmapData;
            if (this._sessionManager.windowManager == null)
            {
                return;
            }

            var _loc2_: HabboGroupDetails = this._sessionManager.getGroupDetails(param1);
            if (_loc2_ == null)
            {
                return;
            }

            if (this.var_4420 == null)
            {
                _loc3_ = (this._sessionManager.assets.getAssetByName("group_info") as XmlAsset);
                if (_loc3_ != null)
                {
                    this.var_4420 = (this._sessionManager.windowManager.createWindow("habbo_group_details_window", "${group.window.title}", HabboWindowType.var_185, HabboWindowStyle.var_525, HabboWindowParam.var_814 | HabboWindowParam.var_157, new Rectangle(10, 10, 300, 220), null) as IWindowContainer);
                    this.var_4420.buildFromXML(_loc3_.content as XML) as IWindowContainer;
                    _loc4_ = this.var_4420.findChildByTag("close");
                    if (_loc4_ != null)
                    {
                        _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGroupDetailsEvents);
                    }

                    _loc5_ = ["group_homepage_link", "group_room_link"];
                    for each (_loc6_ in _loc5_)
                    {
                        _loc7_ = this.var_4420.findChildByName(_loc6_);
                        if (_loc7_ != null)
                        {
                            _loc7_.mouseThreshold = 0;
                            _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGroupDetailsEvents);
                        }

                    }

                }

            }

            if (this.var_4420 != null)
            {
                this.var_4420.visible = true;
                this.var_4420.center();
                this.var_4420.findChildByName("group_name").caption = _loc2_.name;
                this.var_4420.findChildByName("group_description").caption = _loc2_.description;
                this.var_4420.findChildByName("group_room_link").visible = _loc2_.roomId >= 0;

                this._sessionManager.windowManager.registerLocalizationParameter("group.room.link", "room_name", _loc2_.roomName);
                _loc8_ = (this.var_4420.findChildByName("group_logo") as IBitmapWrapperWindow);
                if (_loc8_ != null)
                {
                    _loc9_ = this._sessionManager.getGroupBadgeImage(this._sessionManager.getGroupBadgeId(_loc2_.id));
                    if (_loc9_ != null)
                    {
                        _loc8_.bitmap = _loc9_.clone();
                        _loc8_.width = _loc9_.width;
                        _loc8_.height = _loc9_.height;
                    }

                }

            }
            else
            {
                this._sessionManager.windowManager.alert(_loc2_.name, _loc2_.description, 0, this.alertDialogEventProcessor);
            }

        }

        private function onGroupDetailsEvents(param1: WindowEvent): void
        {
            var _loc4_: String;
            var _loc2_: IWindow = param1.target as IWindow;
            var _loc3_: HabboGroupDetails = this._sessionManager.getGroupDetails(this.var_4421);
            switch (_loc2_.name)
            {
                case "group_homepage_link":
                    if (_loc3_ != null)
                    {
                        _loc4_ = this._sessionManager.configuration.getKey("group.homepage.url", "http://%predefined%/groups/%groupid%/id");
                        _loc4_ = _loc4_.replace("%groupid%", _loc3_.id);
                        this.openExternalLink(_loc4_);
                    }

                    return;
                case "group_room_link":
                    if (_loc3_ != null)
                    {
                        this._sessionManager.roomSessionManager.gotoRoom(false, _loc3_.roomId);
                        if (this.var_4420 != null)
                        {
                            this.var_4420.visible = false;
                        }

                    }

                    return;
                case "close":
                case "header_button_close":
                    if (this.var_4420 != null)
                    {
                        this.var_4420.visible = false;
                    }

                    return;
                default:
                    Logger.log("Group link unknown: " + _loc2_.name);
            }

        }

        private function openExternalLink(param1: String): void
        {
            if (param1 != "")
            {
                this._sessionManager.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(param1, "_empty");
            }

        }

        private function onExternalLink(param1: IAlertDialog, param2: WindowEvent): void
        {
            param1.dispose();
        }

        private function alertDialogEventProcessor(param1: IAlertDialog, param2: WindowEvent): void
        {
            param1.dispose();
        }

    }
}
