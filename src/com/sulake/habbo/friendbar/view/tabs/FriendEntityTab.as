package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class FriendEntityTab extends Tab 
    {

        private static const var_3388:String = "entity_xml";
        private static const var_3389:String = "facebook_piece_xml";
        private static const var_3390:String = "controls_piece_xml";
        private static const var_1386:String = "list";
        private static const var_186:String = "header";
        private static const var_3391:String = "facebook";
        private static const var_3392:String = "controls";
        private static const var_1396:String = "canvas";
        private static const var_341:String = "name";
        private static const var_3393:String = "btn_message";
        private static const var_3394:String = "btn_visit";
        private static const var_3385:String = "icon";
        private static const POOL:Array = [];
        private static const var_3395:Array = [];

        private var var_3396:IFriendEntity;

        public static function allocate(param1:IFriendEntity):FriendEntityTab
        {
            var _loc2_:FriendEntityTab = ((POOL.length > 0) ? POOL.pop() : new (FriendEntityTab)());
            _loc2_.var_2223 = false;
            _loc2_.friend = param1;
            return (_loc2_);
        }

        private static function purgeEntityPieces(param1:IWindowContainer):void
        {
            var _loc3_:IWindowContainer;
            var _loc2_:IItemListWindow = IItemListWindow(param1.getChildByName(var_1386));
            _loc3_ = (_loc2_.getListItemByName(var_3391) as IWindowContainer);
            if (_loc3_)
            {
                _loc3_.dispose();
            };
            _loc3_ = (_loc2_.getListItemByName(var_3392) as IWindowContainer);
            if (_loc3_)
            {
                _loc3_.dispose();
            };
            param1.height = var_623;
            param1.y = 0;
        }

        public function set friend(param1:IFriendEntity):void
        {
            this.var_3396 = param1;
            this.refresh();
        }

        public function get friend():IFriendEntity
        {
            return (this.var_3396);
        }

        override public function recycle():void
        {
            if (!disposed)
            {
                if (!var_2223)
                {
                    if (_window)
                    {
                        this.releaseEntityWindow(_window);
                        _window = null;
                    };
                    this.var_3396 = null;
                    var_2223 = true;
                    POOL.push(this);
                };
            };
        }

        override public function select():void
        {
            var _loc1_:IItemListWindow;
            var _loc2_:IWindowContainer;
            var _loc3_:IBitmapWrapperWindow;
            var _loc4_:IWindow;
            if (!selected)
            {
                _loc1_ = IItemListWindow(window.getChildByName(var_1386));
                if (((!(this.friend.realName == null)) && (!(this.friend.realName == ""))))
                {
                    _loc2_ = (var_1394.buildFromXML((var_1393.getAssetByName(var_3389).content as XML)) as IWindowContainer);
                    _loc2_.name = var_3391;
                    _loc2_.getChildByName(var_341).caption = this.friend.realName;
                    var_1395.crop((_loc2_.getChildByName(var_341) as ITextWindow));
                    _loc3_ = IBitmapWrapperWindow(_loc2_.getChildByName(var_3385));
                    _loc3_.bitmap = (var_1393.getAssetByName(_loc3_.bitmapAssetName).content as BitmapData);
                    _loc3_.width = _loc3_.bitmap.width;
                    _loc3_.height = _loc3_.bitmap.height;
                    _loc1_.addListItem(_loc2_);
                };
                if (this.friend.online)
                {
                    _loc2_ = (var_1394.buildFromXML((var_1393.getAssetByName(var_3390).content as XML)) as IWindowContainer);
                    _loc2_.name = var_3392;
                    _loc4_ = _loc2_.getChildByName(var_3393);
                    if (_loc4_)
                    {
                        _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onControlClick);
                    };
                    _loc4_ = _loc2_.getChildByName(var_3394);
                    if (_loc4_)
                    {
                        if (this.friend.allowFollow)
                        {
                            _loc4_.visible = true;
                            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onControlClick);
                        }
                        else
                        {
                            _loc4_.visible = false;
                        };
                    };
                    _loc1_.addListItem(_loc2_);
                };
                window.height = _loc1_.height;
                window.y = (var_623 - window.height);
                super.select();
            };
        }

        override public function deselect():void
        {
            if (selected)
            {
                if (_window)
                {
                    purgeEntityPieces(_window);
                };
                super.deselect();
            };
        }

        protected function refresh():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:IBitmapWrapperWindow;
            if (!_window)
            {
                _window = this.allocateEntityWindow();
            };
            if (this.var_3396)
            {
                _window.id = this.var_3396.id;
                _loc1_ = (IItemListWindow(_window.getChildByName(var_1386)).getListItemByName(var_186) as IWindowContainer);
                _loc1_.findChildByName(var_341).caption = this.var_3396.name;
                var_1395.crop((_loc1_.getChildByName(var_341) as ITextWindow));
                _loc2_ = IBitmapWrapperWindow(_loc1_.findChildByName(var_1396));
                _loc2_.bitmap = var_1392.getAvatarFaceBitmap(this.var_3396.figure);
                _loc2_.width = _loc2_.bitmap.width;
                _loc2_.height = _loc2_.bitmap.height;
            };
        }

        private function allocateEntityWindow():IWindowContainer
        {
            var _loc1_:IWindowContainer = ((var_3395.length > 0) ? var_3395.pop() : (var_1394.buildFromXML((var_1393.getAssetByName(var_3388).content as XML)) as IWindowContainer));
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName(var_1396));
            _loc1_.x = 0;
            _loc1_.y = 0;
            _loc1_.width = var_622;
            _loc1_.height = var_623;
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
            _loc2_.disposesBitmap = true;
            return (_loc1_);
        }

        private function releaseEntityWindow(param1:IWindowContainer):void
        {
            var _loc2_:IBitmapWrapperWindow;
            if (((param1) && (!(param1.disposed))))
            {
                param1.procedure = null;
                param1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                param1.width = var_622;
                param1.height = var_623;
                _loc2_ = IBitmapWrapperWindow(param1.findChildByName(var_1396));
                _loc2_.bitmap = null;
                purgeEntityPieces(param1);
                if (var_3395.indexOf(param1) == -1)
                {
                    var_3395.push(param1);
                };
            };
        }

        private function onControlClick(param1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                switch (param1.window.name)
                {
                    case var_3393:
                        if (((var_1391) && (this.var_3396)))
                        {
                            var_1391.startConversation(this.var_3396.id);
                        };
                        return;
                    case var_3394:
                        if (((var_1391) && (this.var_3396)))
                        {
                            var_1391.followToRoom(this.var_3396.id);
                        };
                        return;
                };
            };
        }

        private function onMouseClick(param1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                if (selected)
                {
                    var_1392.deSelect();
                }
                else
                {
                    var_1392.selectFriendEntity(this.var_3396.id);
                };
            };
        }

    }
}