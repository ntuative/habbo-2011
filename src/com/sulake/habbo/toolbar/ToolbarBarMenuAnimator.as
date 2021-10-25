package com.sulake.habbo.toolbar
{

    import com.sulake.habbo.window.IHabboWindowManager;

    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.geom.Point;

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.events.WindowEvent;

    public class ToolbarBarMenuAnimator
    {

        private static const var_4536: Boolean = true;
        private static const var_1323: Number = 25;
        private static const var_1324: Number = 90;
        private static const var_4537: int = 50;
        private static const var_4538: int = 50;

        private var _windowManager: IHabboWindowManager;
        private var var_4539: ToolbarView;
        private var var_4535: Timer;
        private var var_4540: Array = [];
        private var _itemList: Object = {};
        private var var_4541: Object = {};
        private var var_4542: Array = [];
        private var var_4543: Array = [];
        private var _toolbarSize: Number;

        public function ToolbarBarMenuAnimator(param1: IHabboWindowManager, param2: ToolbarView)
        {
            this._windowManager = param1;
            this.var_4539 = param2;
            this.var_4535 = new Timer(var_1323);
            this.var_4535.addEventListener(TimerEvent.TIMER, this.animationUpdate);
        }

        public function dispose(): void
        {
            if (this.var_4535 != null)
            {
                this.var_4535.stop();
                this.var_4535 = null;
            }

            this._itemList = {};
            this.var_4540 = [];
            this.var_4542 = null;
            this.var_4543 = null;
            this._windowManager = null;
            this.var_4539 = null;
        }

        public function animateWindowIn(param1: ToolbarIcon, param2: String, param3: IWindowContainer, param4: String, param5: Number, param6: String, param7: Array = null): void
        {
            if (param3 == null)
            {
                return;
            }

            if (var_4536)
            {
                this.registerWindow(param3, param2);
                this.registerDependentMenu(param2, param7);
            }

            this._toolbarSize = param5;
            param3.visible = true;
            if (!this.windowShouldAnimate(param3, param5, param1.windowMargin, param6))
            {
                this.positionWindow(param1, param2, param3, param4, param5, param7);
                return;
            }

            var _loc8_: MenuAnimatorItem = this.createItemObject(param2, param1);
            _loc8_.window = param3;
            _loc8_.iconId = param4;
            _loc8_.offsetLoc = this.getOffsetLocationForMenu(param2, param3, param5);
            if (var_4536)
            {
                _loc8_.yieldList = param7;
            }

            _loc8_.active = true;
            _loc8_.visible = true;
            this.prepareWindowForScrollIn(_loc8_);
            var _loc9_: Point = this.getWindowTargetIn(_loc8_);
            if (_loc9_ != null)
            {
                _loc8_.target = _loc9_;
                this.animateWindow(_loc8_);
            }

        }

        public function animateWindowOut(param1: ToolbarIcon, param2: String, param3: IWindowContainer, param4: String): void
        {
            if (param3 == null)
            {
                return;
            }

            this.registerWindow(param3, param2);
            var _loc5_: MenuAnimatorItem = this.createItemObject(param2, param1);
            _loc5_.window = param3;
            _loc5_.active = true;
            _loc5_.visible = false;
            var _loc6_: Point = this.getWindowTargetOut(param3);
            if (_loc6_ != null)
            {
                _loc5_.target = _loc6_;
                this.animateWindow(_loc5_);
            }

        }

        public function positionWindow(param1: ToolbarIcon, param2: String, param3: IWindowContainer, param4: String, param5: Number, param6: Array = null): void
        {
            if (param3 == null)
            {
                return;
            }

            if (var_4536)
            {
                this.registerWindow(param3, param2);
                this.registerDependentMenu(param2, param6);
            }

            this._toolbarSize = param5;
            var _loc7_: MenuAnimatorItem = this.createItemObject(param2, param1);
            _loc7_.active = true;
            _loc7_.visible = true;
            _loc7_.window = param3;
            _loc7_.iconId = param4;
            _loc7_.offsetLoc = this.getOffsetLocationForMenu(param2, param3, param5);
            if (var_4536)
            {
                _loc7_.yieldList = param6;
            }

            this.prepareWindowForScrollIn(_loc7_);
            var _loc8_: Point = this.getWindowTargetIn(_loc7_);
            if (_loc8_ != null)
            {
                _loc7_.target = null;
                param3.x = _loc8_.x;
                param3.y = _loc8_.y;
            }

            this.removeItem(param2);
        }

        public function hideWindow(param1: String, param2: IWindowContainer, param3: String, param4: Number): void
        {
            if (param2 == null)
            {
                return;
            }

            this._toolbarSize = param4;
            this.removeItem(param1);
            var _loc5_: Point = this.getWindowTargetOut(param2);
            if (_loc5_ != null)
            {
                param2.x = _loc5_.x;
                param2.y = _loc5_.y;
            }

            param2.visible = false;
        }

        public function refresh(): void
        {
            var _loc1_: int;
            while (_loc1_ < this.var_4540.length)
            {
                this.repositionWindow(this.var_4540[_loc1_], true);
                _loc1_++;
            }

        }

        private function getOffsetLocationForMenu(param1: String, param2: IWindowContainer, param3: Number): Point
        {
            var _loc4_: Point = new Point();
            var _loc5_: Point = new Point();
            param2.getGlobalPosition(_loc5_);
            var _loc6_: Point = new Point();
            var _loc7_: Point = new Point();
            var _loc8_: IWindow = param2.findChildByTag("toolbar_anchor_horizontal");
            if (_loc8_ != null && _loc8_.visible)
            {
                _loc8_.getGlobalPosition(_loc7_);
                _loc6_.x = _loc7_.x - _loc5_.x;
            }

            _loc8_ = param2.findChildByTag("toolbar_anchor_vertical");
            if (_loc8_ != null && _loc8_.visible)
            {
                _loc8_.getGlobalPosition(_loc7_);
                _loc6_.y = _loc7_.y - _loc5_.y;
            }

            _loc4_.subtract(_loc6_);
            return _loc4_;
        }

        public function repositionWindow(param1: String, param2: Boolean): void
        {
            var _loc3_: MenuAnimatorItem = this.getItemObject(param1);
            if (_loc3_ == null)
            {
                return;
            }

            var _loc4_: IWindow = this.getWindowByName(this.getWindowName(param1));
            if (_loc4_ == null || !_loc3_.visible || !_loc4_.visible)
            {
                return;
            }

            if (_loc3_.lockToIcon)
            {
                this.alignWindowToIcon(_loc4_, _loc4_.context.getDesktopWindow(), _loc3_);
            }

            if (param2 && !this.isOutsideScreen(_loc4_) && !_loc3_.lockToIcon)
            {
                return;
            }

            var _loc5_: Point = this.getWindowTargetIn(_loc3_);
            if (_loc5_ == null)
            {
                return;
            }

            _loc4_.x = _loc5_.x;
            _loc4_.y = _loc5_.y;
        }

        private function isOutsideScreen(param1: IWindow): Boolean
        {
            return param1.x + param1.width < var_4537 + this._toolbarSize || param1.y < 0 || param1.desktop.width - param1.x < var_4537 || param1.desktop.height - param1.y < var_4538;
        }

        private function getItemObject(param1: String): MenuAnimatorItem
        {
            return this._itemList[param1];
        }

        private function createItemObject(param1: String, param2: ToolbarIcon): MenuAnimatorItem
        {
            var _loc4_: ToolbarIcon;
            var _loc3_: MenuAnimatorItem = this.getItemObject(param1);
            if (_loc3_ == null)
            {
                _loc3_ = new MenuAnimatorItem(param1, param2);
                _loc4_ = this.var_4539.getIconByMenuId(param1);
                if (_loc4_ == null)
                {
                    return null;
                }

                _loc3_.iconId = _loc4_.iconId;
                _loc3_.lockToIcon = _loc4_.menuLockedToIcon(param1);
                this._itemList[_loc3_.menuId] = _loc3_;
                this.var_4540.push(_loc3_.menuId);
            }

            return _loc3_;
        }

        private function prepareWindowForScrollIn(param1: MenuAnimatorItem): void
        {
            if (param1 == null)
            {
                return;
            }

            var _loc2_: IWindow = param1.window;
            var _loc3_: String = param1.iconId;
            var _loc4_: Point = this.getDesktopOffset(_loc2_);
            var _loc5_: IDesktopWindow = _loc2_.context.getDesktopWindow();
            if (_loc5_ == null)
            {
                return;
            }

            _loc2_.x = -_loc2_.width - _loc4_.x;
        }

        private function getWindowTargetIn(param1: MenuAnimatorItem): Point
        {
            var _loc8_: int;
            var _loc9_: IWindow;
            var _loc10_: Point;
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: IWindow = param1.window;
            var _loc3_: String = param1.iconId;
            var _loc4_: Array = param1.yieldList;
            if (_loc2_ == null)
            {
                _loc2_ = this.getWindowByName(this.getWindowName(param1.menuId));
            }

            if (_loc2_ == null || _loc2_.disposed)
            {
                return null;
            }

            var _loc5_: IDesktopWindow = _loc2_.context.getDesktopWindow();
            if (_loc5_ == null)
            {
                return null;
            }

            var _loc6_: Point = new Point();
            var _loc7_: Point = this.getDesktopOffset(_loc2_);
            this.alignWindowToIcon(_loc2_, _loc5_, param1);
            _loc6_.x = this._toolbarSize + param1.margin;
            _loc6_.y = _loc2_.y;
            _loc6_ = _loc6_.subtract(_loc7_);
            if (var_4536)
            {
                if (_loc4_ != null)
                {
                    _loc8_ = 0;
                    while (_loc8_ < _loc4_.length)
                    {
                        _loc9_ = this.getWindowByName(this.getWindowName(_loc4_[_loc8_]));
                        if (_loc9_ != null && _loc9_.visible)
                        {
                            _loc10_ = this.getDesktopOffset(_loc9_);
                            if (_loc9_.rectangle.right + _loc10_.x > _loc6_.x)
                            {
                                _loc6_.x = _loc9_.rectangle.right + _loc10_.x;
                            }

                        }

                        _loc8_++;
                    }

                }

            }

            return _loc6_;
        }

        private function alignWindowToIcon(param1: IWindow, param2: IDesktopWindow, param3: MenuAnimatorItem): void
        {
            var _loc4_: Point = this.getIconLoc(param3);
            param1.y = Math.max(0, Math.min(_loc4_.y + param3.windowOffsetFromIcon, param2.height - param1.height - param3.bottomMargin));
        }

        private function getIconLoc(param1: MenuAnimatorItem): Point
        {
            var _loc2_: Point = this.var_4539.getIconLoc(param1.iconId);
            if (param1.offsetLoc != null)
            {
                _loc2_.add(param1.offsetLoc);
            }

            return _loc2_;
        }

        private function getWindowName(param1: String): String
        {
            return this.var_4542[this.var_4543.indexOf(param1)];
        }

        private function getWindowMenuId(param1: String): String
        {
            return this.var_4543[this.var_4542.indexOf(param1)];
        }

        private function getWindowByName(param1: String): IWindow
        {
            var _loc3_: IWindowContext;
            if (this._windowManager == null)
            {
                return null;
            }

            var _loc2_: IWindow = this._windowManager.getWindowByName(param1);
            if (_loc2_ == null)
            {
                _loc3_ = this._windowManager.getWindowContext(0);
                if (_loc3_ != null)
                {
                    _loc2_ = _loc3_.findWindowByName(param1);
                }

            }

            return _loc2_;
        }

        private function getDesktopOffset(param1: IWindow): Point
        {
            if (param1 == null)
            {
                return new Point();
            }

            var _loc2_: Point = new Point();
            var _loc3_: Point = param1.position;
            param1.getGlobalPosition(_loc3_);
            if (!_loc3_.equals(param1.position))
            {
                _loc2_ = _loc3_.subtract(param1.position);
            }

            return _loc2_;
        }

        private function getWindowTargetOut(param1: IWindowContainer): Point
        {
            var _loc2_: IDesktopWindow = param1.context.getDesktopWindow();
            if (_loc2_ == null)
            {
                return null;
            }

            var _loc3_: Point = new Point();
            _loc3_.x = -param1.width;
            _loc3_.y = param1.y;
            return _loc3_.subtract(this.getDesktopOffset(param1));
        }

        private function animateWindow(param1: MenuAnimatorItem): void
        {
            if (param1.window == null)
            {
                return;
            }

            param1.window.visible = true;
            param1.window.activate();
            this.var_4535.start();
        }

        private function windowShouldAnimate(param1: IWindowContainer, param2: Number, param3: int, param4: String): Boolean
        {
            if (param1 == null)
            {
                return false;
            }

            var _loc5_: Point = param1.rectangle.topLeft.subtract(this.getDesktopOffset(param1));
            return _loc5_.x <= param2 + param3;


        }

        private function registerWindow(param1: IWindowContainer, param2: String): void
        {
            if (param1.name == "")
            {
                return;
            }

            var _loc3_: int = this.var_4543.indexOf(param2);
            if (_loc3_ > -1)
            {
                this.var_4543.splice(_loc3_, 1);
                this.var_4542.splice(_loc3_, 1);
            }

            this.var_4542.push(param1.name);
            this.var_4543.push(param2);
            param1.addEventListener(WindowEvent.var_571, this.windowEventListener);
            param1.addEventListener(WindowEvent.var_570, this.windowEventListener);
        }

        private function registerDependentMenu(param1: String, param2: Array): void
        {
            var _loc3_: String;
            if (!var_4536)
            {
                return;
            }

            if (param2 == null)
            {
                return;
            }

            var _loc4_: int;
            while (_loc4_ < param2.length)
            {
                _loc3_ = param2[_loc4_];
                if (this.var_4541[_loc3_] == null)
                {
                    this.var_4541[_loc3_] = [];
                }

                if (this.var_4541[_loc3_].indexOf(param1) < 0)
                {
                    this.var_4541[_loc3_].push(param1);
                }

                _loc4_++;
            }

        }

        public function removeItem(param1: String): void
        {
            if (this.var_4540.indexOf(param1) > -1)
            {
                if (var_4536)
                {
                    this._itemList[param1].active = false;
                    this._itemList[param1].window = null;
                }
                else
                {
                    this._itemList[param1] = null;
                    this.var_4540.splice(this.var_4540.indexOf(param1), 1);
                }

            }

        }

        public function windowEventListener(param1: WindowEvent): void
        {
            var _loc3_: String;
            var _loc4_: int;
            var _loc2_: int;
            while (_loc2_ < this.var_4542.length)
            {
                if (this.var_4542[_loc2_] == param1.window.name)
                {
                    _loc3_ = this.var_4543[_loc2_];
                    if (this.var_4541[_loc3_] != null)
                    {
                        _loc4_ = 0;
                        while (_loc4_ < this.var_4541[_loc3_].length)
                        {
                            this.repositionWindow(this.var_4541[_loc3_][_loc4_], false);
                            _loc4_++;
                        }

                    }

                }

                _loc2_++;
            }

        }

        private function animationUpdate(param1: TimerEvent): void
        {
            var _loc2_: MenuAnimatorItem;
            var _loc3_: IWindowContainer;
            var _loc4_: Point;
            var _loc5_: Number;
            var _loc6_: Number;
            if (this.var_4540.length == 0)
            {
                this.var_4535.stop();
            }

            var _loc7_: int;
            while (_loc7_ < this.var_4540.length)
            {
                _loc2_ = this._itemList[this.var_4540[_loc7_]];
                if (_loc2_.active)
                {
                    _loc3_ = _loc2_.window;
                    _loc4_ = _loc2_.target;
                    if (_loc3_ == null || _loc3_.disposed || _loc4_ == null)
                    {
                        this.removeItem(_loc2_.menuId);
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            if (!isNaN(_loc4_.x))
                            {
                                _loc5_ = (_loc4_.x - _loc3_.x) / 2;
                                if (Math.abs(_loc5_) < 1)
                                {
                                    _loc3_.x = _loc4_.x;
                                }
                                else
                                {
                                    _loc3_.x = _loc3_.x + _loc5_;
                                }

                            }

                            if (!isNaN(_loc4_.y))
                            {
                                _loc6_ = (_loc4_.y - _loc3_.y) / 2;
                                if (Math.abs(_loc6_) < 1)
                                {
                                    _loc3_.y = _loc4_.y;
                                }
                                else
                                {
                                    _loc3_.y = _loc3_.y + _loc6_;
                                }

                            }

                            if ((isNaN(_loc4_.x) || _loc3_.x == _loc4_.x) && (isNaN(_loc4_.x) || _loc3_.y == _loc4_.y))
                            {
                                _loc3_.visible = _loc2_.visible;
                                this.removeItem(_loc2_.menuId);
                            }

                        }

                    }

                }

                _loc7_++;
            }

        }

    }
}
