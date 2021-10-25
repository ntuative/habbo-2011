package com.sulake.habbo.catalog.navigation
{

    import flash.display.BitmapData;

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.geom.ColorTransform;

    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;
    import flash.net.URLRequest;

    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class CatalogNodeRenderable extends CatalogNode
    {

        private static const var_2664: Number = 4285716709;
        private static var _listSubItemWindowLayout: XML;
        private static var _listItemWindowLayout: XML;
        private static var _listWindowLayout: XML;

        private var var_2665: Number = 0xFFFFFFFF;
        private var _icon: BitmapData;
        private var _window: IWindowContainer;
        private var _unknown1: IWindowContainer;
        private var _list: IItemListWindow;
        private var _isOpen: Boolean = false;

        public function CatalogNodeRenderable(param1: ICatalogNavigator, param2: NodeData, param3: int)
        {
            var _loc4_: XmlAsset;
            super(param1, param2, param3);
            if (_listSubItemWindowLayout == null)
            {
                _loc4_ = (param1.catalog.assets.getAssetByName("navigation_list_subitem") as XmlAsset);
                _listSubItemWindowLayout = (_loc4_.content as XML);
            }


            if (_listItemWindowLayout == null)
            {
                _loc4_ = (param1.catalog.assets.getAssetByName("navigation_list_item") as XmlAsset);
                _listItemWindowLayout = (_loc4_.content as XML);
            }


            if (_listWindowLayout == null)
            {
                _loc4_ = (param1.catalog.assets.getAssetByName("list_item_list") as XmlAsset);
                _listWindowLayout = (_loc4_.content as XML);
            }

        }

        public function set icon(param1: BitmapData): void
        {
            this._icon = param1;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        override public function get icon(): BitmapData
        {
            return this._icon;
        }

        override public function get isOpen(): Boolean
        {
            return this._isOpen;
        }

        override public function dispose(): void
        {
            if (this._isOpen)
            {
                this.close();
                this.deActivate();
            }


            this._icon = null;
            this._window = null;
            this._unknown1 = null;
            this._list = null;
            super.dispose();
        }

        public function addToList(itemList: IItemListWindow): void
        {
            if (this._window == null)
            {
                this.createWindow();
            }


            itemList.addListItem(this._window);

            if (isBranch)
            {
                if (this._list == null)
                {
                    this.createList();
                }


                itemList.addListItem(this._list);
            }

        }

        public function removeFromList(itemList: IItemListWindow): void
        {
            itemList.removeListItem(this._window);

            if (isBranch)
            {
                itemList.removeListItem(this._list);
            }

        }

        override public function activate(): void
        {
            var window: IWindow = this._window.findChildByTag("SELECTION_COLOR");

            if (window != null)
            {
                if (this.var_2665 == 0xFFFFFFFF)
                {
                    this.var_2665 = window.color;
                }


                window.color = var_2664;
            }

        }

        override public function deActivate(): void
        {
            var window: IWindow = this._window.findChildByTag("SELECTION_COLOR");

            if (window != null)
            {
                window.color = this.var_2665;
            }

        }

        override public function open(): void
        {
            var window: IWindow;
            this.showChildren();
            this._isOpen = true;

            if (isBranch)
            {
                window = this._window.findChildByTag("DOWNBTN");

                if (window != null)
                {
                    window.style = HabboIconType.var_654;
                }

            }

        }

        override public function close(): void
        {
            var window: IWindow;
            this.removeChildren();
            this._isOpen = false;

            if (isBranch)
            {
                window = this._window.findChildByTag("DOWNBTN");

                if (window != null)
                {
                    window.style = HabboIconType.var_652;
                }

            }

        }

        private function showChildren(): void
        {
            var node: ICatalogNode;

            if (this._list == null)
            {
                this.createList();
            }


            for each (node in children)
            {
                if (node.isNavigateable)
                {
                    (node as CatalogNodeRenderable).addToList(this._list);
                }

            }

            if (this._list != null)
            {
                this._list.visible = true;
                this._list.height = this._list.numListItems * 21;
            }

        }

        private function removeChildren(): void
        {
            var _loc1_: ICatalogNode;
            for each (_loc1_ in children)
            {
                if (_loc1_.isNavigateable)
                {
                    (_loc1_ as CatalogNodeRenderable).removeFromList(this._list);
                }

            }

            if (this._list != null)
            {
                this._list.height = 0;
                this._list.visible = false;
                this._list.x = 0;
            }

        }

        private function createList(): void
        {
            this._list = (navigator.catalog.windowManager.buildFromXML(_listWindowLayout) as IItemListWindow);

            if (this._list == null)
            {
                throw new Error("Failed to construct list-item-list from XML!");
            }


            this.removeChildren();
        }

        private function createWindow(): void
        {
            if (depth == 1)
            {
                this._window = (navigator.catalog.windowManager.buildFromXML(_listItemWindowLayout) as IWindowContainer);
            }
            else
            {
                this._window = (navigator.catalog.windowManager.buildFromXML(_listSubItemWindowLayout) as IWindowContainer);
            }


            if (this._window == null)
            {
                throw new Error("Failed to construct window from XML!");
            }


            var title: ITextWindow = this._window.findChildByTag("ITEM_TITLE") as ITextWindow;
            var button: IWindow = this._window.findChildByTag("DOWNBTN");

            if (title != null)
            {
                title.caption = localization;
            }


            if (isLeaf)
            {
                if (button != null)
                {
                    button.visible = false;
                }

            }


            this.setElementImage("iconBackgroundBitmap", "icon_bg_img", true, color);
            this.initIcon();

            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);

            if (button != null)
            {
                button.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            }

        }

        private function getLocalizationKey(param1: String, param2: String = ""): String
        {
            var _loc3_: ICoreLocalizationManager = (navigator.catalog as HabboCatalog).localization;
            if (_loc3_ == null)
            {
                return param2;
            }

            return _loc3_.getKey(param1, param2);
        }

        private function onButtonClicked(param1: WindowMouseEvent): void
        {
            navigator.activateNode(this);
        }

        private function initIcon(): void
        {
            var _loc1_: String = "icon";
            var _loc2_: String = iconName;

            if (_loc2_ == "")
            {
                return;
            }

            if (navigator.catalog.assets.hasAsset(_loc2_))
            {
                this.setElementImage(_loc1_, _loc2_);
            }
            else
            {
                this.retrieveIconImage(_loc2_);
            }

        }

        private function setElementImage(param1: String, param2: String, param3: Boolean = true, param4: uint = 0): void
        {
            var _loc6_: BitmapDataAsset;
            var _loc7_: BitmapData;
            var _loc8_: int;
            var _loc9_: int;
            var _loc10_: int;
            var _loc11_: int;
            var _loc12_: int;
            var _loc13_: Number;
            var _loc14_: Number;
            var _loc15_: Number;
            var _loc16_: ColorTransform;
            if (this._window == null)
            {
                return;
            }

            var _loc5_: IBitmapWrapperWindow = this._window.findChildByName(param1) as IBitmapWrapperWindow;
            if (_loc5_ != null)
            {
                _loc6_ = (navigator.catalog.assets.getAssetByName(param2) as BitmapDataAsset);
                if (_loc6_ == null)
                {
                    return;
                }

                _loc7_ = (_loc6_.content as BitmapData);
                _loc5_.bitmap = new BitmapData(_loc5_.width, _loc5_.height, true, 0);
                _loc8_ = 0;
                _loc9_ = 0;
                if (param3)
                {
                    _loc8_ = int((_loc5_.width - _loc7_.width) / 2);
                    _loc9_ = int((_loc5_.height - _loc7_.height) / 2);
                }

                if (param4 > 0)
                {
                    _loc7_ = _loc7_.clone();
                    _loc10_ = param4 >> 16 & 0xFF;
                    _loc11_ = param4 >> 8 & 0xFF;
                    _loc12_ = param4 >> 0 & 0xFF;
                    _loc13_ = _loc10_ / 0xFF;
                    _loc14_ = _loc11_ / 0xFF;
                    _loc15_ = _loc12_ / 0xFF;
                    _loc16_ = new ColorTransform(_loc13_, _loc14_, _loc15_);
                    _loc7_.colorTransform(_loc7_.rect, _loc16_);
                }

                _loc5_.bitmap.copyPixels(_loc7_, _loc7_.rect, new Point(_loc8_, _loc9_));
            }
            else
            {
                Logger.log("[CatalogNodeRenderable] Could not find element: " + param1);
            }

        }

        private function retrieveIconImage(param1: String): void
        {
            if (param1 == "")
            {
                return;
            }

            var _loc2_: String = navigator.catalog.configuration.getKey("image.library.catalogue.url");
            var _loc3_: * = _loc2_ + param1 + ".png";
            var _loc4_: URLRequest = new URLRequest(_loc3_);
            var _loc5_: AssetLoaderStruct = navigator.catalog.assets.loadAssetFromFile(param1, _loc4_, "image/gif");
            _loc5_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onIconImageReady);
        }

        private function onIconImageReady(param1: AssetLoaderEvent): void
        {
            var _loc3_: String;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.assetName;
                this.setElementImage("icon", _loc3_);
            }

        }

    }
}
