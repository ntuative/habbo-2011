package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectActivatedMessageParser implements IMessageParser
    {

        private var _type: int;
        private var _duration: int;

        public function flush(): Boolean
        {
            this._type = 0;
            this._duration = 0;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._type = data.readInteger();
            this._duration = data.readInteger();

            return true;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get duration(): int
        {
            return this._duration;
        }

    }
}
