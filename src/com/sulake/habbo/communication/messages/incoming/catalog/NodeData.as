package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NodeData
    {

        private var _navigateable: Boolean;
        private var _color: int;
        private var _icon: int;
        private var _pageId: int;
        private var _localization: String;
        private var _nodes: Array;

        public function NodeData(data: IMessageDataWrapper)
        {
            this._navigateable = Boolean(data.readInteger());
            this._color = data.readInteger();
            this._icon = data.readInteger();
            this._pageId = data.readInteger();
            this._localization = data.readString();
            this._nodes = [];

            var nodeCount: int = data.readInteger();
            var i: int;

            while (i < nodeCount)
            {
                this._nodes.push(new NodeData(data));
                i++;
            }

        }

        public function get navigateable(): Boolean
        {
            return this._navigateable;
        }

        public function get color(): int
        {
            return this._color;
        }

        public function get icon(): int
        {
            return this._icon;
        }

        public function get pageId(): int
        {
            return this._pageId;
        }

        public function get localization(): String
        {
            return this._localization;
        }

        public function get nodes(): Array
        {
            return this._nodes;
        }

    }
}
