package com.sulake.habbo.avatar.animation
{

    public class AddDataContainer
    {

        private var _id: String;
        private var _align: String;
        private var _base: String;
        private var _ink: String;
        private var _blend: Number = 1;

        public function AddDataContainer(data: XML)
        {
            this._id = String(data.@id);
            this._align = String(data.@align);
            this._base = String(data.@base);
            this._ink = String(data.@ink);

            var blend: String = String(data.@blend);

            if (blend.length > 0)
            {
                this._blend = Number(blend);

                if (this._blend > 1)
                {
                    this._blend = this._blend / 100;
                }

            }

        }

        public function get id(): String
        {
            return this._id;
        }

        public function get align(): String
        {
            return this._align;
        }

        public function get base(): String
        {
            return this._base;
        }

        public function get ink(): String
        {
            return this._ink;
        }

        public function get blend(): Number
        {
            return this._blend;
        }

        public function get isBlended(): Boolean
        {
            return this._blend != 1;
        }

    }
}
