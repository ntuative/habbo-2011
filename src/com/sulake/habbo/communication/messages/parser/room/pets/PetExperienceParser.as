package com.sulake.habbo.communication.messages.parser.room.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetExperienceParser implements IMessageParser
    {

        private var _petId: int = -1;
        private var _petRoomIndex: int = -1;
        private var _gainedExperience: int = 0;
        private var _roomId: int = 0;
        private var _roomCategory: int = 0;

        public function get petId(): int
        {
            return this._petId;
        }

        public function get petRoomIndex(): int
        {
            return this._petRoomIndex;
        }

        public function get gainedExperience(): int
        {
            return this._gainedExperience;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._petId = data.readInteger();
            this._petRoomIndex = data.readInteger();
            this._gainedExperience = data.readInteger();
            
            return true;
        }

    }
}
