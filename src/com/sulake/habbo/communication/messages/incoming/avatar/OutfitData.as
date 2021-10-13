package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OutfitData 
    {

        private var var_2538:int;
        private var var_2474:String;
        private var var_2071:String;

        public function OutfitData(param1:IMessageDataWrapper)
        {
            this.var_2538 = param1.readInteger();
            this.var_2474 = param1.readString();
            this.var_2071 = param1.readString();
        }

        public function get slotId():int
        {
            return (this.var_2538);
        }

        public function get figureString():String
        {
            return (this.var_2474);
        }

        public function get gender():String
        {
            return (this.var_2071);
        }

    }
}