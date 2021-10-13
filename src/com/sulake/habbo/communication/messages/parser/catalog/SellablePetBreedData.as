package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedData 
    {

        private var _type:int;
        private var var_2517:int;
        private var var_3137:Boolean;
        private var var_3138:Boolean;

        public function SellablePetBreedData(param1:IMessageDataWrapper)
        {
            this._type = param1.readInteger();
            this.var_2517 = param1.readInteger();
            this.var_3137 = param1.readBoolean();
            this.var_3138 = param1.readBoolean();
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get breed():int
        {
            return (this.var_2517);
        }

        public function get sellable():Boolean
        {
            return (this.var_3137);
        }

        public function get rare():Boolean
        {
            return (this.var_3138);
        }

    }
}