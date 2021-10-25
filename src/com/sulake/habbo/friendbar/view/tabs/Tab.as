package com.sulake.habbo.friendbar.view.tabs
{

    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.core.window.IWindowContainer;

    public class Tab implements ITab
    {

        public static var INITIAL_WIDTH: int = 127;
        public static var INITIAL_HEIGHT: int = 40;
        public static var FRIEND_BAR_DATA: IHabboFriendBarData;
        public static var FRIEND_BAR_VIEW: IHabboFriendBarView;
        public static var ASSETS: IAssetLibrary;
        public static var WINDOW_MANAGER: IHabboWindowManager;
        public static var TEXT_CROPPER: TextCropper;

        protected var _window: IWindowContainer;
        protected var _recycled: Boolean;
        private var _selected: Boolean;
        private var _disposed: Boolean;

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function get selected(): Boolean
        {
            return this._selected;
        }

        public function get recycled(): Boolean
        {
            return this._recycled;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function select(): void
        {
            this._selected = true;
        }

        public function deselect(): void
        {
            this._selected = false;
        }

        public function recycle(): void
        {
            this._recycled = true;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._window)
                {
                    this._window.dispose();
                    this._window = null;
                }

                this._disposed = true;
            }

        }

    }
}
