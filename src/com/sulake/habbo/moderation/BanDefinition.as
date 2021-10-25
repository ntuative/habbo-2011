package com.sulake.habbo.moderation
{

    public class BanDefinition
    {

        private var _name: String;
        private var _banLengthHours: int;

        public function BanDefinition(name: String, banLengthHours: int)
        {
            this._name = name;
            this._banLengthHours = banLengthHours;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get banLengthHours(): int
        {
            return this._banLengthHours;
        }

    }
}
