package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniConditionMessageParser implements IMessageParser
    {

        private var _def: ConditionDefinition;

        public function flush(): Boolean
        {
            this._def = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._def = new ConditionDefinition(data);

            return true;
        }

        public function get def(): ConditionDefinition
        {
            return this._def;
        }

    }
}
