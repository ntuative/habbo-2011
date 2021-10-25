package com.sulake.core.window.components
{

    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.WindowContext;

    import flash.geom.Rectangle;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.IWindowContainer;

    public class ScrollbarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow
    {

        private static const var_2030: String = "increment";
        private static const var_2031: String = "decrement";
        private static const var_2032: String = "slider_track";
        private static const var_2033: String = "slider_bar";

        protected var _offset: Number = 0;
        protected var var_2036: Number = 0.1;
        protected var _scrollable: IScrollableWindow;
        private var _horizontal: Boolean;
        private var var_2035: String;
        private var var_2037: Boolean = false;

        public function ScrollbarController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function, param9: Array = null, param10: Array = null, param11: uint = 0, param12: IScrollableWindow = null)
        {
            var _loc14_: IWindow;
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var_1986 = false;
            this._scrollable = param12;
            this._horizontal = param2 == WindowType.var_856;
            var _loc13_: Array = [];
            groupChildrenWithTag(WindowController.TAG_INTERNAL, _loc13_, true);
            for each (_loc14_ in _loc13_)
            {
                _loc14_.procedure = this.scrollButtonEventProc;
            }

            this.updateLiftSizeAndPosition();
        }

        public function get scrollH(): Number
        {
            return this._horizontal ? this._offset : 0;
        }

        public function get scrollV(): Number
        {
            return this._horizontal ? 0 : this._offset;
        }

        public function get scrollable(): IScrollableWindow
        {
            return this._scrollable;
        }

        public function set scrollH(param1: Number): void
        {
            if (this._horizontal)
            {
                if (this.setScrollPosition(param1))
                {
                    this.updateLiftSizeAndPosition();
                }

            }

        }

        public function set scrollV(param1: Number): void
        {
            if (!this._horizontal)
            {
                if (this.setScrollPosition(param1))
                {
                    this.updateLiftSizeAndPosition();
                }

            }

        }

        public function set scrollable(param1: IScrollableWindow): void
        {
            if (this._scrollable != null && !this._scrollable.disposed)
            {
                this._scrollable.removeEventListener(WindowEvent.var_573, this.onScrollableResized);
                this._scrollable.removeEventListener(WindowEvent.var_591, this.onScrollableScrolled);
            }

            this._scrollable = param1;
            if (this._scrollable != null && !this._scrollable.disposed)
            {
                this._scrollable.addEventListener(WindowEvent.var_573, this.onScrollableResized);
                this._scrollable.addEventListener(WindowEvent.var_591, this.onScrollableScrolled);
                this.updateLiftSizeAndPosition();
            }

        }

        public function get horizontal(): Boolean
        {
            return this._horizontal;
        }

        public function get vertical(): Boolean
        {
            return !this._horizontal;
        }

        override public function get properties(): Array
        {
            var _loc1_: Array = super.properties;
            var _loc2_: String = "";
            if (this._scrollable is IWindow)
            {
                _loc2_ = IWindow(this._scrollable).name;
            }
            else
            {
                if (this.var_2035 != null)
                {
                    _loc2_ = this.var_2035;
                }

            }

            _loc1_.push(new PropertyStruct("scrollable", _loc2_, "String", _loc2_ != ""));
            return _loc1_;
        }

        override public function set properties(param1: Array): void
        {
            var _loc3_: PropertyStruct;
            var _loc2_: int = param1.length;
            var _loc4_: int;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = (param1[_loc4_] as PropertyStruct);
                if (_loc3_.key == "scrollable")
                {
                    this.var_2035 = (_loc3_.value as String);
                }

                _loc4_++;
            }

            super.properties = param1;
        }

        protected function get track(): WindowController
        {
            return findChildByName(var_2032) as WindowController;
        }

        protected function get lift(): WindowController
        {
            return this.track.findChildByName(var_2033) as WindowController;
        }

        override public function dispose(): void
        {
            this.scrollable = null;
            super.dispose();
        }

        override public function enable(): Boolean
        {
            var _loc1_: Array;
            var _loc2_: uint;
            if (super.enable())
            {
                _loc1_ = [];
                groupChildrenWithTag(WindowController.TAG_INTERNAL, _loc1_, true);
                _loc2_ = 0;
                while (_loc2_ < _loc1_.length)
                {
                    IWindow(_loc1_[_loc2_]).enable();
                    _loc2_++;
                }

                return true;
            }

            return false;
        }

        override public function disable(): Boolean
        {
            var _loc1_: Array;
            var _loc2_: uint;
            if (super.disable())
            {
                _loc1_ = [];
                groupChildrenWithTag(WindowController.TAG_INTERNAL, _loc1_, true);
                _loc2_ = 0;
                while (_loc2_ < _loc1_.length)
                {
                    IWindow(_loc1_[_loc2_]).disable();
                    _loc2_++;
                }

                return true;
            }

            return false;
        }

        protected function setScrollPosition(param1: Number): Boolean
        {
            var _loc2_: Boolean;
            if (this._scrollable == null || this._scrollable.disposed)
            {
                if (!this.resolveScrollTarget())
                {
                    return false;
                }

            }

            if (param1 < 0)
            {
                param1 = 0;
            }

            if (param1 > 1)
            {
                param1 = 1;
            }

            this._offset = param1;
            if (this._horizontal)
            {
                _loc2_ = this._scrollable.scrollH != this._offset;
                if (_loc2_)
                {
                    this._scrollable.scrollH = this._offset;
                }

            }
            else
            {
                _loc2_ = this._scrollable.scrollV != this._offset;
                if (_loc2_)
                {
                    this._scrollable.scrollV = this._offset;
                }

            }

            return _loc2_;
        }

        override public function update(param1: WindowController, param2: WindowEvent): Boolean
        {
            switch (param1.name)
            {
                case ScrollbarController.var_2033:
                    if (param2.type == WindowEvent.var_582)
                    {
                        if (!this.var_2037)
                        {
                            if (this._horizontal)
                            {
                                this.setScrollPosition(ScrollbarLiftController(param1).offsetX);
                            }
                            else
                            {
                                this.setScrollPosition(ScrollbarLiftController(param1).offsetY);
                            }

                        }

                    }

                    break;
            }

            var _loc3_: Boolean = super.update(param1, param2);
            if (param2.type == WindowEvent.var_585)
            {
                if (this._scrollable == null)
                {
                    this.resolveScrollTarget();
                }

            }

            if (param1 == this)
            {
                if (param2.type == WindowEvent.var_573)
                {
                    this.updateLiftSizeAndPosition();
                }
                else
                {
                    if (param2.type == WindowMouseEvent.var_635)
                    {
                        if (WindowMouseEvent(param2).delta > 0)
                        {
                            if (this._horizontal)
                            {
                                this.scrollH = this.scrollH - this.var_2036;
                            }
                            else
                            {
                                this.scrollV = this.scrollV - this.var_2036;
                            }

                        }
                        else
                        {
                            if (this._horizontal)
                            {
                                this.scrollH = this.scrollH + this.var_2036;
                            }
                            else
                            {
                                this.scrollV = this.scrollV + this.var_2036;
                            }

                        }

                        _loc3_ = true;
                    }

                }

            }

            return _loc3_;
        }

        private function updateLiftSizeAndPosition(): void
        {
            var _loc1_: Number;
            var _loc4_: int;
            if (this._scrollable == null || this._scrollable.disposed)
            {
                if (_disposed || !this.resolveScrollTarget())
                {
                    return;
                }

            }

            var _loc2_: WindowController = this.track;
            var _loc3_: WindowController = this.lift;
            if (_loc3_ != null)
            {
                if (this._horizontal)
                {
                    _loc1_ = this._scrollable.visibleRegion.width / this._scrollable.scrollableRegion.width;
                    if (_loc1_ > 1)
                    {
                        _loc1_ = 1;
                    }

                    _loc4_ = _loc1_ * _loc2_.width;
                    _loc3_.width = _loc4_;
                    _loc3_.x = this._scrollable.scrollH * (_loc2_.width - _loc4_);
                }
                else
                {
                    _loc1_ = this._scrollable.visibleRegion.height / this._scrollable.scrollableRegion.height;
                    if (_loc1_ > 1)
                    {
                        _loc1_ = 1;
                    }

                    _loc4_ = _loc1_ * _loc2_.height;
                    _loc3_.height = _loc4_;
                    _loc3_.y = this._scrollable.scrollV * (_loc2_.height - _loc3_.height);
                }

            }

            if (_loc1_ == 1)
            {
                this.disable();
            }
            else
            {
                this.enable();
            }

        }

        private function nullEventProc(param1: WindowEvent, param2: IWindow): void
        {
        }

        private function scrollButtonEventProc(param1: WindowEvent, param2: IWindow): void
        {
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: Rectangle;
            var _loc3_: Boolean;
            if (param1.type == WindowMouseEvent.var_628 || param1.type == WindowTouchEvent.var_1722)
            {
                if (param2.name == var_2030)
                {
                    if (this._scrollable)
                    {
                        this.var_2037 = true;
                        if (this._horizontal)
                        {
                            this.scrollH = this.scrollH + this._scrollable.scrollStepH / this._scrollable.maxScrollH;
                        }
                        else
                        {
                            this.scrollV = this.scrollV + this._scrollable.scrollStepV / this._scrollable.maxScrollV;
                        }

                        this.var_2037 = false;
                    }

                }
                else
                {
                    if (param2.name == var_2031)
                    {
                        if (this._scrollable)
                        {
                            this.var_2037 = true;
                            if (this._horizontal)
                            {
                                this.scrollH = this.scrollH - this._scrollable.scrollStepH / this._scrollable.maxScrollH;
                            }
                            else
                            {
                                this.scrollV = this.scrollV - this._scrollable.scrollStepV / this._scrollable.maxScrollV;
                            }

                            this.var_2037 = false;
                        }

                    }
                    else
                    {
                        if (param2.name == var_2032)
                        {
                            if (param1 is WindowMouseEvent)
                            {
                                _loc4_ = WindowMouseEvent(param1).localX;
                                _loc5_ = WindowMouseEvent(param1).localY;
                            }
                            else
                            {
                                if (param1 is WindowTouchEvent)
                                {
                                    _loc4_ = WindowTouchEvent(param1).localX;
                                    _loc5_ = WindowTouchEvent(param1).localY;
                                }

                            }

                            _loc6_ = WindowController(param2).getChildByName(ScrollbarController.var_2033).rectangle;
                            if (this._horizontal)
                            {
                                if (_loc4_ < _loc6_.x)
                                {
                                    this.scrollH = this.scrollH - (this._scrollable.visibleRegion.width - this._scrollable.scrollStepH) / this._scrollable.maxScrollH;
                                }
                                else
                                {
                                    if (_loc4_ > _loc6_.right)
                                    {
                                        this.scrollH = this.scrollH + (this._scrollable.visibleRegion.width - this._scrollable.scrollStepH) / this._scrollable.maxScrollH;
                                    }

                                }

                            }
                            else
                            {
                                if (_loc5_ < _loc6_.y)
                                {
                                    this.scrollV = this.scrollV - (this._scrollable.visibleRegion.height - this._scrollable.scrollStepV) / this._scrollable.maxScrollV;
                                }
                                else
                                {
                                    if (_loc5_ > _loc6_.bottom)
                                    {
                                        this.scrollV = this.scrollV + (this._scrollable.visibleRegion.height - this._scrollable.scrollStepV) / this._scrollable.maxScrollV;
                                    }

                                }

                            }

                            _loc3_ = true;
                        }

                    }

                }

            }

            if (param1.type == WindowMouseEvent.var_635)
            {
                if (WindowMouseEvent(param1).delta > 0)
                {
                    if (this._horizontal)
                    {
                        this.scrollH = this.scrollH - this.var_2036;
                    }
                    else
                    {
                        this.scrollV = this.scrollV - this.var_2036;
                    }

                }
                else
                {
                    if (this._horizontal)
                    {
                        this.scrollH = this.scrollH + this.var_2036;
                    }
                    else
                    {
                        this.scrollV = this.scrollV + this.var_2036;
                    }

                }

                _loc3_ = true;
            }

            if (_loc3_)
            {
                this.updateLiftSizeAndPosition();
            }

        }

        private function resolveScrollTarget(): Boolean
        {
            var _loc1_: IScrollableWindow;
            var _loc2_: uint;
            var _loc3_: IScrollableWindow;
            var _loc4_: uint;
            if (this._scrollable != null)
            {
                if (!this._scrollable.disposed)
                {
                    return true;
                }

            }

            if (this.var_2035 != null)
            {
                _loc1_ = (findParentByName(this.var_2035) as IScrollableWindow);
                if (_loc1_ == null && (_parent is IWindowContainer))
                {
                    _loc1_ = (IWindowContainer(_parent).findChildByName(this.var_2035) as IScrollableWindow);
                    if (_loc1_)
                    {
                        this.scrollable = _loc1_;
                        return true;
                    }

                }

            }

            if (_parent is IScrollableWindow)
            {
                this.scrollable = IScrollableWindow(_parent);
                return true;
            }

            if ((_parent is IWindowContainer) && !(_parent is IDesktopWindow))
            {
                _loc2_ = IWindowContainer(_parent).numChildren;
                _loc4_ = 0;
                while (_loc4_ < _loc2_)
                {
                    _loc3_ = (IWindowContainer(_parent).getChildAt(_loc4_) as IScrollableWindow);
                    if (_loc3_)
                    {
                        this.scrollable = _loc3_;
                        return true;
                    }

                    _loc4_++;
                }

            }

            return false;
        }

        private function onScrollableResized(param1: WindowEvent): void
        {
            this.updateLiftSizeAndPosition();
            this.setScrollPosition(this._offset);
        }

        private function onScrollableScrolled(param1: WindowEvent): void
        {
            this.updateLiftSizeAndPosition();
        }

    }
}
