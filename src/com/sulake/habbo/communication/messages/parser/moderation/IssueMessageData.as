package com.sulake.habbo.communication.messages.parser.moderation
{

    public class IssueMessageData
    {

        public static const PRIORITY_HIGH: int = 1;
        public static const PRIORITY_MEDIUM: int = 2;
        public static const PRIORITY_LOW: int = 3;

        private var _issueId: int;
        private var _state: int;
        private var _categoryId: int;
        private var _reportedCategoryId: int;
        private var _timestamp: int;
        private var _priority: int;
        private var _temporalPriority: int = 0;
        private var _reporterUserId: int;
        private var _reporterUserName: String;
        private var _reportedUserId: int;
        private var _reportedUserName: String;
        private var _pickerUserId: int;
        private var _pickerUserName: String;
        private var _message: String;
        private var _chatRecordId: int;
        private var _roomName: String;
        private var _roomType: int;
        private var _flatType: String;
        private var _flatId: int;
        private var _flatOwnerName: String;
        private var _roomResources: String;
        private var _unitPort: int;
        private var _worldId: int;

        public function IssueMessageData(issueId: int, state: int, categoryId: int, reportedCategoryId: int, timestamp: int, priority: int, reporterUserId: int, reporterUserName: String, reportedUserId: int, reportedUserName: String, pickerUserId: int, pickerUserName: String, message: String, chatRecordId: int, roomName: String, roomType: int, flatType: String, flatId: int, flatOwnerName: String, roomResources: String, unitPort: int, worldId: int)
        {
            this._issueId = issueId;
            this._state = state;
            this._categoryId = categoryId;
            this._reportedCategoryId = reportedCategoryId;
            this._timestamp = timestamp;
            this._priority = priority;
            this._reporterUserId = reporterUserId;
            this._reporterUserName = reporterUserName;
            this._reportedUserId = reportedUserId;
            this._reportedUserName = reportedUserName;
            this._pickerUserId = pickerUserId;
            this._pickerUserName = pickerUserName;
            this._message = message;
            this._chatRecordId = chatRecordId;
            this._roomName = roomName;
            this._roomType = roomType;
            this._flatType = flatType;
            this._flatId = flatId;
            this._flatOwnerName = flatOwnerName;
            this._roomResources = roomResources;
            this._unitPort = unitPort;
            this._worldId = worldId;
        }

        public function get issueId(): int
        {
            return this._issueId;
        }

        public function get state(): int
        {
            return this._state;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get reportedCategoryId(): int
        {
            return this._reportedCategoryId;
        }

        public function get timeStamp(): int
        {
            return this._timestamp;
        }

        public function get priority(): int
        {
            return this._priority + this._temporalPriority;
        }

        public function get reporterUserId(): int
        {
            return this._reporterUserId;
        }

        public function get reporterUserName(): String
        {
            return this._reporterUserName;
        }

        public function get reportedUserId(): int
        {
            return this._reportedUserId;
        }

        public function get reportedUserName(): String
        {
            return this._reportedUserName;
        }

        public function get pickerUserId(): int
        {
            return this._pickerUserId;
        }

        public function get pickerUserName(): String
        {
            return this._pickerUserName;
        }

        public function get message(): String
        {
            return this._message;
        }

        public function get chatRecordId(): int
        {
            return this._chatRecordId;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

        public function get roomType(): int
        {
            return this._roomType;
        }

        public function get flatType(): String
        {
            return this._flatType;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get flatOwnerName(): String
        {
            return this._flatOwnerName;
        }

        public function get roomResources(): String
        {
            return this._roomResources;
        }

        public function get unitPort(): int
        {
            return this._unitPort;
        }

        public function get worldId(): int
        {
            return this._worldId;
        }

        public function set temporalPriority(param1: int): void
        {
            this._temporalPriority = param1;
        }

        public function getOpenTime(param1: int): String
        {
            var _loc2_: int = int((param1 - this._timestamp) / 1000);
            var _loc3_: int = _loc2_ % 60;
            var _loc4_: int = int(_loc2_ / 60);
            var _loc5_: int = _loc4_ % 60;
            var _loc6_: int = int(_loc4_ / 60);
            var _loc7_: String = _loc3_ < 10 ? "0" + _loc3_ : "" + _loc3_;
            var _loc8_: String = _loc5_ < 10 ? "0" + _loc5_ : "" + _loc5_;
            var _loc9_: String = _loc6_ < 10 ? "0" + _loc6_ : "" + _loc6_;
            return _loc9_ + ":" + _loc8_ + ":" + _loc7_;
        }

    }
}
