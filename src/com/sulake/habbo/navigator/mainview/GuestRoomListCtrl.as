package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.RoomPopupCtrl;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class GuestRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_1997:IWindowContainer;
        private var var_2190:IItemListWindow;
        private var var_3794:RoomPopupCtrl;
        private var var_2051:IScrollbarWindow;
        private var _userCountRenderer:UserCountRenderer;
        private var var_3795:IWindowContainer;
        private var var_3796:int;
        private var var_3797:Boolean;

        public function GuestRoomListCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
            this.var_3794 = new RoomPopupCtrl(this._navigator, 5, -5);
            this._userCountRenderer = new UserCountRenderer(this._navigator);
        }

        public function dispose():void
        {
            if (this.var_3794)
            {
                this.var_3794.dispose();
                this.var_3794 = null;
            };
            if (this._userCountRenderer)
            {
                this._userCountRenderer.dispose();
                this._userCountRenderer = null;
            };
        }

        public function set content(param1:IWindowContainer):void
        {
            this.var_1997 = param1;
            this.var_2190 = IItemListWindow(this.var_1997.findChildByName("item_list"));
            this.var_2051 = IScrollbarWindow(this.var_1997.findChildByName("scroller"));
        }

        public function get content():IWindowContainer
        {
            return (this.var_1997);
        }

        public function refresh():void
        {
            var _loc4_:Boolean;
            var _loc1_:Array = this._navigator.data.guestRoomSearchResults.rooms;
            var _loc2_:int = this.getVisibleEntryCount();
            this.var_2190.autoArrangeItems = false;
            var _loc3_:int;
            while (true)
            {
                if (_loc3_ < _loc1_.length)
                {
                    this.refreshEntry(true, _loc3_, _loc1_[_loc3_]);
                }
                else
                {
                    _loc4_ = this.refreshEntry(false, _loc3_, null);
                    if (_loc4_) break;
                };
                _loc3_++;
            };
            this.var_2190.autoArrangeItems = true;
            if (this.getVisibleEntryCount() != _loc2_)
            {
                this.var_2051.scrollV = 0;
            };
            this.var_1997.findChildByName("no_rooms_found").visible = (_loc1_.length < 1);
        }

        private function getVisibleEntryCount():int
        {
            var _loc1_:int;
            var _loc2_:int;
            while (_loc2_ < this.var_2190.numListItems)
            {
                if (this.var_2190.getListItemAt(_loc2_).visible)
                {
                    _loc1_++;
                };
                _loc2_++;
            };
            return (_loc1_);
        }

        private function getListEntry(param1:int):IWindowContainer
        {
            var _loc2_:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("grs_guest_room_details_short"));
            _loc2_.background = true;
            _loc2_.procedure = this.onRow;
            _loc2_.setParamFlag(HabboWindowParam.var_157, true);
            _loc2_.setParamFlag(HabboWindowParam.var_795, true);
            _loc2_.color = this.getBgColor(param1);
            _loc2_.tags.push(param1);
            return (_loc2_);
        }

        private function getBgColor(param1:int):uint
        {
            return (((param1 % 2) != 0) ? 0xFFFFFFFF : 4292797682);
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:GuestRoomData):Boolean
        {
            var _loc4_:IWindowContainer = IWindowContainer(this.var_2190.getListItemAt(param2));
            var _loc5_:Boolean;
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = this.getListEntry(param2);
                this.var_2190.addListItem(_loc4_);
                _loc5_ = true;
            };
            Util.hideChildren(_loc4_);
            if (param1)
            {
                this.refreshEntryDetails(_loc4_, param3);
                _loc4_.visible = true;
                _loc4_.height = 17;
            }
            else
            {
                _loc4_.height = 0;
                _loc4_.visible = false;
            };
            if (_loc5_)
            {
                this._navigator.mainViewCtrl.stretchNewEntryIfNeeded(this, _loc4_);
            };
            return (false);
        }

        public function refreshEntryDetails(param1:IWindowContainer, param2:GuestRoomData):void
        {
            param1.visible = true;
            Util.hideChildren(param1);
            this.refreshFavouriteIcon(param1, param2);
            this._navigator.refreshButton(param1, "home", this.isHome(param2), null, 0);
            this._navigator.refreshButton(param1, "doormode_doorbell_small", (param2.doorMode == RoomSettingsFlatInfo.var_896), null, 0);
            this._navigator.refreshButton(param1, "doormode_password_small", (param2.doorMode == RoomSettingsFlatInfo.var_897), null, 0);
            this.refreshRoomName(param1, param2);
            this._userCountRenderer.refreshUserCount(param2.maxUserCount, param1, param2.userCount, "${navigator.usercounttooltip.users}", 233, 2);
        }

        private function refreshRoomName(param1:IWindowContainer, param2:GuestRoomData):void
        {
            var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
            _loc3_.visible = true;
            var _loc4_:Boolean = (((param1.findChildByName("home").visible) || (param1.findChildByName("favourite").visible)) || (param1.findChildByName("make_favourite").visible));
            Util.cutTextToWidth(_loc3_, param2.roomName, ((_loc4_) ? (_loc3_.width - 20) : _loc3_.width));
        }

        private function onRow(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int;
            var _loc4_:GuestRoomData;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:GuestRoomData;
            var _loc8_:Point;
            if ((((param2 as IWindowContainer) == null) || (!(param2.name == "details"))))
            {
                param2 = (param2.parent as IWindowContainer);
                if (((param2 == null) || (!(param2.name == "details"))))
                {
                    return;
                };
            };
            if (param1.type == WindowMouseEvent.var_632)
            {
                this.checkFastHorizontalMove(param1);
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    if (((this.var_3794.visible) && (this.var_3797)))
                    {
                        return;
                    };
                    this.hilite(IWindowContainer(param2));
                    _loc3_ = param2.tags[0];
                    if (this._navigator.data.guestRoomSearchResults == null)
                    {
                        Logger.log("No guest room search results while room entry mouse over");
                        return;
                    };
                    _loc4_ = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
                    if (_loc4_ == null)
                    {
                        Logger.log(((("No room found " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                        return;
                    };
                    this.var_3794.room = _loc4_;
                    this.var_3794.showPopup(param2);
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_626)
                    {
                        if (Util.containsMouse(param2))
                        {
                            Logger.log(("Mouse entered contained element: " + param2.rectangle));
                            return;
                        };
                        _loc5_ = param2.tags[0];
                        param2.color = this.getBgColor(_loc5_);
                        this.var_3794.closePopup();
                    }
                    else
                    {
                        if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                        {
                            _loc6_ = param2.tags[0];
                            if (this._navigator.data.guestRoomSearchResults == null)
                            {
                                Logger.log("No guest room search results while room entry mouse click");
                                return;
                            };
                            _loc7_ = this._navigator.data.guestRoomSearchResults.rooms[_loc6_];
                            if (_loc7_ == null)
                            {
                                Logger.log(((("No room found " + _loc6_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                                return;
                            };
                            if (_loc7_.ownerName != this._navigator.sessionData.userName)
                            {
                                _loc8_ = new Point((param1 as WindowMouseEvent).stageX, (param1 as WindowMouseEvent).stageY);
                                switch (_loc7_.doorMode)
                                {
                                    case RoomSettingsFlatInfo.var_897:
                                        this._navigator.passwordInput.show(_loc7_, _loc8_);
                                        return;
                                    case RoomSettingsFlatInfo.var_896:
                                        this._navigator.doorbell.show(_loc7_, _loc8_);
                                        return;
                                };
                            };
                            this._navigator.goToRoom(_loc7_.flatId, true);
                            this.var_3794.hideInstantly();
                        };
                    };
                };
            };
        }

        private function refreshFavouriteIcon(param1:IWindowContainer, param2:GuestRoomData):void
        {
            var _loc3_:Boolean = this._navigator.data.isRoomFavourite(param2.flatId);
            var _loc4_:Boolean = this.isHome(param2);
            this.refreshRegion(param1, "make_favourite", ((!(_loc3_)) && (!(_loc4_))), this.onAddFavouriteClick);
            this.refreshRegion(param1, "favourite", ((_loc3_) && (!(_loc4_))), this.onRemoveFavouriteClick);
        }

        private function isHome(param1:GuestRoomData):Boolean
        {
            return (param1.flatId == this._navigator.data.homeRoomId);
        }

        private function refreshRegion(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function):void
        {
            var _loc5_:IRegionWindow = (param1.findChildByName(param2) as IRegionWindow);
            if (!param3)
            {
                _loc5_.visible = false;
            }
            else
            {
                _loc5_.procedure = param4;
                _loc5_.visible = true;
                this._navigator.refreshButton(_loc5_, param2, param3, null, 0);
            };
        }

        private function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (!param2)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: target is null!");
            };
            if (!param2.parent)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: target.parent is null!");
            };
            var _loc3_:int = int(param2.parent.tags[0]);
            if (!this._navigator)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: _navigator is null!");
            };
            if (!this._navigator.data)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: _navigator.data is null!");
            };
            if (!this._navigator.data.guestRoomSearchResults)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: _navigator.data.guestRoomSearchResults is null!");
            };
            if (!this._navigator.data.guestRoomSearchResults.rooms)
            {
                ErrorReportStorage.addDebugData("GuestRoomListCtrl", "onRemoveFavouriteClick: _navigator.data.guestRoomSearchResults.rooms is null!");
            };
            var _loc4_:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if (_loc4_ == null)
            {
                Logger.log(((("No room found " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(_loc4_.flatId));
        }

        private function onAddFavouriteClick(event:WindowEvent, target:IWindow):void
        {
            var roomIndex:int;
            var r:GuestRoomData;
            if (event.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            try
            {
                roomIndex = int(target.parent.tags[0]);
                r = this._navigator.data.guestRoomSearchResults.rooms[roomIndex];
                if (r == null)
                {
                    Logger.log(((("No room found " + roomIndex) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                }
                else
                {
                    this._navigator.send(new AddFavouriteRoomMessageComposer(r.flatId));
                };
            }
            catch(e:Error)
            {
            };
        }

        private function hilite(param1:IWindowContainer):void
        {
            var _loc2_:int;
            if (this.var_3795 != null)
            {
                _loc2_ = this.var_3795.tags[0];
                this.var_3795.color = this.getBgColor(_loc2_);
            };
            this.var_3795 = param1;
            param1.color = 4288861930;
        }

        private function checkFastHorizontalMove(param1:WindowEvent):void
        {
            var _loc2_:WindowMouseEvent = WindowMouseEvent(param1);
            var _loc3_:int = Math.abs((this.var_3796 - _loc2_.stageX));
            this.var_3796 = _loc2_.stageX;
            this.var_3797 = (_loc3_ > 2);
        }

    }
}