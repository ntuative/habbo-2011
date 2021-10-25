package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.communication.messages.IMessageParser;

    import flash.utils.getTimer;

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueInfoMessageParser implements IMessageParser
    {

        private var _issueData: IssueMessageData;

        public function get issueData(): IssueMessageData
        {
            return this._issueData;
        }

        public function flush(): Boolean
        {
            this._issueData = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var roomResources: String;
            var unitPort: int;
            var worldId: int;
            var flatType: String;
            var flatId: int;
            var flatOwnerName: String;

            var issueId: int = data.readInteger();
            var state: int = data.readInteger();
            var categoryId: int = data.readInteger();
            var reportedCategoryId: int = data.readInteger();
            var timestamp: int = getTimer() - data.readInteger();
            var priority: int = data.readInteger();
            var reporterUserId: int = data.readInteger();
            var reporterUserName: String = data.readString();
            var reportedUserId: int = data.readInteger();
            var reportedUserName: String = data.readString();
            var pickerUserId: int = data.readInteger();
            var pickerUserName: String = data.readString();
            var message: String = data.readString();
            var chatRecordId: int = data.readInteger();
            var roomName: String = data.readString();
            var roomType: int = data.readInteger();
            
            if (roomType == 0)
            {
                roomResources = data.readString();
                unitPort = data.readInteger();
                worldId = data.readInteger();
            }
            else {
                flatType = data.readString();
                flatId = data.readInteger();
                flatOwnerName = data.readString();
            }


            this._issueData = new IssueMessageData(
                issueId,
                state,
                categoryId,
                reportedCategoryId,
                timestamp,
                priority,
                reporterUserId,
                reporterUserName,
                reportedUserId,
                reportedUserName,
                pickerUserId,
                pickerUserName,
                message,
                chatRecordId,
                roomName,
                roomType,
                flatType,
                flatId,
                flatOwnerName,
                roomResources,
                unitPort,
                worldId
            );
            
            return true;
        }

    }
}
