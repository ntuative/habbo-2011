package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetCommandsMessageParser implements IMessageParser 
    {

        private var var_3097:int;
        private var var_3320:Array;
        private var var_3321:Array;

        public function get petId():int
        {
            return (this.var_3097);
        }

        public function get allCommands():Array
        {
            return (this.var_3320);
        }

        public function get enabledCommands():Array
        {
            return (this.var_3321);
        }

        public function flush():Boolean
        {
            this.var_3097 = -1;
            this.var_3320 = null;
            this.var_3321 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3097 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this.var_3320 = new Array();
            while (_loc2_-- > 0)
            {
                this.var_3320.push(param1.readInteger());
            };
            var _loc3_:int = param1.readInteger();
            this.var_3321 = new Array();
            while (_loc3_-- > 0)
            {
                this.var_3321.push(param1.readInteger());
            };
            return (true);
        }

    }
}