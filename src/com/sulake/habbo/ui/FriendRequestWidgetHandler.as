package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetFriendRequestMessage;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;

    import flash.geom.Rectangle;

    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.widget.events.RoomWidgetFriendRequestUpdateEvent;

    import flash.events.Event;

    public class FriendRequestWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_273;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function dispose(): void
        {
            this._disposed = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetGetUserLocationMessage.var_1813);
            _loc1_.push(RoomWidgetFriendRequestMessage.var_1315);
            _loc1_.push(RoomWidgetFriendRequestMessage.var_1316);
            return _loc1_;
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetGetUserLocationMessage;
            var _loc3_: IRoomSession;
            var _loc4_: IUserData;
            var _loc5_: Rectangle;
            var _loc6_: RoomWidgetFriendRequestMessage;
            var _loc7_: RoomWidgetFriendRequestMessage;
            var _loc8_: Rectangle;
            if (!param1 || !this._container)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetGetUserLocationMessage.var_1813:
                    _loc2_ = (param1 as RoomWidgetGetUserLocationMessage);
                    if (!_loc2_)
                    {
                        return null;
                    }

                    _loc3_ = this._container.roomSession;
                    if (!_loc3_ || !_loc3_.userDataManager)
                    {
                        return null;
                    }

                    _loc4_ = _loc3_.userDataManager.getUserDataByType(_loc2_.userId, _loc2_.userType);
                    if (_loc4_)
                    {
                        _loc5_ = this._container.roomEngine.getRoomObjectBoundingRectangle(_loc3_.roomId, _loc3_.roomCategory, _loc4_.id, RoomObjectCategoryEnum.var_71, this._container.getFirstCanvasId());
                        _loc8_ = this._container.getRoomViewRect();
                        if (_loc5_ && _loc8_)
                        {
                            _loc5_.offset(_loc8_.x, _loc8_.y);
                        }

                    }

                    return new RoomWidgetUserLocationUpdateEvent(_loc2_.userId, _loc5_);
                case RoomWidgetFriendRequestMessage.var_1315:
                    _loc6_ = (param1 as RoomWidgetFriendRequestMessage);
                    if (!_loc6_ || !this._container.friendList)
                    {
                        return null;
                    }

                    this._container.friendList.acceptFriendRequest(_loc6_.requestId);
                    break;
                case RoomWidgetFriendRequestMessage.var_1316:
                    _loc7_ = (param1 as RoomWidgetFriendRequestMessage);
                    if (!_loc7_ || !this._container.friendList)
                    {
                        return null;
                    }

                    this._container.friendList.declineFriendRequest(_loc7_.requestId);
                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomSessionFriendRequestEvent.var_277);
            _loc1_.push(FriendRequestEvent.FRIEND_REQUEST_ACCEPTED);
            _loc1_.push(FriendRequestEvent.FRIEND_REQUEST_DECLINED);
            return _loc1_;
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomWidgetFriendRequestUpdateEvent;
            var _loc3_: String;
            var _loc4_: RoomSessionFriendRequestEvent;
            var _loc5_: FriendRequestEvent;
            if (this._container == null || this._container.events == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomSessionFriendRequestEvent.var_277:
                    _loc4_ = (param1 as RoomSessionFriendRequestEvent);
                    if (!_loc4_)
                    {
                        return;
                    }

                    _loc3_ = RoomWidgetFriendRequestUpdateEvent.var_1313;
                    _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_, _loc4_.requestId, _loc4_.userId, _loc4_.userName);
                    break;
                case FriendRequestEvent.FRIEND_REQUEST_ACCEPTED:
                case FriendRequestEvent.FRIEND_REQUEST_DECLINED:
                    _loc5_ = (param1 as FriendRequestEvent);
                    if (!_loc5_)
                    {
                        return;
                    }

                    _loc3_ = RoomWidgetFriendRequestUpdateEvent.var_1314;
                    _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_, _loc5_.requestId);
                    break;
            }

            if (_loc2_)
            {
                this._container.events.dispatchEvent(_loc2_);
            }

        }

        public function update(): void
        {
        }

    }
}
