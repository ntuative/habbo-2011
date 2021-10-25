package com.sulake.habbo.friendbar
{

    import com.sulake.core.runtime.ComponentContext;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendbar.data.HabboFriendBarData;
    import com.sulake.habbo.friendbar.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.HabboFriendBarView;
    import com.sulake.habbo.friendbar.iid.IIDHabboFriendBarView;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;

    public class HabboFriendBar extends ComponentContext
    {

        private var _configuration: IHabboConfigurationManager;
        private var _findFriendsEnabled: Boolean = false;

        public function HabboFriendBar(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
        }

        public function get findFriendsEnabled(): Boolean
        {
            return this._findFriendsEnabled;
        }

        override public function dispose(): void
        {
            if (!disposed)
            {
                if (this._configuration)
                {
                    this._configuration.release(new IIDHabboConfigurationManager());

                    this._configuration = null;
                }
            }
        }

        private function onConfigurationAvailable(param1: IID, param2: IUnknown): void
        {
            this._configuration = (param2 as IHabboConfigurationManager);
            this._findFriendsEnabled = this._configuration.getKey("friend_bar.helper.friend_finding.enabled") == "true";
            
            var friendBarEnabled: Boolean = this._configuration.getKey("friendbar.enabled") == "true";
            
            if (friendBarEnabled)
            {
                attachComponent(new HabboFriendBarData(this, 0, assets), [new IIDHabboFriendBarData()]);
                attachComponent(new HabboFriendBarView(this, 0, assets), [new IIDHabboFriendBarView()]);
            }

        }

    }
}
