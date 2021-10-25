package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicSpaceCastLibsMessageParser implements IMessageParser
    {

        private var _nodeId: int;
        private var _castLibs: String;
        private var _unitPort: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._nodeId = data.readInteger();
            this._castLibs = data.readString();
            this._unitPort = data.readInteger();
            
            return true;
        }

        public function get nodeId(): int
        {
            return this._nodeId;
        }

        public function get castLibs(): String
        {
            return this._castLibs;
        }

        public function get unitPort(): int
        {
            return this._unitPort;
        }

    }
}
