package com.sulake.habbo.avatar.pets
{
    public class Breed extends PetEditorInfo implements IBreed 
    {

        private var _id:int;
        private var var_2502:String = "";
        private var var_2071:String;
        private var var_2503:Boolean;
        private var var_2504:Boolean = true;
        private var var_2505:int;
        private var var_2506:String;

        public function Breed(param1:XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            this.var_2505 = parseInt(param1.@pattern);
            this.var_2071 = String(param1.@gender);
            this.var_2503 = Boolean(parseInt(param1.@colorable));
            this.var_2502 = String(param1.@localizationKey);
            if (((Boolean(param1.@sellable)) && (param1.@sellable == "0")))
            {
                this.var_2504 = false;
            };
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get gender():String
        {
            return (this.var_2071);
        }

        public function get isColorable():Boolean
        {
            return (this.var_2503);
        }

        public function get isSellable():Boolean
        {
            return (this.var_2504);
        }

        public function get patternId():int
        {
            return (this.var_2505);
        }

        public function get avatarFigureString():String
        {
            return (this.var_2506);
        }

        public function set avatarFigureString(param1:String):void
        {
            this.var_2506 = param1;
        }

        public function get localizationKey():String
        {
            return (this.var_2502);
        }

    }
}