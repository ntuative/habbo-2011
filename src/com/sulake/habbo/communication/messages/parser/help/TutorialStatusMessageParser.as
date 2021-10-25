package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TutorialStatusMessageParser implements IMessageParser
    {

        private var _hasChangedLooks: Boolean;
        private var _hasChangedName: Boolean;
        private var _hasCalledGuideBot: Boolean;

        public function get hasChangedLooks(): Boolean
        {
            return this._hasChangedLooks;
        }

        public function get hasChangedName(): Boolean
        {
            return this._hasChangedName;
        }

        public function get hasCalledGuideBot(): Boolean
        {
            return this._hasCalledGuideBot;
        }

        public function flush(): Boolean
        {
            this._hasChangedLooks = false;
            this._hasChangedName = false;
            this._hasCalledGuideBot = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._hasChangedLooks = data.readBoolean();
            this._hasChangedName = data.readBoolean();
            this._hasCalledGuideBot = data.readBoolean();
            
            return true;
        }

    }
}
