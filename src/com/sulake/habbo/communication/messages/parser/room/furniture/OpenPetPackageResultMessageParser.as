package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageResultMessageParser implements IMessageParser 
    {

        private var var_2358:int = 0;
        private var var_3311:int = 0;
        private var var_2715:String = null;

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get nameValidationStatus():int
        {
            return (this.var_3311);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_2715);
        }

        public function flush():Boolean
        {
            this.var_2358 = 0;
            this.var_3311 = 0;
            this.var_2715 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_2358 = param1.readInteger();
            this.var_3311 = param1.readInteger();
            this.var_2715 = param1.readString();
            return (true);
        }

    }
}