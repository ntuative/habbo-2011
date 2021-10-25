package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorInitData implements IDisposable
    {

        private var _messageTemplates: Array;
        private var _roomMessageTemplates: Array;
        private var _issues: Array;
        private var _offenceCategories: Array;
        private var _cfhPermission: Boolean;
        private var _chatlogsPermission: Boolean;
        private var _alertPermission: Boolean;
        private var _kickPermission: Boolean;
        private var _banPermission: Boolean;
        private var _roomAlertPermission: Boolean;
        private var _roomKickPermission: Boolean;
        private var _disposed: Boolean;

        public function ModeratorInitData(data: IMessageDataWrapper)
        {
            var issueInfoParser: IssueInfoMessageParser = new IssueInfoMessageParser();
            
            this._issues = [];
            this._messageTemplates = [];
            this._roomMessageTemplates = [];
            this._offenceCategories = [];
            
            var itemCount: int = data.readInteger();
            var i: int;
            
            while (i < itemCount)
            {
                if (issueInfoParser.parse(data))
                {
                    this._issues.push(issueInfoParser.issueData);
                }

                i++;
            }

            itemCount = data.readInteger();
            i = 0;

            while (i < itemCount)
            {
                this._messageTemplates.push(data.readString());
                i++;
            }

            itemCount = data.readInteger();
            i = 0;
            
            while (i < itemCount)
            {
                this._offenceCategories.push(new OffenceCategoryData(data));
                i++;
            }

            this._cfhPermission = data.readBoolean();
            this._chatlogsPermission = data.readBoolean();
            this._alertPermission = data.readBoolean();
            this._kickPermission = data.readBoolean();
            this._banPermission = data.readBoolean();
            this._roomAlertPermission = data.readBoolean();
            this._roomKickPermission = data.readBoolean();
            
            itemCount = data.readInteger();
            i = 0;
            
            while (i < itemCount)
            {
                this._roomMessageTemplates.push(data.readString());
                i++;
            }

        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            this._messageTemplates = null;
            this._roomMessageTemplates = null;
            this._issues = null;
            
            var offenceCategoryData: OffenceCategoryData;
            
            for each (offenceCategoryData in this._offenceCategories)
            {
                offenceCategoryData.dispose();
            }

            this._offenceCategories = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get messageTemplates(): Array
        {
            return this._messageTemplates;
        }

        public function get roomMessageTemplates(): Array
        {
            return this._roomMessageTemplates;
        }

        public function get issues(): Array
        {
            return this._issues;
        }

        public function get offenceCategories(): Array
        {
            return this._offenceCategories;
        }

        public function get cfhPermission(): Boolean
        {
            return this._cfhPermission;
        }

        public function get chatlogsPermission(): Boolean
        {
            return this._chatlogsPermission;
        }

        public function get alertPermission(): Boolean
        {
            return this._alertPermission;
        }

        public function get kickPermission(): Boolean
        {
            return this._kickPermission;
        }

        public function get banPermission(): Boolean
        {
            return this._banPermission;
        }

        public function get roomAlertPermission(): Boolean
        {
            return this._roomAlertPermission;
        }

        public function get roomKickPermission(): Boolean
        {
            return this._roomKickPermission;
        }

    }
}
