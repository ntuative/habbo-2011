package com.sulake.core.window.components
{

    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;

    import flash.geom.Rectangle;

    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class DropMenuController extends InteractiveController implements IDropMenuWindow, ITouchAwareWindow
    {

        protected static const var_1985: String = "_DROPMENU_TITLETEXT";
        protected static const ITEMLIST_NAME: String = "_DROPMENU_ITEMLIST";

        private var var_1989: Array = [];
        private var _selection: int = -1;
        private var var_1990: Boolean = false;
        private var var_1991: DropMenuController;

        public function DropMenuController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function, param9: Array = null, param10: Array = null, param11: uint = 0)
        {
            param4 = param4 | WindowParam.var_593;
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function get selection(): int
        {
            return this._selection;
        }

        public function set selection(param1: int): void
        {
            if (param1 > this.var_1989.length - 1)
            {
                throw new Error("Menu selection index out of range!");
            }


            var _loc2_: WindowEvent = WindowEvent.allocate(WindowEvent.var_559, this, null, true);

            this.update(this, _loc2_);

            if (!_loc2_.isWindowOperationPrevented())
            {
                _loc2_.recycle();
                this._selection = param1;
                this.closeMenuView();
                _loc2_ = WindowEvent.allocate(WindowEvent.var_560, this, null);
                this.update(this, _loc2_);
            }


            _loc2_.recycle();
        }

        override public function set caption(caption: String): void
        {
            super.caption = caption;

            this.getTitleLabel().text = caption;
        }

        override public function dispose(): void
        {
            if (this.var_1991 != null && !this.var_1991.disposed)
            {
                this.var_1991.destroy();
                this.var_1991 = null;
            }

            super.dispose();
        }

        override public function activate(): Boolean
        {
            if (this.var_1990)
            {
                return true;
            }

            return super.activate();
        }

        private function getTitleLabel(): ILabelWindow
        {
            return getChildByName(DropMenuController.var_1985) as ILabelWindow;
        }

        private function getSubMenu(): DropMenuController
        {
            var _loc1_: Rectangle = new Rectangle();
            getGlobalRectangle(_loc1_);
            if (this.var_1991 == null || this.var_1991.disposed)
            {
                this.var_1991 = (context.create(name + "::submenu", "", WindowType.var_871, _style, WindowParam.var_706 | WindowParam.var_694, _loc1_, this.subMenuEventProc, null, 0, null, [WindowController.TAG_EXCLUDE]) as DropMenuController);
            }
            else
            {
                this.var_1991.setGlobalRectangle(_loc1_);
            }

            this.var_1991.activate();
            return this.var_1991;
        }

        override public function populate(param1: Array): void
        {
            this._selection = -1;
            while (this.var_1989.length > 0)
            {
                this.var_1989.pop();
            }

            var _loc2_: uint;
            while (_loc2_ < param1.length)
            {
                this.var_1989.push(param1[_loc2_]);
                _loc2_++;
            }

            this.var_1990 = true;
            this.closeMenuView();
        }

        public function getMenuItemIndex(param1: IDropMenuItemWindow): int
        {
            var _loc2_: int = -1;
            var _loc3_: IItemListWindow = getChildByName(DropMenuController.ITEMLIST_NAME) as IItemListWindow;
            if (_loc3_ != null)
            {
                _loc2_ = _loc3_.getListItemIndex(param1);
            }

            if (_loc2_ == -1)
            {
                if (this.var_1991 != null)
                {
                    _loc2_ = this.var_1991.getMenuItemIndex(param1);
                }

            }

            return _loc2_;
        }

        protected function openMenuView(): void
        {
            if (!this.var_1990)
            {
                if (this.open())
                {
                    if (this.var_1989.length)
                    {
                        this.populateMenuItemContainer(this.var_1989, this.getSubMenu(), this.subMenuEventProc);
                        this.var_1990 = true;
                    }

                }

            }

        }

        protected function closeMenuView(): void
        {
            if (this.close())
            {
                if (this.var_1991 != null)
                {
                    this.var_1991.destroy();
                    this.var_1991 = null;
                }

                this.var_1990 = false;
                this.getTitleLabel().text = this._selection < this.var_1989.length && this._selection > -1
                        ? this.var_1989[this._selection]
                        : caption;
            }

        }

        protected function populateMenuItemContainer(param1: Array, param2: DropMenuController, param3: Function): void
        {
            var _loc6_: IDropMenuItemWindow;
            var _loc4_: IItemListWindow = param2.getChildByName(DropMenuController.ITEMLIST_NAME) as IItemListWindow;
            _loc4_.autoArrangeItems = false;
            var _loc5_: uint = param1.length;
            var _loc7_: int = _loc4_.width;
            var _loc8_: int = _loc7_;
            var _loc9_: uint;
            while (_loc9_ < _loc5_)
            {
                _loc6_ = (context.create(name + "::menu_item_" + _loc9_, param1[_loc9_], WindowType.var_872, _style, WindowParam.var_663 | WindowParam.var_667 | WindowParam.var_693 | WindowParam.var_593 | WindowParam.var_694, null, param3, null, _loc9_, null, ["_EXCLUDE"]) as DropMenuItemController);
                _loc8_ = Math.max(_loc8_, _loc6_.width);
                _loc6_.width = _loc7_;
                _loc4_.addListItem(_loc6_);
                _loc9_++;
            }

            if (_loc8_ > _loc7_)
            {
                param2.width = param2.width + (_loc8_ - _loc4_.width);
                _loc9_ = 0;
                while (_loc9_ < _loc5_)
                {
                    _loc4_.getListItemAt(_loc9_).width = _loc8_;
                    _loc9_++;
                }

            }

            var _loc10_: IWindow = context.create(name + "::padding", "", WindowType.var_868, _style, WindowParam.var_663 | WindowParam.var_667 | WindowParam.var_693 | WindowParam.var_694, new Rectangle(0, 0, 1, 2), null, null, 0, null, ["_EXCLUDE"]);
            _loc4_.addListItem(_loc10_);
            _loc4_.autoArrangeItems = true;
            this.fitToDesktop(param2);
            param2.activate();
            if (this._selection > -1 && _loc5_)
            {
                _loc4_.getListItemAt(this._selection).setStateFlag(WindowState.var_1112, true);
            }

        }

        private function fitToDesktop(param1: IWindow): void
        {
            var _loc2_: Rectangle = new Rectangle();
            param1.getGlobalRectangle(_loc2_);
            if (_loc2_.bottom > desktop.rectangle.bottom)
            {
                param1.offset(0, desktop.rectangle.bottom - _loc2_.bottom);
            }
            else
            {
                if (_loc2_.top < desktop.rectangle.top)
                {
                    param1.offset(0, _loc2_.top - desktop.rectangle.top);
                }

            }

            if (_loc2_.left < desktop.rectangle.left)
            {
                param1.offset(_loc2_.left - desktop.rectangle.left, 0);
            }
            else
            {
                if (_loc2_.right > desktop.rectangle.right)
                {
                    param1.offset(desktop.rectangle.right - _loc2_.right, 0);
                }

            }

        }

        private function menuItemEventProc(param1: WindowEvent, param2: IWindow): void
        {
            var _loc3_: uint;
            if (param1.type == WindowMouseEvent.var_628 || param1.type == WindowTouchEvent.var_1722)
            {
                if (param2 is IDropMenuItemWindow)
                {
                    _loc3_ = this.getMenuItemIndex(param2 as IDropMenuItemWindow);
                    this.selection = _loc3_;
                }

            }

        }

        private function subMenuEventProc(param1: WindowEvent, param2: IWindow): void
        {
            switch (param1.type)
            {
                case WindowTouchEvent.var_1721:
                case WindowMouseEvent.var_633:
                    if (param2 is IDropMenuItemWindow)
                    {
                        if (param2.testStateFlag(WindowState.var_1038))
                        {
                            this.selection = this.getMenuItemIndex(param2 as IDropMenuItemWindow);
                        }

                    }

                    return;
                case WindowTouchEvent.var_1720:
                case WindowMouseEvent.var_628:
                    if (param2 is IDropMenuItemWindow)
                    {
                        this.selection = this.getMenuItemIndex(param2 as IDropMenuItemWindow);
                    }

                    return;
                case WindowEvent.var_558:
                    if (param2 == this.var_1991)
                    {
                        this.closeMenuView();
                    }

                    return;
            }

        }

        override public function update(param1: WindowController, param2: WindowEvent): Boolean
        {
            switch (param2.type)
            {
                case WindowTouchEvent.var_1720:
                case WindowMouseEvent.var_628:
                    if (!this.var_1990)
                    {
                        this.openMenuView();
                    }

                    break;
            }

            return super.update(param1, param2);
        }

        public function open(): Boolean
        {
            if (getStateFlag(WindowState.var_990))
            {
                return true;
            }

            var _loc1_: WindowEvent = WindowEvent.allocate(WindowEvent.var_547, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return false;
            }

            _loc1_.recycle();
            visible = true;
            _loc1_ = WindowEvent.allocate(WindowEvent.var_548, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return true;
        }

        public function close(): Boolean
        {
            if (!getStateFlag(WindowState.var_990))
            {
                return true;
            }

            var _loc1_: WindowEvent = WindowEvent.allocate(WindowEvent.var_549, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return false;
            }

            _loc1_.recycle();
            visible = false;
            _loc1_ = WindowEvent.allocate(WindowEvent.var_550, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return true;
        }

        public function enumerateSelection(): Array
        {
            var _loc2_: int;
            var _loc1_: Array = [];
            if (!_disposed)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_1989.length)
                {
                    _loc1_.push(this.var_1989[_loc2_]);
                    _loc2_++;
                }

            }

            return _loc1_;
        }

        override public function get properties(): Array
        {
            var _loc1_: Array = super.properties;
            if (this.var_1989.length)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1724, this.var_1989, PropertyStruct.var_616, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1725);
            }

            return _loc1_;
        }

        override public function set properties(param1: Array): void
        {
            var _loc2_: PropertyStruct;
            InteractiveController.readInteractiveWindowProperties(this, param1);
            for each (_loc2_ in param1)
            {
                if (_loc2_.key == PropertyDefaults.var_1724)
                {
                    this.populate(_loc2_.value as Array);
                    break;
                }

            }

            super.properties = param1;
        }

    }
}
