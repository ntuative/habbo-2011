package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _figure: String;
        private var _race: String;
        private var _gender: String;

        public function RoomObjectAvatarFigureUpdateMessage(figure: String, gender: String = null, race: String = null)
        {
            this._figure = figure;
            this._gender = gender;
            this._race = race;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get race(): String
        {
            return this._race;
        }

        public function get gender(): String
        {
            return this._gender;
        }

    }
}
