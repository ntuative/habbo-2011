package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRemovedFromInventoryParser implements IMessageParser 
    {

        private var var_3097:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3097 = param1.readInteger();
            return (true);
        }

        public function get petId():int
        {
            return (this.var_3097);
        }

    }
}