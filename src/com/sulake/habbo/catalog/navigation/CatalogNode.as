package com.sulake.habbo.catalog.navigation
{

    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;

    import flash.display.BitmapData;

    public class CatalogNode implements ICatalogNode
    {

        private static const COLORS: Array = [
            4293190884,
            4293914607,
            0xFFFFDB54,
            4289454682,
            4289431551,
            4285716709,
            4294016606,
            4293326172,
            4293694138,
            4285383659,
            4293082689,
            4288782753
        ];
        private static const ICON_PREFIX: String = "icon_";

        private var _depth: int = 0;
        private var _isNavigateable: Boolean = false;
        private var _localization: String = "";
        private var _pageId: int = -1;
        private var _color: uint = 0;
        private var _icon: int = 0;
        private var _children: Array = [];
        private var _navigator: ICatalogNavigator;
        private var _parent: ICatalogNode;

        public function CatalogNode(navigator: ICatalogNavigator, data: NodeData, depth: int)
        {
            this._depth = depth;
            this._navigator = navigator;
            this._isNavigateable = data.navigateable;
            this._localization = data.localization;
            this._pageId = data.pageId;
            this._color = COLORS[data.color];
            this._icon = data.icon;
            this._children = [];
        }

        public function get isOpen(): Boolean
        {
            return false;
        }

        public function get depth(): int
        {
            return this._depth;
        }

        public function get isBranch(): Boolean
        {
            return this._children.length > 0;
        }

        public function get isLeaf(): Boolean
        {
            return this._children.length == 0;
        }

        public function get isNavigateable(): Boolean
        {
            return this._isNavigateable;
        }

        public function get localization(): String
        {
            return this._localization;
        }

        public function get pageId(): int
        {
            return this._pageId;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get icon(): BitmapData
        {
            return null;
        }

        public function get children(): Array
        {
            return this._children;
        }

        public function get navigator(): ICatalogNavigator
        {
            return this._navigator;
        }

        public function get parent(): ICatalogNode
        {
            return this._parent;
        }

        public function set parent(param1: ICatalogNode): void
        {
            this._parent = param1;
        }

        public function dispose(): void
        {
            var _loc1_: ICatalogNode;
            for each (_loc1_ in this._children)
            {
                _loc1_.dispose();
            }

            this._children = null;
            this._navigator = null;
            this._parent = null;
        }

        public function hasChild(node: ICatalogNode): Boolean
        {
            var child: ICatalogNode;

            for each (child in this._children)
            {
                if (child == node)
                {
                    return true;
                }

            }


            return false;
        }

        public function addChild(node: ICatalogNode): void
        {
            if (node == null)
            {
                return;
            }


            this._children.push(node);

            node.parent = this;
        }

        public function activate(): void
        {
        }

        public function deActivate(): void
        {
        }

        public function open(): void
        {
        }

        public function close(): void
        {
        }

        protected function get iconName(): String
        {
            if (this._icon < 1)
            {
                return "";
            }


            return ICON_PREFIX + this._icon.toString();
        }

    }
}
