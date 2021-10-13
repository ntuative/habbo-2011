package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TutorialStatusMessageParser implements IMessageParser 
    {

        private var var_3189:Boolean;
        private var var_3190:Boolean;
        private var var_3191:Boolean;

        public function get hasChangedLooks():Boolean
        {
            return (this.var_3189);
        }

        public function get hasChangedName():Boolean
        {
            return (this.var_3190);
        }

        public function get hasCalledGuideBot():Boolean
        {
            return (this.var_3191);
        }

        public function flush():Boolean
        {
            this.var_3189 = false;
            this.var_3190 = false;
            this.var_3191 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3189 = param1.readBoolean();
            this.var_3190 = param1.readBoolean();
            this.var_3191 = param1.readBoolean();
            return (true);
        }

    }
}