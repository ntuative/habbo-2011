package com.sulake.habbo.toolbar
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;

    import flash.events.IEventDispatcher;

    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.communication.connection.IConnection;

    import flash.display.BitmapData;

    public class ToolbarIconGroup
    {

        private var var_2079: Array = [];
        private var var_2080: Array = [];
        private var var_2081: Array = [];
        private var var_2082: Array = [];
        private var _windowManager: IHabboWindowManager;
        private var _assetLibrary: IAssetLibrary;
        private var var_2083: IWindowContainer;
        private var _events: IEventDispatcher;
        private var _animator: ToolbarBarMenuAnimator;
        private var _config: IHabboConfigurationManager;
        private var var_2084: Number;
        private var var_2085: String;
        private var var_2086: Number;
        private var var_2087: Number;
        private var var_2088: int = 5;
        private var var_2089: int;
        private var var_2090: Number;
        private var var_2091: XML;
        private var _connection: IConnection;

        public function ToolbarIconGroup(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IConnection, param4: int, param5: IEventDispatcher, param6: IWindowContainer, param7: ToolbarBarMenuAnimator, param8: Number, param9: IHabboConfigurationManager)
        {
            this._windowManager = param1;
            this._assetLibrary = param2;
            this._connection = param3;
            this.var_2083 = param6;
            this._events = param5;
            this._animator = param7;
            this.var_2090 = param8;
            this._config = param9;
        }

        public function dispose(): void
        {
            var _loc1_: ToolbarIcon;
            while (this.var_2079.length > 0)
            {
                this.var_2080.shift();
                _loc1_ = this.var_2079.shift();
                _loc1_.dispose();
                _loc1_ = null;
            }

            this._windowManager = null;
            this._assetLibrary = null;
            this._connection = null;
            this.var_2083 = null;
            this._events = null;
            this._animator = null;
            this._config = null;
        }

        public function acceptsIcon(param1: String): Boolean
        {
            return this.var_2082.indexOf(param1) > -1;
        }

        public function addContentIndexFromXmlList(param1: XML): Boolean
        {
            var _loc2_: String;
            var _loc3_: String;
            var _loc4_: XMLList;
            var _loc5_: XMLList;
            var _loc6_: ToolbarIcon;
            var _loc8_: XML;
            var _loc9_: int;
            if (param1 == null)
            {
                return false;
            }

            this.var_2091 = param1;
            _loc4_ = param1.elements("icon");
            var _loc7_: int;
            while (_loc7_ < _loc4_.length())
            {
                _loc8_ = _loc4_[_loc7_];
                _loc2_ = HabboToolbarIconEnum[_loc8_.@id];
                if (_loc2_ != null)
                {
                    if (!this.containsIcon(_loc2_))
                    {
                        _loc6_ = this.createIconObject(_loc2_);
                        if (_loc6_ == null)
                        {
                            return false;
                        }

                        _loc6_.defineFromXML(_loc8_);
                        this.var_2081.push(_loc2_);
                        _loc5_ = _loc8_.elements("dock");
                        if (_loc5_.length() > 0)
                        {
                            _loc9_ = 0;
                            while (_loc9_ < _loc5_.length())
                            {
                                _loc3_ = HabboToolbarIconEnum[_loc5_[_loc9_].@id];
                                this.var_2082.push(_loc3_);
                                _loc6_.dockMenu(_loc3_, this.getMenuYieldList(_loc3_), _loc5_[_loc9_].@locktoicon == "true");
                                _loc9_++;
                            }

                        }
                        else
                        {
                            this.var_2082.push(_loc2_);
                            if (_loc8_.elements("nodock").length() == 0)
                            {
                                _loc6_.dockMenu(_loc2_);
                            }

                        }

                    }

                }

                _loc7_++;
            }

            return true;
        }

        public function getMenuYieldList(param1: String): Array
        {
            var _loc4_: XMLList;
            var _loc7_: int;
            var _loc8_: String;
            var _loc2_: Array = [];
            var _loc3_: XMLList = this.var_2091.elements("menu");
            var _loc5_: * = this._config.getKey("roominfo.widget.enabled") == "1";
            var _loc6_: int;
            while (_loc6_ < _loc3_.length())
            {
                if (HabboToolbarIconEnum[_loc3_[_loc6_].@id] == param1)
                {
                    _loc4_ = _loc3_[_loc6_].elements("yield");
                    _loc7_ = 0;
                    while (_loc7_ < _loc4_.length())
                    {
                        _loc8_ = HabboToolbarIconEnum[_loc4_[_loc7_].@id];
                        if (!_loc5_ || _loc8_ != HabboToolbarIconEnum.ROOMINFO)
                        {
                            _loc2_.push(_loc8_);
                        }

                        _loc7_++;
                    }

                }

                _loc6_++;
            }

            return _loc2_;
        }

        public function setIcon(param1: String, param2: Boolean): void
        {
            var _loc3_: ToolbarIcon;
            _loc3_ = this.getIconById(param1);
            if (_loc3_ != null)
            {
                _loc3_.setIcon(param2);
                this.alignItems();
            }

        }

        public function setContent(param1: String, param2: BitmapData): void
        {
            var _loc3_: ToolbarIcon;
            _loc3_ = this.getIconById(param1);
            if (_loc3_ != null)
            {
                _loc3_.setIconBitmapData(param2);
                this.alignItems();
            }

        }

        public function removeContent(param1: String): void
        {
            var _loc3_: ToolbarIcon;
            var _loc2_: int = this.var_2080.indexOf(param1);
            if (_loc2_ > -1)
            {
                _loc3_ = this.getIconById(param1);
                if (_loc3_ != null)
                {
                    _loc3_.setIcon(false);
                }

            }

        }

        public function containsIcon(param1: String): Boolean
        {
            return this.var_2080.indexOf(param1) > -1;
        }

        public function get size(): Number
        {
            var _loc1_: Number = 0;
            var _loc2_: int;
            while (_loc2_ < this.var_2079.length)
            {
                if (this.var_2079[_loc2_].exists)
                {
                    _loc1_ = _loc1_ + this.var_2087;
                }

                _loc2_++;
            }

            return _loc1_;
        }

        public function get iconCount(): int
        {
            var _loc1_: Number = 0;
            var _loc2_: int;
            while (_loc2_ < this.var_2079.length)
            {
                if (this.var_2079[_loc2_].exists)
                {
                    _loc1_++;
                }

                _loc2_++;
            }

            return _loc1_;
        }

        public function set defaultIconSize(param1: Number): void
        {
            this.var_2086 = param1;
        }

        public function get defaultIconSize(): Number
        {
            return this.var_2086;
        }

        public function set iconSize(param1: Number): void
        {
            this.var_2087 = param1;
        }

        public function get iconSize(): Number
        {
            return this.var_2087;
        }

        public function get toolbarUsableWidth(): Number
        {
            return this.var_2090;
        }

        public function set windowMargin(param1: int): void
        {
            this.var_2088 = param1;
        }

        public function get windowMargin(): int
        {
            return this.var_2088;
        }

        public function set windowBottomMargin(param1: int): void
        {
            this.var_2089 = param1;
        }

        public function get windowBottomMargin(): int
        {
            return this.var_2089;
        }

        public function set position(param1: Number): void
        {
            this.var_2084 = param1;
            this.alignItems();
        }

        public function set orientation(param1: String): void
        {
            this.var_2085 = param1;
        }

        public function get orientation(): String
        {
            return this.var_2085;
        }

        private function alignItems(): void
        {
            var _loc1_: ToolbarIcon;
            var _loc2_: int;
            var _loc3_: Number = 0;
            var _loc4_: int;
            while (_loc4_ < this.var_2081.length)
            {
                _loc2_ = this.var_2080.indexOf(this.var_2081[_loc4_]);
                if (_loc2_ > -1)
                {
                    _loc1_ = this.var_2079[_loc2_];
                    if (_loc1_.exists)
                    {
                        _loc1_.changePosition(this.var_2084 + _loc3_);
                        _loc3_ = _loc3_ + this.var_2087;
                    }

                }

                _loc4_++;
            }

        }

        public function getIconById(param1: String): ToolbarIcon
        {
            if (!this.containsIcon(param1))
            {
                return null;
            }

            return this.var_2079[this.var_2080.indexOf(param1)];
        }

        public function getIconByMenuId(param1: String): ToolbarIcon
        {
            var _loc2_: ToolbarIcon;
            var _loc3_: int;
            while (_loc3_ < this.var_2079.length)
            {
                _loc2_ = this.var_2079[_loc3_];
                if (_loc2_ != null)
                {
                    if (_loc2_.docksMenu(param1))
                    {
                        return _loc2_;
                    }

                }

                _loc3_++;
            }

            return null;
        }

        private function createIconObject(param1: String): ToolbarIcon
        {
            var _loc2_: ToolbarIcon;
            _loc2_ = this.getIconById(param1);
            if (_loc2_ != null)
            {
                return _loc2_;
            }

            _loc2_ = new ToolbarIcon(this, this._windowManager, this._assetLibrary, this._connection, param1, this._events, this._animator);
            this.var_2083.addChild(_loc2_.window);
            this.var_2080.push(param1);
            this.var_2079.push(_loc2_);
            return _loc2_;
        }

    }
}
