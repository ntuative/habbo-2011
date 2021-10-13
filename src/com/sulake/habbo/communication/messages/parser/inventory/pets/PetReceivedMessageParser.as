package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetReceivedMessageParser implements IMessageParser 
    {

        private var var_3205:Boolean;
        private var var_3202:PetData;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3205 = param1.readBoolean();
            this.var_3202 = new PetData(param1);
            Logger.log(((((((((((("Got PetReceived: " + this.var_3205) + ", ") + this.var_3202.id) + ", ") + this.var_3202.name) + ", ") + this.var_3202.type) + ", ") + this.var_3202.breed) + ", ") + this.pet.color));
            return (true);
        }

        public function get boughtAsGift():Boolean
        {
            return (this.var_3205);
        }

        public function get pet():PetData
        {
            return (this.var_3202);
        }

    }
}