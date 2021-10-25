package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoFeedEnableMessageParser implements IMessageParser
    {

        private var _enabled: Boolean;

        public function flush(): Boolean
        {
            this._enabled = false;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._enabled = data.readBoolean();

            return true;
        }

        public function get enabled(): Boolean
        {
            return this._enabled;
        }

    }
}
