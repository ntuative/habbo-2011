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

        public static var var_622:int = 127;
        public static var var_623:int = 40;
        public static var var_1391:IHabboFriendBarData;
        public static var var_1392:IHabboFriendBarView;
        public static var var_1393:IAssetLibrary;
        public static var var_1394:IHabboWindowManager;
        public static var var_1395:TextCropper;

        protected var _window:IWindowContainer;
        protected var var_2223:Boolean;
        private var _selected:Boolean;
        private var _disposed:Boolean;

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function get recycled():Boolean
        {
            return (this.var_2223);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function select():void
        {
            this._selected = true;
        }

        public function deselect():void
        {
            this._selected = false;
        }

        public function recycle():void
        {
            this.var_2223 = true;
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this._window)
                {
                    this._window.dispose();
                    this._window = null;
                };
                this._disposed = true;
            };
        }

    }
}