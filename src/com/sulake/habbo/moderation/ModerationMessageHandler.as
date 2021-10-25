package com.sulake.habbo.moderation
{

    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogMessageParser;

    import flash.utils.Dictionary;

    import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.moderation.*;
    import com.sulake.habbo.communication.messages.parser.moderation.*;

    public class ModerationMessageHandler
    {

        private var _connection: IConnection;
        private var var_3663: ModerationManager;
        private var var_3696: Array = [];
        private var var_3697: Array = [];
        private var var_3698: Array = [];
        private var var_3699: Array = [];
        private var var_3700: Array = [];

        public function ModerationMessageHandler(param1: ModerationManager)
        {
            this.var_3663 = param1;
            this._connection = param1.connection;
            this._connection.addMessageEvent(new IssueInfoMessageEvent(this.onIssueInfo));
            this._connection.addMessageEvent(new ModeratorInitMessageEvent(this.onModeratorInit));
            this._connection.addMessageEvent(new IssuePickFailedMessageEvent(this.onIssuePickFailed));
            this._connection.addMessageEvent(new IssueDeletedMessageEvent(this.onIssueDeleted));
            this._connection.addMessageEvent(new ModeratorUserInfoEvent(this.onUserInfo));
            this._connection.addMessageEvent(new ModeratorRoomInfoEvent(this.onRoomInfo));
            this._connection.addMessageEvent(new CfhChatlogEvent(this.onCfhChatlog));
            this._connection.addMessageEvent(new UserChatlogEvent(this.onUserChatlog));
            this._connection.addMessageEvent(new RoomChatlogEvent(this.onRoomChatlog));
            this._connection.addMessageEvent(new RoomVisitsEvent(this.onRoomVisits));
            this._connection.addMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._connection.addMessageEvent(new PublicSpaceCastLibsEvent(this.onPublicSpaceCastLibs));
            this._connection.addMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._connection.addMessageEvent(new ModeratorActionResultMessageEvent(this.onModeratorActionResult));
        }

        private function onIssueInfo(param1: IssueInfoMessageEvent): void
        {
            if (param1 == null || this.var_3663 == null)
            {
                return;
            }

            var _loc2_: IssueInfoMessageParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IssueMessageData = _loc2_.issueData;
            this.var_3663.issueManager.playSound(_loc3_);
            this.var_3663.issueManager.updateIssue(_loc3_);
        }

        private function onModeratorInit(param1: ModeratorInitMessageEvent): void
        {
            var _loc6_: IssueMessageData;
            if (param1 == null || this.var_3663 == null)
            {
                return;
            }

            var _loc2_: ModeratorInitMessageParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: ModeratorInitData = _loc2_.data;
            var _loc4_: Array = _loc3_.issues;
            var _loc5_: Array = _loc3_.messageTemplates;
            for each (_loc6_ in _loc4_)
            {
                this.var_3663.issueManager.updateIssue(_loc6_);
            }

            this.var_3663.issueManager.updatePriorities();
            this.var_3663.initMsg = _loc3_;
            this.var_3663.startPanel.show();
        }

        private function onIssuePickFailed(event: IssuePickFailedMessageEvent): void
        {
            var parser: IssuePickFailedMessageParser = event.getParser();
            if (parser == null)
            {
                return;
            }

            var alert: Boolean = true;
            var issues: Array = parser.issues;
            var retryEnabled: Boolean = parser.retryEnabled;
            var retryCount: int = parser.retryCount;
            var pickedAlready: Boolean = this.var_3663.issueManager.issuePickFailed(issues);
            if (pickedAlready)
            {
                if (retryEnabled)
                {
                    if (retryCount < 10)
                    {
                        alert = false;
                        this.var_3663.issueManager.autoPick(retryEnabled, retryCount);
                    }

                }

            }

            if (alert)
            {
                this.var_3663.windowManager.alert("Error", "Issue picking failed", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                {
                    param1.dispose();
                });
            }

        }

        private function onIssueDeleted(param1: IssueDeletedMessageEvent): void
        {
            if (param1 == null || this.var_3663 == null)
            {
                return;
            }

            var _loc2_: IssueDeletedMessageParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            }

            this.var_3663.issueManager.removeIssue(_loc2_.issueId);
        }

        private function onUserInfo(param1: ModeratorUserInfoEvent): void
        {
            var _loc3_: UserInfoCtrl;
            var _loc2_: ModeratorUserInfoMessageParser = param1.getParser();
            Logger.log("GOT USER INFO: " + _loc2_.data.userId + ", " + _loc2_.data.cautionCount);
            for each (_loc3_ in this.var_3696)
            {
                _loc3_.onUserInfo(_loc2_.data);
            }

        }

        private function onRoomInfo(param1: ModeratorRoomInfoEvent): void
        {
            var _loc3_: RoomToolCtrl;
            var _loc2_: ModeratorRoomInfoMessageParser = param1.getParser();
            for each (_loc3_ in this.var_3699)
            {
                _loc3_.onRoomInfo(_loc2_.data);
            }

        }

        private function onCfhChatlog(param1: CfhChatlogEvent): void
        {
            var _loc2_: CfhChatlogMessageParser = param1.getParser();
            var _loc3_: Array = [];
            _loc3_.push(_loc2_.data.room);
            var _loc4_: Dictionary = new Dictionary();
            _loc4_[_loc2_.data.callerUserId] = "yes";
            _loc4_[_loc2_.data.reportedUserId] = "yes";
            this.onChatlog("Call For Help Chatlog: " + _loc2_.data.chatRecordId, WindowTracker.var_1519, _loc2_.data.callId, _loc3_, _loc4_);
        }

        private function onRoomChatlog(param1: RoomChatlogEvent): void
        {
            var _loc2_: RoomChatlogMessageParser = param1.getParser();
            var _loc3_: Array = [];
            _loc3_.push(_loc2_.data);
            var _loc4_: Dictionary = new Dictionary();
            this.onChatlog("Room Chatlog: " + _loc2_.data.roomName, WindowTracker.var_1518, _loc2_.data.roomId, _loc3_, _loc4_);
        }

        private function onUserChatlog(param1: UserChatlogEvent): void
        {
            var _loc2_: UserChatlogMessageParser = param1.getParser();
            var _loc3_: Dictionary = new Dictionary();
            _loc3_[_loc2_.data.userId] = "yes";
            this.onChatlog("User Chatlog: " + _loc2_.data.userName, WindowTracker.var_1520, _loc2_.data.userId, _loc2_.data.rooms, _loc3_);
        }

        private function onChatlog(param1: String, param2: int, param3: int, param4: Array, param5: Dictionary): void
        {
            var _loc6_: ChatlogCtrl;
            for each (_loc6_ in this.var_3698)
            {
                _loc6_.onChatlog(param1, param2, param3, param4, param5);
            }

        }

        private function onRoomVisits(param1: RoomVisitsEvent): void
        {
            var _loc3_: RoomVisitsCtrl;
            var _loc2_: RoomVisitsMessageParser = param1.getParser();
            for each (_loc3_ in this.var_3697)
            {
                _loc3_.onRoomVisits(_loc2_.data);
            }

        }

        private function onRoomEnter(param1: RoomEntryInfoMessageEvent): void
        {
            var _loc3_: RoomToolCtrl;
            var _loc2_: RoomEntryInfoMessageParser = param1.getParser();
            if (_loc2_.guestRoom)
            {
                this.var_3663.currentFlatId = _loc2_.guestRoomId;
                this.var_3663.startPanel.guestRoomEntered(_loc2_);
            }
            else
            {
                this.var_3663.currentFlatId = 0;
            }

            for each (_loc3_ in this.var_3700)
            {
                _loc3_.onRoomChange();
            }

        }

        private function onPublicSpaceCastLibs(param1: PublicSpaceCastLibsEvent): void
        {
            var _loc2_: PublicSpaceCastLibsMessageParser = param1.getParser();
            this.var_3663.startPanel.publicSpaceEntered(_loc2_);
        }

        private function onRoomExit(param1: CloseConnectionMessageEvent): void
        {
            var _loc2_: RoomToolCtrl;
            this.var_3663.currentFlatId = 0;
            this.var_3663.startPanel.roomExited();
            for each (_loc2_ in this.var_3700)
            {
                _loc2_.onRoomChange();
            }

        }

        private function onModeratorActionResult(param1: ModeratorActionResultMessageEvent): void
        {
            var _loc2_: ModeratorActionResultMessageParser = param1.getParser();
            Logger.log("GOT MOD ACTION RESULT: " + _loc2_.userId + ", " + _loc2_.success);
            if (_loc2_.success)
            {
                this.var_3663.connection.send(new GetModeratorUserInfoMessageComposer(_loc2_.userId));
            }
            else
            {
                this.var_3663.windowManager.alert("Alert", "Moderation action failed", 0, this.onAlertClose);
            }

        }

        public function addUserInfoListener(param1: UserInfoCtrl): void
        {
            this.var_3696.push(param1);
        }

        public function removeUserInfoListener(param1: UserInfoCtrl): void
        {
            var _loc3_: UserInfoCtrl;
            var _loc2_: Array = [];
            for each (_loc3_ in this.var_3696)
            {
                if (_loc3_ != param1)
                {
                    _loc2_.push(_loc3_);
                }

            }

            this.var_3696 = _loc2_;
        }

        public function addRoomInfoListener(param1: RoomToolCtrl): void
        {
            this.var_3699.push(param1);
        }

        public function removeRoomInfoListener(param1: RoomToolCtrl): void
        {
            var _loc3_: RoomToolCtrl;
            var _loc2_: Array = [];
            for each (_loc3_ in this.var_3699)
            {
                if (_loc3_ != param1)
                {
                    _loc2_.push(_loc3_);
                }

            }

            this.var_3699 = _loc2_;
        }

        public function addRoomEnterListener(param1: RoomToolCtrl): void
        {
            this.var_3700.push(param1);
        }

        public function removeRoomEnterListener(param1: RoomToolCtrl): void
        {
            var _loc3_: RoomToolCtrl;
            var _loc2_: Array = [];
            for each (_loc3_ in this.var_3700)
            {
                if (_loc3_ != param1)
                {
                    _loc2_.push(_loc3_);
                }

            }

            this.var_3700 = _loc2_;
        }

        public function addRoomVisitsListener(param1: RoomVisitsCtrl): void
        {
            this.var_3697.push(param1);
        }

        public function removeRoomVisitsListener(param1: RoomVisitsCtrl): void
        {
            var _loc3_: RoomVisitsCtrl;
            var _loc2_: Array = [];
            for each (_loc3_ in this.var_3697)
            {
                if (_loc3_ != param1)
                {
                    _loc2_.push(_loc3_);
                }

            }

            this.var_3697 = _loc2_;
        }

        public function addChatlogListener(param1: ChatlogCtrl): void
        {
            this.var_3698.push(param1);
        }

        public function removeChatlogListener(param1: ChatlogCtrl): void
        {
            var _loc3_: ChatlogCtrl;
            var _loc2_: Array = [];
            for each (_loc3_ in this.var_3698)
            {
                if (_loc3_ != param1)
                {
                    _loc2_.push(_loc3_);
                }

            }

            this.var_3698 = _loc2_;
        }

        private function onAlertClose(param1: IAlertDialog, param2: WindowEvent): void
        {
            param1.dispose();
        }

    }
}
