package com.sulake.core.window.components
{

    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IInputProcessorRoot;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowStyle;

    import flash.geom.Rectangle;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot
    {

        protected var _container: IWindowContainer;
        protected var var_2017: Boolean = false;
        protected var var_2018: Boolean = false;
        protected var _horizontal: Boolean = false;
        protected var var_2008: Number = -1;
        protected var var_2009: Number = -1;
        protected var var_2019: int = 0;
        protected var var_2020: int = 0;
        protected var var_2021: Number;
        protected var var_2022: Number;
        protected var var_2023: Boolean = false;

        protected var _spacing: int = PropertyDefaults.var_1732;
        protected var _autoArrangeItems: Boolean = PropertyDefaults.var_1733;
        protected var _scaleToFitItems: Boolean = PropertyDefaults.var_1734;
        protected var _resizeOnItemUpdate: Boolean = PropertyDefaults.var_1735;
        protected var _scrollH: Number = 0;
        protected var _scrollV: Number = 0;
        protected var var_2014: Number = 0;
        protected var var_2015: Number = 0;

        public function ItemListController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function = null, param9: Array = null, param10: Array = null, param11: uint = 0)
        {
            this._horizontal = param2 == WindowType.var_850;
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var_1986 = _background || !testParamFlag(WindowParam.var_693);
            this._container = (_context.create("_CONTAINER", "", WindowType.var_868, WindowStyle.var_1114, WindowParam.var_693 | WindowParam.var_699 | WindowParam.var_694, new Rectangle(0, 0, width, height), null, this, 0, null, [
                TAG_INTERNAL,
                TAG_EXCLUDE
            ]) as IWindowContainer);
            this._container.addEventListener(WindowEvent.var_573, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_581, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_583, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_582, this.containerEventHandler);
            this._container.clipping = clipping;
            this.resizeOnItemUpdate = this._resizeOnItemUpdate;
        }

        public function get spacing(): int
        {
            return this._spacing;
        }

        public function set spacing(param1: int): void
        {
            if (param1 != this._spacing)
            {
                this._spacing = param1;
                this.updateScrollAreaRegion();
            }

        }

        public function get scrollH(): Number
        {
            return this._scrollH;
        }

        public function get scrollV(): Number
        {
            return this._scrollV;
        }

        public function get maxScrollH(): int
        {
            return Math.max(0, this.var_2014 - width);
        }

        public function get maxScrollV(): int
        {
            return Math.max(0, this.var_2015 - height);
        }

        public function get visibleRegion(): Rectangle
        {
            return new Rectangle(this._scrollH * this.maxScrollH, this._scrollV * this.maxScrollV, width, height);
        }

        public function get scrollableRegion(): Rectangle
        {
            return this._container.rectangle.clone();
        }

        public function set scrollH(param1: Number): void
        {
            var _loc2_: WindowEvent;
            if (param1 < 0)
            {
                param1 = 0;
            }

            if (param1 > 1)
            {
                param1 = 1;
            }

            if (param1 != this._scrollH)
            {
                this._scrollH = param1;
                this._container.x = -this._scrollH * this.maxScrollH;
                _context.invalidate(this._container, this.visibleRegion, WindowRedrawFlag.var_1020);
                _loc2_ = WindowEvent.allocate(WindowEvent.var_591, this, null);
                _events.dispatchEvent(_loc2_);
                _loc2_.recycle();
            }

        }

        public function set scrollV(param1: Number): void
        {
            var _loc2_: WindowEvent;
            if (param1 < 0)
            {
                param1 = 0;
            }

            if (param1 > 1)
            {
                param1 = 1;
            }

            if (param1 != this._scrollV)
            {
                this._scrollV = param1;
                this._container.y = -this._scrollV * this.maxScrollV;
                _context.invalidate(this._container, this.visibleRegion, WindowRedrawFlag.var_1020);
                _loc2_ = WindowEvent.allocate(WindowEvent.var_591, this, null);
                _events.dispatchEvent(_loc2_);
                _loc2_.recycle();
            }

        }

        public function get scrollStepH(): Number
        {
            if (this.var_2008 >= 0)
            {
                return this.var_2008;
            }

            return this._horizontal ? this._container.width / this.numListItems : 0.1 * this._container.width;
        }

        public function get scrollStepV(): Number
        {
            if (this.var_2009 >= 0)
            {
                return this.var_2009;
            }

            return this._horizontal ? 0.1 * this._container.height : this._container.height / this.numListItems;
        }

        public function set scrollStepH(param1: Number): void
        {
            this.var_2008 = param1;
        }

        public function set scrollStepV(param1: Number): void
        {
            this.var_2009 = param1;
        }

        public function set scaleToFitItems(value: Boolean): void
        {
            if (this._scaleToFitItems != value)
            {
                this._scaleToFitItems = value;
                this.updateScrollAreaRegion();
            }

        }

        public function get scaleToFitItems(): Boolean
        {
            return this._scaleToFitItems;
        }

        public function set autoArrangeItems(value: Boolean): void
        {
            this._autoArrangeItems = value;
            this.updateScrollAreaRegion();
        }

        public function get autoArrangeItems(): Boolean
        {
            return this._autoArrangeItems;
        }

        public function set resizeOnItemUpdate(param1: Boolean): void
        {
            this._resizeOnItemUpdate = param1;
            if (this._container)
            {
                if (this._horizontal)
                {
                    this._container.setParamFlag(WindowParam.var_688, param1);
                }
                else
                {
                    this._container.setParamFlag(WindowParam.var_689, param1);
                }

            }

        }

        public function get resizeOnItemUpdate(): Boolean
        {
            return this._resizeOnItemUpdate;
        }

        public function get iterator(): IIterator
        {
            return new Iterator(this);
        }

        public function get firstListItem(): IWindow
        {
            return this.numListItems > 0 ? this.getListItemAt(0) : null;
        }

        public function get lastListItem(): IWindow
        {
            return this.numListItems > 0 ? this.getListItemAt(this.numListItems - 1) : null;
        }

        override public function set clipping(value: Boolean): void
        {
            super.clipping = value;

            if (this._container)
            {
                this._container.clipping = value;
            }

        }

        override public function dispose(): void
        {
            if (!_disposed)
            {
                if (this.var_2023)
                {
                    try
                    {
                        _context.getWindowServices().getGestureAgentService().end(this);
                    }
                    catch (e: Error)
                    {
                    }

                }

                this._container.removeEventListener(WindowEvent.var_573, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_581, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_583, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_582, this.containerEventHandler);
                super.dispose();
            }

        }

        override protected function cloneChildWindows(param1: WindowController): void
        {
            var _loc2_: int;
            while (_loc2_ < this.numListItems)
            {
                IItemListWindow(param1).addListItem(this.getListItemAt(_loc2_).clone());
                _loc2_++;
            }

        }

        public function get numListItems(): int
        {
            return this._container != null ? this._container.numChildren : 0;
        }

        public function addListItem(param1: IWindow): IWindow
        {
            this.var_2018 = true;
            if (this._horizontal)
            {
                param1.x = this.var_2014 + (this.numListItems > 0 ? this._spacing : 0);
                this.var_2014 = param1.rectangle.right;
                this._container.width = this.var_2014;
            }
            else
            {
                if (this.autoArrangeItems)
                {
                    param1.y = this.var_2015 + (this.numListItems > 0 ? this._spacing : 0);
                    this.var_2015 = param1.rectangle.bottom;
                }
                else
                {
                    this.var_2015 = Math.max(this.var_2015, param1.rectangle.bottom);
                }

                this._container.height = this.var_2015;
            }

            param1 = this._container.addChild(param1);
            this.var_2018 = false;
            return param1;
        }

        public function addListItemAt(param1: IWindow, param2: uint): IWindow
        {
            param1 = this._container.addChildAt(param1, param2);
            this.updateScrollAreaRegion();
            return param1;
        }

        public function getListItemAt(param1: uint): IWindow
        {
            return this._container.getChildAt(param1);
        }

        public function getListItemByID(param1: uint): IWindow
        {
            return this._container.getChildByID(param1);
        }

        public function getListItemByName(param1: String): IWindow
        {
            return this._container.getChildByName(param1);
        }

        public function getListItemIndex(param1: IWindow): int
        {
            return this._container.getChildIndex(param1);
        }

        public function removeListItem(param1: IWindow): IWindow
        {
            param1 = this._container.removeChild(param1);
            if (param1)
            {
                this.updateScrollAreaRegion();
            }

            return param1;
        }

        public function removeListItemAt(param1: int): IWindow
        {
            return this._container.removeChildAt(param1);
        }

        public function setListItemIndex(param1: IWindow, param2: int): void
        {
            this._container.setChildIndex(param1, param2);
        }

        public function swapListItems(param1: IWindow, param2: IWindow): void
        {
            this._container.swapChildren(param1, param2);
            this.updateScrollAreaRegion();
        }

        public function swapListItemsAt(param1: int, param2: int): void
        {
            this._container.swapChildrenAt(param1, param2);
            this.updateScrollAreaRegion();
        }

        public function groupListItemsWithID(param1: uint, param2: Array, param3: Boolean = false): uint
        {
            return this._container.groupChildrenWithID(param1, param2, param3);
        }

        public function groupListItemsWithTag(param1: String, param2: Array, param3: Boolean = false): uint
        {
            return this._container.groupChildrenWithTag(param1, param2, param3);
        }

        public function removeListItems(): void
        {
            this.var_2018 = true;
            while (this.numListItems > 0)
            {
                this._container.removeChildAt(0);
            }

            this.var_2018 = false;
            this.updateScrollAreaRegion();
        }

        public function destroyListItems(): void
        {
            this.var_2018 = true;
            while (this.numListItems > 0)
            {
                this._container.removeChildAt(0).destroy();
            }

            this.var_2018 = false;
            this.updateScrollAreaRegion();
        }

        public function arrangeListItems(): void
        {
            this.updateScrollAreaRegion();
        }

        override public function populate(param1: Array): void
        {
            WindowController(this._container).populate(param1);
            this.updateScrollAreaRegion();
        }

        override public function update(param1: WindowController, param2: WindowEvent): Boolean
        {
            var _loc3_: Boolean = super.update(param1, param2);
            switch (param2.type)
            {
                case WindowEvent.var_572:
                    this.var_2017 = true;
                    break;
                case WindowEvent.var_573:
                    if (!this._scaleToFitItems)
                    {
                        if (this._horizontal)
                        {
                            this._container.height = _current.height;
                        }
                        else
                        {
                            this._container.width = _current.width;
                        }

                    }

                    this.updateScrollAreaRegion();
                    this.var_2017 = false;
                    break;
                default:
                    if (param2 is WindowEvent)
                    {
                        _loc3_ = this.process(param2 as WindowEvent);
                    }

            }

            return _loc3_;
        }

        public function process(param1: WindowEvent): Boolean
        {
            var _loc2_: Boolean;
            var _loc3_: int;
            var _loc4_: int;
            var _loc5_: int;
            if (param1 is WindowMouseEvent)
            {
                _loc3_ = WindowMouseEvent(param1).localX;
                _loc4_ = WindowMouseEvent(param1).localY;
                _loc5_ = WindowMouseEvent(param1).delta;
            }

            switch (param1.type)
            {
                case WindowMouseEvent.var_635:
                    if (this._horizontal)
                    {
                        this.scrollH = this.scrollH - _loc5_ * 0.01;
                    }
                    else
                    {
                        this.scrollV = this.scrollV - _loc5_ * 0.01;
                    }

                    _loc2_ = true;
                    break;
                case WindowMouseEvent.var_628:
                    this.var_2019 = _loc3_;
                    this.var_2020 = _loc4_;
                    this.var_2021 = 0;
                    this.var_2022 = 0;
                    this.var_2023 = true;
                    _loc2_ = true;
                    break;
                case WindowMouseEvent.var_632:
                    if (this.var_2023)
                    {
                        this.var_2021 = this.var_2019 - _loc3_;
                        this.var_2022 = this.var_2020 - _loc4_;
                        if (this._horizontal)
                        {
                            if (this.var_2021 != 0 && this.var_2014 != 0)
                            {
                                this.scrollH = this.scrollH + this.var_2021 / this.var_2014;
                            }

                        }
                        else
                        {
                            if (this.var_2022 != 0 && this.var_2015 != 0)
                            {
                                this.scrollV = this.scrollV + this.var_2022 / this.var_2015;
                            }

                        }

                        this.var_2019 = _loc3_;
                        this.var_2020 = _loc4_;
                        _loc2_ = true;
                    }

                    break;
                case WindowMouseEvent.var_633:
                case WindowMouseEvent.var_634:
                    if (this.var_2023)
                    {
                        if (this._horizontal)
                        {
                            _context.getWindowServices().getGestureAgentService()
                                    .begin(this, this.scrollAnimationCallback, 0, -this.var_2021, 0);
                        }
                        else
                        {
                            _context.getWindowServices().getGestureAgentService()
                                    .begin(this, this.scrollAnimationCallback, 0, 0, -this.var_2022);
                        }

                        this.var_2023 = false;
                        _loc2_ = true;
                    }

                    break;
            }

            return _loc2_;
        }

        private function scrollAnimationCallback(param1: int, param2: int): void
        {
            if (!disposed)
            {
                this.scrollH = this.scrollH - param1 / this.var_2014;
                this.scrollV = this.scrollV - param2 / this.var_2015;
            }

        }

        private function containerEventHandler(param1: WindowEvent): void
        {
            var _loc2_: WindowEvent;
            switch (param1.type)
            {
                case WindowEvent.var_581:
                    this.updateScrollAreaRegion();
                    return;
                case WindowEvent.var_583:
                    if (!this.var_2017)
                    {
                        this.updateScrollAreaRegion();
                    }

                    return;
                case WindowEvent.var_582:
                    this.updateScrollAreaRegion();
                    return;
                case WindowEvent.var_573:
                    _loc2_ = WindowEvent.allocate(WindowEvent.var_573, this, null);
                    _events.dispatchEvent(_loc2_);
                    _loc2_.recycle();
                    return;
                default:
                    Logger.log("ItemListController::containerEventHandler(" + param1.type + ")");
            }

        }

        protected function updateScrollAreaRegion(): void
        {
            var _loc1_: uint;
            var _loc2_: IWindow;
            var _loc3_: int;
            var _loc4_: uint;
            if (this._autoArrangeItems && !this.var_2018 && this._container)
            {
                this.var_2018 = true;
                _loc1_ = this._container.numChildren;
                if (this._horizontal)
                {
                    this.var_2014 = 0;
                    this.var_2015 = _current.height;
                    _loc4_ = 0;
                    while (_loc4_ < _loc1_)
                    {
                        _loc2_ = this._container.getChildAt(_loc4_);
                        if (_loc2_.visible)
                        {
                            _loc2_.x = this.var_2014;
                            this.var_2014 = this.var_2014 + (_loc2_.width + this._spacing);
                            if (this._scaleToFitItems)
                            {
                                _loc3_ = _loc2_.height + _loc2_.y;
                                this.var_2015 = _loc3_ > this.var_2015 ? _loc3_ : this.var_2015;
                            }

                        }

                        _loc4_++;
                    }

                    if (_loc1_ > 0)
                    {
                        this.var_2014 = this.var_2014 - this._spacing;
                    }

                }
                else
                {
                    this.var_2014 = _current.width;
                    this.var_2015 = 0;
                    _loc4_ = 0;
                    while (_loc4_ < _loc1_)
                    {
                        _loc2_ = this._container.getChildAt(_loc4_);
                        if (_loc2_.visible)
                        {
                            _loc2_.y = this.var_2015;
                            this.var_2015 = this.var_2015 + (_loc2_.height + this._spacing);
                            if (this._scaleToFitItems)
                            {
                                _loc3_ = _loc2_.width + _loc2_.x;
                                this.var_2014 = _loc3_ > this.var_2014 ? _loc3_ : this.var_2014;
                            }

                        }

                        _loc4_++;
                    }

                    if (_loc1_ > 0)
                    {
                        this.var_2015 = this.var_2015 - this._spacing;
                    }

                }

                if (this._scrollH > 0)
                {
                    if (this.var_2014 <= _current.width)
                    {
                        this.scrollH = 0;
                    }
                    else
                    {
                        this._container.x = -(this._scrollH * this.maxScrollH);
                    }

                }

                if (this._scrollV > 0)
                {
                    if (this.var_2015 <= _current.height)
                    {
                        this.scrollV = 0;
                    }
                    else
                    {
                        this._container.y = -(this._scrollV * this.maxScrollV);
                    }

                }

                this._container.height = this.var_2015;
                this._container.width = this.var_2014;
                this.var_2018 = false;
            }

        }

        override public function get properties(): Array
        {
            var _loc1_: Array = super.properties;
            if (this._spacing != PropertyDefaults.var_1732)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1736, this._spacing, PropertyStruct.var_607, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1737);
            }

            if (this._autoArrangeItems != PropertyDefaults.var_1733)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1738, this._autoArrangeItems, PropertyStruct.var_611, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1739);
            }

            if (this._scaleToFitItems != PropertyDefaults.var_1734)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1740, this._scaleToFitItems, PropertyStruct.var_611, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1741);
            }

            if (this._resizeOnItemUpdate != PropertyDefaults.var_1735)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1742, this._resizeOnItemUpdate, PropertyStruct.var_611, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1743);
            }

            if (this.var_2008 != PropertyDefaults.var_1744)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1745, this.var_2008, PropertyStruct.var_609, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1746);
            }

            if (this.var_2009 != PropertyDefaults.var_1747)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1748, this.var_2009, PropertyStruct.var_609, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1749);
            }

            return _loc1_;
        }

        override public function set properties(param1: Array): void
        {
            var _loc2_: PropertyStruct;
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_1736:
                        this.spacing = (_loc2_.value as int);
                        break;
                    case PropertyDefaults.var_1740:
                        this.scaleToFitItems = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_1742:
                        this.resizeOnItemUpdate = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_1738:
                        this._autoArrangeItems = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_1745:
                        this.var_2008 = (_loc2_.value as Number);
                        break;
                    case PropertyDefaults.var_1748:
                        this.var_2009 = (_loc2_.value as Number);
                        break;
                }

            }

            super.properties = param1;
        }

    }
}
