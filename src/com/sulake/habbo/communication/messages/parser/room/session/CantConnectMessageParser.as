package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CantConnectMessageParser implements IMessageParser 
    {

        public static const var_898:int = 1;
        public static const var_1689:int = 2;
        public static const var_899:int = 3;
        public static const var_900:int = 4;

        private var var_3161:int = 0;
        private var var_2724:String = "";

        public function flush():Boolean
        {
            this.var_3161 = 0;
            this.var_2724 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3161 = param1.readInteger();
            if (this.var_3161 == 3)
            {
                this.var_2724 = param1.readString();
            }
            else
            {
                this.var_2724 = "";
            };
            return (true);
        }

        public function get reason():int
        {
            return (this.var_3161);
        }

        public function get parameter():String
        {
            return (this.var_2724);
        }

    }
}