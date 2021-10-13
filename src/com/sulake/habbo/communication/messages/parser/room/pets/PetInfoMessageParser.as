package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInfoMessageParser implements IMessageParser 
    {

        private var var_3097:int;
        private var _name:String;
        private var var_2924:int;
        private var var_3323:int;
        private var var_3324:int;
        private var _energy:int;
        private var _nutrition:int;
        private var var_2534:String;
        private var var_3325:int;
        private var var_3326:int;
        private var var_3327:int;
        private var var_3328:int;
        private var var_2975:int;
        private var _ownerName:String;
        private var var_3329:int;

        public function get petId():int
        {
            return (this.var_3097);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get level():int
        {
            return (this.var_2924);
        }

        public function get maxLevel():int
        {
            return (this.var_3323);
        }

        public function get experience():int
        {
            return (this.var_3324);
        }

        public function get energy():int
        {
            return (this._energy);
        }

        public function get nutrition():int
        {
            return (this._nutrition);
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get experienceRequiredToLevel():int
        {
            return (this.var_3325);
        }

        public function get maxEnergy():int
        {
            return (this.var_3326);
        }

        public function get maxNutrition():int
        {
            return (this.var_3327);
        }

        public function get respect():int
        {
            return (this.var_3328);
        }

        public function get ownerId():int
        {
            return (this.var_2975);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get age():int
        {
            return (this.var_3329);
        }

        public function flush():Boolean
        {
            this.var_3097 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3097 = param1.readInteger();
            this._name = param1.readString();
            this.var_2924 = param1.readInteger();
            this.var_3323 = param1.readInteger();
            this.var_3324 = param1.readInteger();
            this.var_3325 = param1.readInteger();
            this._energy = param1.readInteger();
            this.var_3326 = param1.readInteger();
            this._nutrition = param1.readInteger();
            this.var_3327 = param1.readInteger();
            this.var_2534 = param1.readString();
            this.var_3328 = param1.readInteger();
            this.var_2975 = param1.readInteger();
            this.var_3329 = param1.readInteger();
            this._ownerName = param1.readString();
            return (true);
        }

    }
}