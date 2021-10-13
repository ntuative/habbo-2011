package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniConditionMessageParser implements IMessageParser 
    {

        private var var_3349:ConditionDefinition;

        public function flush():Boolean
        {
            this.var_3349 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3349 = new ConditionDefinition(param1);
            return (true);
        }

        public function get def():ConditionDefinition
        {
            return (this.var_3349);
        }

    }
}