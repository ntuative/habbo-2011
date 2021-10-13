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

        private var var_2063:IHabboConfigurationManager;
        private var var_3411:Boolean = false;

        public function HabboFriendBar(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
        }

        public function get findFriendsEnabled():Boolean
        {
            return (this.var_3411);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_2063)
                {
                    this.var_2063.release(new IIDHabboConfigurationManager());
                    this.var_2063 = null;
                };
            };
        }

        private function onConfigurationAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_2063 = (param2 as IHabboConfigurationManager);
            var _loc3_:* = (this.var_2063.getKey("friendbar.enabled") == "true");
            this.var_3411 = (this.var_2063.getKey("friend_bar.helper.friend_finding.enabled") == "true");
            if (_loc3_)
            {
                attachComponent(new HabboFriendBarData(this, 0, assets), [new IIDHabboFriendBarData()]);
                attachComponent(new HabboFriendBarView(this, 0, assets), [new IIDHabboFriendBarView()]);
            };
        }

    }
}