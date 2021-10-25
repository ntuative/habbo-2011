package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniTriggerMessageParser implements IMessageParser
    {

        private var _def: TriggerDefinition;

        public function flush(): Boolean
        {
            this._def = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._def = new TriggerDefinition(data);

            return true;
        }

        public function get def(): TriggerDefinition
        {
            return this._def;
        }

    }
}
