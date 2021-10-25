package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniActionMessageParser implements IMessageParser
    {

        private var _def: ActionDefinition;

        public function flush(): Boolean
        {
            this._def = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._def = new ActionDefinition(data);

            return true;
        }

        public function get def(): ActionDefinition
        {
            return this._def;
        }

    }
}
