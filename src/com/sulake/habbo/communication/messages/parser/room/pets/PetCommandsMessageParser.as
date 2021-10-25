package com.sulake.habbo.communication.messages.parser.room.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetCommandsMessageParser implements IMessageParser
    {

        private var _petId: int;
        private var _allCommands: Array;
        private var _enabledCommands: Array;

        public function get petId(): int
        {
            return this._petId;
        }

        public function get allCommands(): Array
        {
            return this._allCommands;
        }

        public function get enabledCommands(): Array
        {
            return this._enabledCommands;
        }

        public function flush(): Boolean
        {
            this._petId = -1;
            this._allCommands = null;
            this._enabledCommands = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._petId = data.readInteger();
            this._allCommands = [];

            var commandCount: int = data.readInteger();
            
            while (commandCount-- > 0)
            {
                this._allCommands.push(data.readInteger());
            }

            this._enabledCommands = [];

            var enabledCommandCount: int = data.readInteger();
            
            while (enabledCommandCount-- > 0)
            {
                this._enabledCommands.push(data.readInteger());
            }

            return true;
        }

    }
}
