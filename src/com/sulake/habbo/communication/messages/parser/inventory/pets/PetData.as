﻿package com.sulake.habbo.communication.messages.parser.inventory.pets
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetData
    {

        private var _id: int;
        private var _name: String;
        private var _type: int;
        private var _breed: int;
        private var _color: String;

        public function PetData(data: IMessageDataWrapper)
        {
            this._id = data.readInteger();
            this._name = data.readString();
            this._type = data.readInteger();
            this._breed = data.readInteger();
            this._color = data.readString();
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get breed(): int
        {
            return this._breed;
        }

        public function get color(): String
        {
            return this._color;
        }

        public function get figureString(): String
        {
            return this._type + " " + this.breed + " " + this.color;
        }

    }
}
