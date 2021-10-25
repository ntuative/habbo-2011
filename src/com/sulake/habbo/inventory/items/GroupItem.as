package com.sulake.habbo.inventory.items
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.IRoomEngine;

    import flash.display.BitmapData;

    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    import com.sulake.core.window.components.ITextWindow;

    public class GroupItem implements IGetImageListener
    {

        private const BACKGROUND_GROUP_SELECTED: int = 0x888888;
        private const BACKGROUND_GROUP_DESELECTED: int = 0xCCCCCC;
        private const BLEND_GROUP_UNLOCKED: Number = 1;
        private const BLEND_GROUP_LOCKED: Number = 0.2;

        protected var _type: int;
        protected var _items: Map;
        protected var _window: IWindowContainer;
        private var _background: IWindow;
        protected var _roomEngine: IRoomEngine;
        protected var _isLocked: Boolean;
        protected var _selected: Boolean;
        protected var _furniType: String;
        protected var _category: int;
        protected var _stuffData: String;
        protected var _extra: Number;
        protected var _iconCallbackId: int = 0;
        protected var _iconImage: BitmapData;
        protected var _previewCallbackId: int;
        protected var _isImageInited: Boolean;
        protected var _isRecyclable: Boolean;
        protected var _recyclableIcon: BitmapData;

        public function GroupItem(type: int, furniType: String, category: int, window: IWindowContainer, roomEngine: IRoomEngine, recyclableIcon: BitmapData, isRecyclable: Boolean, stuffData: String = null, extra: Number = NaN, groupIcon: BitmapData = null, initIcon: Boolean = false)
        {
            super();

            var _loc12_: ImageResult;

            this._type = type;
            this._window = window;
            this._background = this._window.findChildByTag("BG_COLOR");
            this._roomEngine = roomEngine;
            this._recyclableIcon = recyclableIcon;
            this._isRecyclable = isRecyclable;
            this._items = new Map();
            this._furniType = furniType;
            this._category = category;
            this._stuffData = stuffData;
            this._extra = extra;

            if (groupIcon != null)
            {
                this.setFinalImage(groupIcon);
            }
            else
            {
                if (!initIcon)
                {
                    this.initImage();
                }

            }

        }

        private function setFinalImage(icon: BitmapData): void
        {
            this._iconImage = icon;
            this._isImageInited = true;
            this._iconCallbackId = -1;
            this.updateThumbData();
        }

        private function setLoadingImage(icon: BitmapData): void
        {
            this._iconImage = icon;
            this._isImageInited = true;
            this.updateThumbData();
        }

        public function initImage(loading: Boolean = true): void
        {
            var _loc2_: ImageResult;

            if (this._iconImage != null)
            {
                return;
            }

            if (this._furniType == FurniModel.FLOOR)
            {
                _loc2_ = this._roomEngine.getFurnitureIcon(this._type, this, String(this._extra));
            }
            else
            {
                _loc2_ = this._roomEngine.getWallItemIcon(this._type, this, this._stuffData);
            }

            if (_loc2_.id > 0)
            {
                if (loading)
                {
                    this.setLoadingImage(_loc2_.data);
                }

                this._iconCallbackId = _loc2_.id;
            }
            else
            {
                this.setFinalImage(_loc2_.data);
                this._iconCallbackId = -1;
            }

            this._isImageInited = true;
        }

        public function get isImageInited(): Boolean
        {
            return this._isImageInited;
        }

        public function get isImageFinished(): Boolean
        {
            return this._iconCallbackId == -1;
        }

        public function set isSelected(value: Boolean): void
        {
            if (this._selected != value)
            {
                this._selected = value;
                this.updateThumbData();
            }

        }

        public function get window(): IWindowContainer
        {
            if (this._window == null)
            {
                return null;
            }

            if (this._window.disposed)
            {
                return null;
            }

            return this._window;
        }

        public function set isLocked(param1: Boolean): void
        {
            this._isLocked = param1;
        }

        public function get isLocked(): Boolean
        {
            return this._isLocked;
        }

        public function get isSelected(): Boolean
        {
            return this._selected;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get iconImage(): BitmapData
        {
            return this._iconImage;
        }

        public function set iconImage(param1: BitmapData): void
        {
            this._iconImage = param1;
        }

        public function get iconCallbackId(): int
        {
            return this._iconCallbackId;
        }

        public function set iconCallbackId(param1: int): void
        {
            this._iconCallbackId = param1;
        }

        public function get previewCallbackId(): int
        {
            return this._previewCallbackId;
        }

        public function set previewCallbackId(param1: int): void
        {
            this._previewCallbackId = param1;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function get extra(): Number
        {
            return this._extra;
        }

        public function set showRecyclable(param1: Boolean): void
        {
            this._isRecyclable = param1;
            this.updateThumbData();
        }

        public function push(param1: IItem): void
        {
            var _loc2_: IItem = this._items.getValue(param1.id);
            if (_loc2_ == null)
            {
                this._items.add(param1.id, param1);
            }
            else
            {
                _loc2_.locked = false;
            }

            this.updateThumbData();
        }

        public function unshift(param1: IItem): void
        {
            var _loc2_: IItem = this._items.getValue(param1.id);
            if (_loc2_ == null)
            {
                this._items.unshift(param1.id, param1);
            }
            else
            {
                _loc2_.locked = false;
            }

            this.updateThumbData();
        }

        public function pop(): IItem
        {
            var _loc1_: IItem;
            if (this._items.length > 0)
            {
                _loc1_ = (this._items.getWithIndex(this._items.length - 1) as IItem);
                this._items.remove(_loc1_.id);
            }

            this.updateThumbData();
            return _loc1_;
        }

        public function peek(): IItem
        {
            var _loc1_: IItem;
            if (this._items.length > 0)
            {
                _loc1_ = (this._items.getWithIndex(this._items.length - 1) as IItem);
            }

            return _loc1_;
        }

        public function getAt(param1: int): IItem
        {
            return this._items.getWithIndex(param1);
        }

        public function getOneForTrade(): IItem
        {
            var _loc2_: IItem;
            var _loc1_: int;
            while (_loc1_ < this._items.length)
            {
                _loc2_ = this._items.getWithIndex(_loc1_);
                if (!_loc2_.locked && _loc2_.tradeable)
                {
                    return _loc2_;
                }

                _loc1_++;
            }

            return null;
        }

        public function getOneForRecycle(): IItem
        {
            var _loc2_: IItem;
            var _loc1_: int;
            while (_loc1_ < this._items.length)
            {
                _loc2_ = this._items.getWithIndex(_loc1_);
                if (!_loc2_.locked && _loc2_.recyclable)
                {
                    this.addLockTo(_loc2_.id);
                    return _loc2_;
                }

                _loc1_++;
            }

            return null;
        }

        public function getOneForSelling(): IItem
        {
            var _loc2_: IItem;
            var _loc1_: int;
            while (_loc1_ < this._items.length)
            {
                _loc2_ = this._items.getWithIndex(_loc1_);
                if (!_loc2_.locked && _loc2_.sellable)
                {
                    return _loc2_;
                }

                _loc1_++;
            }

            return null;
        }

        public function addLockTo(param1: int): Boolean
        {
            var _loc3_: IItem;
            var _loc2_: int;
            while (_loc2_ < this._items.length)
            {
                _loc3_ = this._items.getWithIndex(_loc2_);
                if (_loc3_.id == param1)
                {
                    _loc3_.locked = true;
                    this.updateThumbData();
                    return true;
                }

                _loc2_++;
            }

            return false;
        }

        public function addLocksFromData(param1: Array): void
        {
            var _loc3_: IItem;
            var _loc2_: int = this._items.length - 1;
            while (_loc2_ >= 0)
            {
                _loc3_ = this._items.getWithIndex(_loc2_);
                _loc3_.locked = param1.indexOf(_loc3_.ref) >= 0;

                _loc2_--;
            }

            this.updateThumbData();
        }

        public function removeLockFrom(param1: int): Boolean
        {
            var _loc3_: IItem;
            var _loc2_: int;
            while (_loc2_ < this._items.length)
            {
                _loc3_ = this._items.getWithIndex(_loc2_);
                if (_loc3_.id == param1)
                {
                    _loc3_.locked = false;
                    this.updateThumbData();
                    return true;
                }

                _loc2_++;
            }

            return false;
        }

        public function removeAllLocks(): void
        {
            var _loc2_: IItem;
            var _loc1_: int = this._items.length - 1;
            while (_loc1_ >= 0)
            {
                _loc2_ = this._items.getWithIndex(_loc1_);
                _loc2_.locked = false;
                _loc1_--;
            }

            this.updateThumbData();
        }

        public function getTotalCount(): int
        {
            var _loc1_: int;
            var _loc2_: int;
            var _loc3_: IItem;
            if (this.category == FurniCategory.var_597)
            {
                _loc1_ = 0;
                _loc2_ = 0;
                while (_loc2_ < this._items.length)
                {
                    _loc3_ = (this._items.getWithIndex(_loc2_) as IItem);
                    _loc1_ = _loc1_ + int(_loc3_.stuffData);
                    _loc2_++;
                }

                return _loc1_;
            }

            return this._items.length;
        }

        public function getRecyclableCount(): int
        {
            var _loc3_: IItem;
            var _loc1_: int;
            var _loc2_: int;
            while (_loc2_ < this._items.length)
            {
                _loc3_ = (this._items.getWithIndex(_loc2_) as IItem);
                if (_loc3_.recyclable && !_loc3_.locked)
                {
                    _loc1_++;
                }

                _loc2_++;
            }

            return _loc1_;
        }

        public function getTradeableCount(): int
        {
            var _loc3_: IItem;
            var _loc1_: int;
            var _loc2_: int;
            while (_loc2_ < this._items.length)
            {
                _loc3_ = (this._items.getWithIndex(_loc2_) as IItem);
                if (_loc3_.tradeable && !_loc3_.locked)
                {
                    _loc1_++;
                }

                _loc2_++;
            }

            return _loc1_;
        }

        public function remove(param1: int): IItem
        {
            var _loc2_: IItem = this._items.getValue(param1);
            if (_loc2_)
            {
                this._items.remove(param1);
                this.updateThumbData();
                return _loc2_;
            }

            return null;
        }

        public function getItem(param1: int): IItem
        {
            return this._items.getValue(param1);
        }

        public function replaceItem(param1: int, param2: IItem): void
        {
            this._items.add(param1, param2);
            this.updateThumbData();
        }

        public function getUnlockedCount(): int
        {
            var _loc1_: IItem;
            if (this.category == FurniCategory.var_597)
            {
                return this.getTotalCount();
            }

            var _loc2_: int;
            var _loc3_: int;
            while (_loc3_ < this._items.length)
            {
                _loc1_ = this._items.getWithIndex(_loc3_);
                if (!_loc1_.locked)
                {
                    _loc2_++;
                }

                _loc3_++;
            }

            return _loc2_;
        }

        private function updateThumbData(): void
        {
            var _loc6_: BitmapData;
            var _loc7_: BitmapData;
            if (this._window == null)
            {
                return;
            }

            if (this._window.disposed)
            {
                return;
            }

            var _loc1_: IBitmapWrapperWindow = this._window.findChildByName("bitmap") as IBitmapWrapperWindow;
            var _loc2_: int = this.getUnlockedCount();
            if (_loc1_)
            {
                if (this._iconImage != null)
                {
                    _loc6_ = this._iconImage;
                    _loc7_ = _loc1_.bitmap ? _loc1_.bitmap : new BitmapData(_loc1_.width, _loc1_.height);
                    _loc7_.fillRect(_loc7_.rect, 0);
                    _loc7_.copyPixels(_loc6_, _loc6_.rect, new Point(_loc7_.width / 2 - _loc6_.width / 2, _loc7_.height / 2 - _loc6_.height / 2));
                    _loc1_.bitmap = _loc7_;
                }

                if (_loc2_ <= 0)
                {
                    this._window.blend = this.BLEND_GROUP_LOCKED;
                    _loc1_.blend = this.BLEND_GROUP_LOCKED;
                }
                else
                {
                    this._window.blend = this.BLEND_GROUP_UNLOCKED;
                    _loc1_.blend = this.BLEND_GROUP_UNLOCKED;
                }

            }

            if (this.isSelected)
            {
                this._background.color = this.BACKGROUND_GROUP_SELECTED;
            }
            else
            {
                this._background.color = this.BACKGROUND_GROUP_DESELECTED;
            }

            var _loc3_: IWindow = this._window.findChildByName("number_container");
            var _loc4_: ITextWindow = this._window.findChildByName("number") as ITextWindow;
            if (_loc3_)
            {
                _loc3_.visible = _loc2_ > 1;
            }

            if (_loc4_)
            {
                _loc4_.text = String(_loc2_);
            }

            var _loc5_: IBitmapWrapperWindow = this._window.findChildByName("recyclable_container") as IBitmapWrapperWindow;
            if (_loc5_)
            {
                if (this._isRecyclable && this.getRecyclableCount() > 0)
                {
                    _loc5_.bitmap = this._recyclableIcon;
                    _loc5_.visible = true;
                }
                else
                {
                    _loc5_.visible = false;
                }

            }

            this._window.invalidate();
        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            if (this._iconCallbackId != param1)
            {
                return;
            }

            this._iconImage = param2;
            this.updateThumbData();
        }

    }
}
