package com.sulake.core.window.utils
{

    import flash.utils.Proxy;

    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.IWindow;

    import flash.utils.flash_proxy;

    use namespace flash.utils.flash_proxy;

    public class Iterator extends Proxy implements IIterator
    {

        private static const UNKNOWN: uint = 0;
        private static const CHILDREN: uint = 1;
        private static const SELECTABLES: uint = 2;
        private static const LIST_ITEMS: uint = 3;
        private static const GRID_ITEMS: uint = 4;
        private static const TAB_ITEMS: uint = 5;

        private var _controller: WindowController;
        private var _type: uint;

        public function Iterator(controller: WindowController)
        {
            this._controller = controller;

            if (this._controller is ITabContextWindow)
            {
                this._type = Iterator.TAB_ITEMS;
            }
            else
            {
                if (this._controller is IItemGridWindow)
                {
                    this._type = Iterator.GRID_ITEMS;
                }
                else
                {
                    if (this._controller is IItemListWindow)
                    {
                        this._type = Iterator.LIST_ITEMS;
                    }
                    else
                    {
                        if (this._controller is ISelectorWindow)
                        {
                            this._type = Iterator.SELECTABLES;
                        }
                        else
                        {
                            if (this._controller is IWindowContainer)
                            {
                                this._type = Iterator.CHILDREN;
                            }
                            else
                            {
                                this._type = Iterator.UNKNOWN;
                            }

                        }

                    }

                }

            }

        }

        public function get length(): uint
        {
            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    return ITabContextWindow(this._controller).numTabItems;
                case Iterator.SELECTABLES:
                    return ISelectorWindow(this._controller).numSelectables;
                case Iterator.LIST_ITEMS:
                    return IItemListWindow(this._controller).numListItems;
                case Iterator.GRID_ITEMS:
                    return IItemGridWindow(this._controller).numGridItems;
                case Iterator.CHILDREN:
                    return IWindowContainer(this._controller).numChildren;
            }

            return 0;
        }

        public function indexOf(param1: *): int
        {
            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    return ITabContextWindow(this._controller).getTabItemIndex(param1);
                case Iterator.SELECTABLES:
                    return ISelectorWindow(this._controller).getSelectableIndex(param1);
                case Iterator.LIST_ITEMS:
                    return IItemListWindow(this._controller).getListItemIndex(param1);
                case Iterator.GRID_ITEMS:
                    return IItemGridWindow(this._controller).getGridItemIndex(param1);
                case Iterator.CHILDREN:
                    return IWindowContainer(this._controller).getChildIndex(param1);
            }

            return -1;
        }

        override flash_proxy function getProperty(param1: *): *
        {
            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    return ITabContextWindow(this._controller).getTabItemAt(uint(param1));
                case Iterator.SELECTABLES:
                    return this._controller.getChildAt(uint(param1));
                case Iterator.LIST_ITEMS:
                    return IItemListWindow(this._controller).getListItemAt(uint(param1));
                case Iterator.GRID_ITEMS:
                    return IItemGridWindow(this._controller).getGridItemAt(uint(param1));
                case Iterator.CHILDREN:
                    return IWindowContainer(this._controller).getChildAt(uint(param1));
            }

            return null;
        }

        override flash_proxy function setProperty(param1: *, param2: *): void
        {
            var _loc3_: ITabButtonWindow;
            var _loc4_: ITabContextWindow;
            var _loc5_: ISelectableWindow;
            var _loc6_: ISelectorWindow;
            var _loc7_: IItemListWindow;
            var _loc8_: IWindow;
            var _loc9_: IItemGridWindow;
            var _loc10_: IWindow;
            var _loc11_: IWindowContainer;
            var _loc12_: IWindow;

            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    _loc3_ = (param2 as ITabButtonWindow);
                    _loc4_ = (this._controller as ITabContextWindow);
                    if (_loc4_.getTabItemIndex(_loc3_) > -1)
                    {
                        _loc4_.removeTabItem(_loc3_);
                    }

                    _loc4_.addTabItemAt(_loc3_, uint(param1));
                    return;
                case Iterator.SELECTABLES:
                    _loc5_ = (param2 as ISelectableWindow);
                    _loc6_ = (this._controller as ISelectorWindow);
                    if (_loc5_)
                    {
                        if (_loc6_.getSelectableIndex(_loc5_) > -1)
                        {
                            _loc6_.removeSelectable(_loc5_);
                        }

                        _loc6_.addSelectableAt(_loc5_, uint(param1));
                    }
                    else
                    {
                        this._controller.addChildAt(param2, uint(param1));
                    }

                    return;
                case Iterator.LIST_ITEMS:
                    _loc7_ = (this._controller as IItemListWindow);
                    _loc8_ = (param2 as IWindow);
                    if (_loc7_.getListItemIndex(_loc8_) > -1)
                    {
                        _loc7_.removeListItem(_loc8_);
                    }

                    _loc7_.addListItemAt(_loc8_, uint(param1));
                    return;
                case Iterator.GRID_ITEMS:
                    _loc9_ = (this._controller as IItemGridWindow);
                    _loc10_ = (param2 as IWindow);
                    if (_loc9_.getGridItemIndex(_loc10_) > -1)
                    {
                        _loc9_.removeGridItem(_loc10_);
                    }

                    _loc9_.addGridItemAt(_loc10_, uint(param1));
                    return;
                case Iterator.CHILDREN:
                    _loc11_ = (this._controller as IWindowContainer);
                    _loc12_ = (param2 as IWindow);
                    if (_loc11_.getChildIndex(_loc12_) > -1)
                    {
                        _loc11_.removeChild(_loc12_);
                    }

                    _loc11_.addChildAt(_loc12_, uint(param1));
                    return;
            }

        }

        override flash_proxy function nextNameIndex(param1: int): int
        {
            var _loc2_: uint;
            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    _loc2_ = ITabContextWindow(this._controller).numTabItems;
                    break;
                case Iterator.SELECTABLES:
                    _loc2_ = ISelectorWindow(this._controller).numSelectables;
                    break;
                case Iterator.LIST_ITEMS:
                    _loc2_ = IItemListWindow(this._controller).numListItems;
                    break;
                case Iterator.GRID_ITEMS:
                    _loc2_ = IItemGridWindow(this._controller).numGridItems;
                    break;
                case Iterator.CHILDREN:
                    _loc2_ = IWindowContainer(this._controller).numChildren;
                    break;
            }

            if (param1 < _loc2_)
            {
                return param1 + 1;
            }

            return 0;
        }

        override flash_proxy function nextValue(param1: int): *
        {
            switch (this._type)
            {
                case Iterator.TAB_ITEMS:
                    return ITabContextWindow(this._controller).getTabItemAt(uint(param1) - 1);
                case Iterator.SELECTABLES:
                    return ISelectorWindow(this._controller).getSelectableAt(uint(param1) - 1);
                case Iterator.LIST_ITEMS:
                    return IItemListWindow(this._controller).getListItemAt(uint(param1) - 1);
                case Iterator.GRID_ITEMS:
                    return IItemGridWindow(this._controller).getGridItemAt(uint(param1) - 1);
                case Iterator.CHILDREN:
                    return IWindowContainer(this._controller).getChildAt(uint(param1) - 1);
            }

            return null;
        }

    }
}
