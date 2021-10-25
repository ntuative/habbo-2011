package com.sulake.habbo.friendbar.view.tabs
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.display.BitmapData;

    import com.sulake.core.window.IWindow;

    public class AddFriendsEntityTab extends Tab
    {

        private static const var_3385: String = "icon";
        private static const TEXT: String = "text";
        private static const var_3387: String = "title";
        private static const BUTTON: String = "button";
        private static const var_3384: String = "addFriendsEntityTabXML";
        private static const var_3386: String = "friends_icon_png";

        public function AddFriendsEntityTab()
        {
            _window = (WINDOW_MANAGER.buildFromXML(ASSETS.getAssetByName(var_3384).content as XML) as IWindowContainer);
            _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
            var _loc1_: IBitmapWrapperWindow = _window.findChildByName(var_3385) as IBitmapWrapperWindow;
            _loc1_.disposesBitmap = false;
            _loc1_.bitmap = (ASSETS.getAssetByName(var_3386).content as BitmapData);
            var _loc2_: IWindow = _window.findChildByName(BUTTON);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
            var _loc3_: IWindow = _window.findChildByName(TEXT);
            _loc3_.visible = false;
        }

        override public function select(): void
        {
            if (!selected)
            {
                _window.y = _window.y - (_window.height - INITIAL_HEIGHT);
                _window.findChildByName(TEXT).visible = true;
                super.select();
            }

        }

        override public function deselect(): void
        {
            if (selected)
            {
                _window.y = _window.y + (_window.height - INITIAL_HEIGHT);
                _window.findChildByName(TEXT).visible = false;
                super.deselect();
            }

        }

        override public function recycle(): void
        {
            dispose();
        }

        private function onMouseClick(param1: WindowMouseEvent): void
        {
            if (!disposed && !recycled)
            {
                if (selected)
                {
                    FRIEND_BAR_VIEW.deSelect();
                }
                else
                {
                    FRIEND_BAR_VIEW.selectTab(this);
                }

            }

        }

        private function onButtonClick(param1: WindowMouseEvent): void
        {
            FRIEND_BAR_DATA.findNewFriends();
            this.deselect();
        }

    }
}
