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

        private static const ENTITY_XML: String = "entity_xml";
        private static const FACEBOOK_PIECE_XML: String = "facebook_piece_xml";
        private static const CONTROLS_PIECE_XML: String = "controls_piece_xml";
        private static const LIST: String = "list";
        private static const HEADER: String = "header";
        private static const FACEBOOK: String = "facebook";
        private static const CONTROLS: String = "controls";
        private static const CANVAS: String = "canvas";
        private static const NAME: String = "name";
        private static const BUTTON_MESSAGE: String = "btn_message";
        private static const BUTTON_VISIT: String = "btn_visit";
        private static const ICON: String = "icon";
        
        private static const POOL: Array = [];
        private static const CONTAINER_POOL: Array = [];

        private var _friend: IFriendEntity;

        public static function allocate(entity: IFriendEntity): FriendEntityTab
        {
            var friendEntity: FriendEntityTab = POOL.length > 0 ? POOL.pop() : new FriendEntityTab();
            
            friendEntity._recycled = false;
            friendEntity.friend = entity;
            
            return friendEntity;
        }

        private static function purgeEntityPieces(parent: IWindowContainer): void
        {
            var container: IWindowContainer;
            var itemList: IItemListWindow = IItemListWindow(parent.getChildByName(LIST));
            
            container = (itemList.getListItemByName(FACEBOOK) as IWindowContainer);
            
            if (container != null)
            {
                container.dispose();
            }

            container = (itemList.getListItemByName(CONTROLS) as IWindowContainer);
            
            if (container != null)
            {
                container.dispose();
            }

            parent.height = INITIAL_HEIGHT;
            parent.y = 0;
        }

        public function set friend(friend: IFriendEntity): void
        {
            this._friend = friend;

            this.refresh();
        }

        public function get friend(): IFriendEntity
        {
            return this._friend;
        }

        override public function recycle(): void
        {
            if (!disposed)
            {
                if (!_recycled)
                {
                    if (_window)
                    {
                        this.releaseEntityWindow(_window);
                        _window = null;
                    }

                    this._friend = null;
                    _recycled = true;
                    POOL.push(this);
                }

            }

        }

        override public function select(): void
        {
            var itemList: IItemListWindow;
            var container: IWindowContainer;
            var bitmapWindow: IBitmapWrapperWindow;
            var button: IWindow;

            if (!selected)
            {
                itemList = IItemListWindow(window.getChildByName(LIST));
                if (this.friend.realName != null && this.friend.realName != "")
                {
                    container = (WINDOW_MANAGER.buildFromXML(ASSETS.getAssetByName(FACEBOOK_PIECE_XML).content as XML) as IWindowContainer);
                    
                    container.name = FACEBOOK;
                    container.getChildByName(NAME).caption = this.friend.realName;
                    
                    TEXT_CROPPER.crop(container.getChildByName(NAME) as ITextWindow);
                    
                    bitmapWindow = IBitmapWrapperWindow(container.getChildByName(ICON));
                    
                    bitmapWindow.bitmap = (ASSETS.getAssetByName(bitmapWindow.bitmapAssetName).content as BitmapData);
                    bitmapWindow.width = bitmapWindow.bitmap.width;
                    bitmapWindow.height = bitmapWindow.bitmap.height;
                    
                    itemList.addListItem(container);
                }

                if (this.friend.online)
                {
                    container = (WINDOW_MANAGER.buildFromXML(ASSETS.getAssetByName(CONTROLS_PIECE_XML).content as XML) as IWindowContainer);
                    
                    container.name = CONTROLS;
                    
                    button = container.getChildByName(BUTTON_MESSAGE);
                    
                    if (button != null)
                    {
                        button.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onControlClick);
                    }

                    button = container.getChildByName(BUTTON_VISIT);
                    
                    if (button != null)
                    {
                        if (this.friend.allowFollow)
                        {
                            button.visible = true;
                            button.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onControlClick);
                        }
                        else
                        {
                            button.visible = false;
                        }

                    }

                    itemList.addListItem(container);
                }

                window.height = itemList.height;
                window.y = INITIAL_HEIGHT - window.height;

                super.select();
            }

        }

        override public function deselect(): void
        {
            if (selected)
            {
                if (_window)
                {
                    purgeEntityPieces(_window);
                }

                super.deselect();
            }

        }

        protected function refresh(): void
        {
            var container: IWindowContainer;
            var bitmapWindow: IBitmapWrapperWindow;

            if (!_window)
            {
                _window = this.allocateEntityWindow();
            }

            if (this._friend)
            {
                _window.id = this._friend.id;

                container = (IItemListWindow(_window.getChildByName(LIST))
                        .getListItemByName(HEADER) as IWindowContainer);

                container.findChildByName(NAME).caption = this._friend.name;

                TEXT_CROPPER.crop(container.getChildByName(NAME) as ITextWindow);
                
                bitmapWindow = IBitmapWrapperWindow(container.findChildByName(CANVAS));
                
                bitmapWindow.bitmap = FRIEND_BAR_VIEW.getAvatarFaceBitmap(this._friend.figure);
                bitmapWindow.width = bitmapWindow.bitmap.width;
                bitmapWindow.height = bitmapWindow.bitmap.height;
            }

        }

        private function allocateEntityWindow(): IWindowContainer
        {
            var container: IWindowContainer = CONTAINER_POOL.length > 0
                    ? CONTAINER_POOL.pop()
                    : (WINDOW_MANAGER.buildFromXML(ASSETS.getAssetByName(ENTITY_XML).content as XML) as IWindowContainer);

            var bitmapWindow: IBitmapWrapperWindow = IBitmapWrapperWindow(container.findChildByName(CANVAS));
            
            container.x = 0;
            container.y = 0;
            container.width = INITIAL_WIDTH;
            container.height = INITIAL_HEIGHT;
            container.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
            
            bitmapWindow.disposesBitmap = true;
            
            return container;
        }

        private function releaseEntityWindow(container: IWindowContainer): void
        {
            var bitmapWindow: IBitmapWrapperWindow;
            
            if (container != null && !container.disposed)
            {
                container.procedure = null;
                container.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                container.width = INITIAL_WIDTH;
                container.height = INITIAL_HEIGHT;
             
                bitmapWindow = IBitmapWrapperWindow(container.findChildByName(CANVAS));
             
                bitmapWindow.bitmap = null;
             
                purgeEntityPieces(container);
             
                if (CONTAINER_POOL.indexOf(container) == -1)
                {
                    CONTAINER_POOL.push(container);
                }

            }

        }

        private function onControlClick(event: WindowMouseEvent): void
        {
            if (!disposed && !recycled)
            {
                switch (event.window.name)
                {
                    case BUTTON_MESSAGE:
                        if (FRIEND_BAR_DATA && this._friend)
                        {
                            FRIEND_BAR_DATA.startConversation(this._friend.id);
                        }

                        return;

                    case BUTTON_VISIT:
                        if (FRIEND_BAR_DATA && this._friend)
                        {
                            FRIEND_BAR_DATA.followToRoom(this._friend.id);
                        }

                        return;
                }

            }

        }

        private function onMouseClick(event: WindowMouseEvent): void
        {
            if (!disposed && !recycled)
            {
                if (selected)
                {
                    FRIEND_BAR_VIEW.deSelect();
                }
                else
                {
                    FRIEND_BAR_VIEW.selectFriendEntity(this._friend.id);
                }

            }

        }

    }
}
