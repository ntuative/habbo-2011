package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularTagData
    {

        private var _tagName: String;
        private var _userCount: int;

        public function PopularTagData(data: IMessageDataWrapper)
        {
            this._tagName = data.readString();
            this._userCount = data.readInteger();
        }

        public function get tagName(): String
        {
            return this._tagName;
        }

        public function get userCount(): int
        {
            return this._userCount;
        }

    }
}
