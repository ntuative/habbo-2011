package com.sulake.habbo.friendbar.data
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.ConversionPointMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;

    public class HabboFriendBarData extends Component implements IHabboFriendBarData
    {

        private static const var_1410: Boolean = false;
        private static const var_1406: String = "FriendBar";
        private static const var_1407: String = "user_interaction";
        private static const TRACKING_EVENT_ACTION_VISIT: String = "visit_btn_click";
        private static const var_1408: String = "chat_btn_click";
        private static const var_1409: String = "find_friends_btn_click";

        private var var_3380: IHabboCommunicationManager;
        private var var_3381: IHabboMessenger;
        private var var_3382: Array;
        private var var_3383: Map;

        public function HabboFriendBarData(param1: HabboFriendBar, param2: uint = 0, param3: IAssetLibrary = null)
        {
            super(param1, param2, param3);
            this.var_3382 = [];
            this.var_3383 = new Map();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerAvailable);
            queueInterface(new IIDHabboMessenger(), this.onMessengerComponentAvailable);
        }

        override public function dispose(): void
        {
            if (!disposed)
            {
                if (this.var_3380)
                {
                    this.var_3380.release(new IIDHabboCommunicationManager());
                    this.var_3380 = null;
                }

                if (this.var_3381)
                {
                    this.var_3381.release(new IIDHabboMessenger());
                    this.var_3381 = null;
                }

                this.var_3382 = null;
                this.var_3383.dispose();
                this.var_3383 = null;
                super.dispose();
            }

        }

        public function get numFriends(): int
        {
            return this.var_3382.length;
        }

        public function getFriendAt(param1: int): IFriendEntity
        {
            return this.var_3382[param1];
        }

        public function getFriendByID(param1: int): IFriendEntity
        {
            return this.var_3383.getValue(param1);
        }

        public function getFriendByName(param1: String): IFriendEntity
        {
            var _loc2_: FriendEntity;
            for each (_loc2_ in this.var_3382)
            {
                if (_loc2_.name == param1)
                {
                    return _loc2_;
                }

            }

            return null;
        }

        public function followToRoom(param1: int): void
        {
            if (this.var_3380)
            {
                this.var_3380.getHabboMainConnection(null).send(new FollowFriendMessageComposer(param1));
                this.var_3380.getHabboMainConnection(null)
                        .send(new ConversionPointMessageComposer(var_1406, var_1407, TRACKING_EVENT_ACTION_VISIT));
            }

        }

        public function startConversation(param1: int): void
        {
            if (this.var_3381)
            {
                this.var_3381.startConversation(param1);
                if (this.var_3380)
                {
                    this.var_3380.getHabboMainConnection(null)
                            .send(new ConversionPointMessageComposer(var_1406, var_1407, var_1408));
                }

            }

        }

        public function findNewFriends(): void
        {
            if (this.var_3380)
            {
                this.var_3380.getHabboMainConnection(null).send(new FindNewFriendsMessageComposer());
                this.var_3380.getHabboMainConnection(null)
                        .send(new ConversionPointMessageComposer(var_1406, var_1407, var_1409));
            }

        }

        private function onCommunicationManagerAvailable(param1: IID, param2: IUnknown): void
        {
            this.var_3380 = (param2 as IHabboCommunicationManager);
            this.var_3380.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInitialized));
            this.var_3380.addHabboConnectionMessageEvent(new FriendListUpdateEvent(this.onFriendListUpdate));
            this.var_3380.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(this.onFindFriendProcessResult));
        }

        private function onMessengerComponentAvailable(param1: IID, param2: IUnknown): void
        {
            this.var_3381 = (param2 as IHabboMessenger);
        }

        private function onMessengerInitialized(param1: IMessageEvent): void
        {
            this.buildFriendList(MessengerInitEvent(param1).getParser().friends);
        }

        private function onFriendListUpdate(param1: IMessageEvent): void
        {
            var _loc3_: FriendEntity;
            var _loc4_: FriendData;
            var _loc8_: int;
            var _loc2_: FriendListUpdateMessageParser = FriendListUpdateEvent(param1).getParser();
            var _loc5_: Array = _loc2_.removedFriendIds;
            var _loc6_: Array = _loc2_.updatedFriends;
            var _loc7_: Array = _loc2_.addedFriends;
            for each (_loc8_ in _loc5_)
            {
                _loc3_ = this.var_3383.getValue(_loc8_);
                if (_loc3_)
                {
                    this.var_3383.remove(_loc8_);
                    this.var_3382.splice(this.var_3382.indexOf(_loc3_), 1);
                }

            }

            for each (_loc4_ in _loc6_)
            {
                _loc3_ = this.var_3383.getValue(_loc4_.id);
                if (_loc3_)
                {
                    if (_loc4_.online || var_1410)
                    {
                        _loc3_.name = _loc4_.name;
                        _loc3_.realName = _loc4_.realName;
                        _loc3_.motto = _loc4_.motto;
                        _loc3_.gender = _loc4_.gender;
                        _loc3_.online = _loc4_.online;
                        _loc3_.allowFollow = _loc4_.followingAllowed;
                        _loc3_.figure = _loc4_.figure;
                        _loc3_.categoryId = _loc4_.categoryId;
                        _loc3_.lastAccess = _loc4_.lastAccess;
                    }
                    else
                    {
                        this.var_3383.remove(_loc4_.id);
                        this.var_3382.splice(this.var_3382.indexOf(_loc3_), 1);
                    }

                }
                else
                {
                    if (_loc4_.online || var_1410)
                    {
                        _loc3_ = new FriendEntity(_loc4_.id, _loc4_.name, _loc4_.realName, _loc4_.motto, _loc4_.gender, _loc4_.online, _loc4_.followingAllowed, _loc4_.figure, _loc4_.categoryId, _loc4_.lastAccess);
                        this.var_3382.push(_loc3_);
                        this.var_3383.add(_loc3_.id, _loc3_);
                    }

                }

            }

            for each (_loc4_ in _loc7_)
            {
                if (_loc4_.online || var_1410)
                {
                    if (this.var_3383.getValue(_loc4_.id) == null)
                    {
                        _loc3_ = new FriendEntity(_loc4_.id, _loc4_.name, _loc4_.realName, _loc4_.motto, _loc4_.gender, _loc4_.online, _loc4_.followingAllowed, _loc4_.figure, _loc4_.categoryId, _loc4_.lastAccess);
                        this.var_3382.push(_loc3_);
                        this.var_3383.add(_loc3_.id, _loc3_);
                    }

                }

            }

            if (_loc7_.length > 0 || _loc6_.length > 0)
            {
                this.var_3382 = var_1410
                        ? this.sortByNameAndOnlineStatus(this.var_3382)
                        : this.sortByName(this.var_3382);
            }

            events.dispatchEvent(new FriendBarUpdateEvent(FriendBarUpdateEvent.var_1385));
        }

        private function onFindFriendProcessResult(param1: FindFriendsProcessResultEvent): void
        {
            events.dispatchEvent(new FindFriendsNotificationEvent(param1.success));
        }

        private function buildFriendList(param1: Array): void
        {
            var _loc2_: FriendData;
            var _loc3_: FriendEntity;
            for each (_loc2_ in param1)
            {
                if (_loc2_.online || var_1410)
                {
                    _loc3_ = new FriendEntity(_loc2_.id, _loc2_.name, _loc2_.realName, _loc2_.motto, _loc2_.gender, _loc2_.online, _loc2_.followingAllowed, _loc2_.figure, _loc2_.categoryId, _loc2_.lastAccess);
                    this.var_3382.push(_loc3_);
                    this.var_3383.add(_loc3_.id, _loc3_);
                }

            }

            this.var_3382 = var_1410 ? this.sortByNameAndOnlineStatus(this.var_3382) : this.sortByName(this.var_3382);
            events.dispatchEvent(new FriendBarUpdateEvent(FriendBarUpdateEvent.var_1385));
        }

        private function sortByName(param1: Array): Array
        {
            param1.sortOn("name", [Array.CASEINSENSITIVE]);
            return param1;
        }

        private function sortByNameAndOnlineStatus(param1: Array): Array
        {
            var _loc4_: FriendEntity;
            var _loc2_: Array = [];
            var _loc3_: Array = [];
            var _loc5_: int = param1.length;
            while (_loc5_-- > 0)
            {
                _loc4_ = param1[_loc5_];
                if (_loc4_.online)
                {
                    _loc2_.push(_loc4_);
                }
                else
                {
                    _loc3_.push(_loc4_);
                }

            }

            _loc2_.sortOn("name", [Array.CASEINSENSITIVE]);
            _loc3_.sortOn("name", [(Array.CASEINSENSITIVE | Array.DESCENDING)]);
            _loc5_ = _loc3_.length;
            while (_loc5_-- > 0)
            {
                _loc2_.push(_loc3_.pop());
            }

            return _loc2_;
        }

    }
}
