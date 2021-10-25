package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCategory
    {

        private var _nodeId: int;
        private var _nodeName: String;
        private var _visible: Boolean;

        public function FlatCategory(data: IMessageDataWrapper)
        {
            this._nodeId = data.readInteger();
            this._nodeName = data.readString();
            this._visible = data.readBoolean();
        }

        public function get nodeId(): int
        {
            return this._nodeId;
        }

        public function get nodeName(): String
        {
            return this._nodeName;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

    }
}
