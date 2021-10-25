package com.sulake.habbo.notifications
{

    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.BitmapData;

    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.tracking.ConversionPointMessageComposer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetAchievementShareIdComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class AchievementNotification
    {

        private const var_3884: String = "badge_bg_001_png";
        private const var_3885: String = "achievement_bg_001_png";

        private var var_2925: String;
        private var var_3886: int;
        private var var_2924: int;
        private var var_3259: int;
        private var var_3261: int;
        private var var_2927: int;
        private var var_2928: int;
        private var _window: IFrameWindow;
        private var var_2847: ISessionDataManager;
        private var var_1364: IHabboLocalizationManager;
        private var _assets: IAssetLibrary;
        private var _communication: IHabboCommunicationManager;
        private var var_3887: String;
        private var var_3888: String;
        private var var_3889: String;
        private var var_3890: String;
        private var _desc: String;
        private var var_3891: String;
        private var _feedTitleFb: String;

        public function AchievementNotification(param1: String, param2: int, param3: int, param4: int, param5: int, param6: int, param7: int, param8: IAssetLibrary, param9: IHabboWindowManager, param10: IHabboLocalizationManager, param11: IHabboConfigurationManager, param12: IHabboCommunicationManager, param13: ISessionDataManager)
        {
            if (!param8 || !param9 || !param10 || !param11 || !param13)
            {
                return;
            }

            this.var_2925 = param1;
            this.var_3886 = param2;
            this.var_2924 = param3;
            this.var_3259 = param4;
            this.var_3261 = param7;
            this.var_2927 = param5;
            this.var_2928 = param6;
            this.var_1364 = param10;
            this._assets = param8;
            this.var_2847 = param13;
            this._communication = param12;
            param13.events.addEventListener(BadgeImageReadyEvent.var_101, this.onBadgeImageReady);
            var _loc14_: XmlAsset = param8.getAssetByName("achievement_notification_xml") as XmlAsset;
            if (_loc14_ == null)
            {
                return;
            }

            this._window = (param9.buildFromXML(_loc14_.content as XML) as IFrameWindow);
            if (this._window == null)
            {
                return;
            }

            this._window.procedure = this.eventHandler;
            this._window.center();
            this.var_3887 = this.var_1364.getBadgeName(this.var_2925);
            this.var_3888 = this.var_1364.getBadgeDesc(this.var_2925);
            this.var_3889 = this.var_1364.getAchievementNameForFacebook(this.var_2925, this.var_2847.userName, this.var_2847.realName, this.var_2924);
            this.var_3890 = this.var_1364.getAchievementDescForFacebook(this.var_2925, this.var_2847.userName, this.var_2847.realName, this.var_2924);
            this._desc = this.registerTextParameters("notifications.text.achievement");
            this.var_3891 = this.registerTextParameters("notifications.text.achievement_facebook");
            this._feedTitleFb = this.registerTextParameters("notifications.text.achievement_facebook_title");
            this.var_1364.registerParameter("notifications.text.achievement.achievement_points", "achievement_points", this.var_3259.toString());
            this.var_1364.registerParameter("notifications.achievement.bonus.value", "bonus_points", this.var_3261.toString());
            this.var_1364.registerParameter("notifications.achievement.no_facebook", "bonus_points", this.var_3261.toString());
            var _loc15_: IWindow = this._window.findChildByName("level_reward_points");
            var _loc16_: String = "notifications.text.achievement.reward." + this.var_2928;
            var _loc17_: String = this.var_2928 == 0 ? "pixels" : "activitypoints";
            this.var_1364.registerParameter(_loc16_, _loc17_, "" + this.var_2927);
            _loc15_.caption = this.var_1364.getKey(_loc16_);
            this._window.findChildByName("achievement_info").caption = this._desc;
            this.setBadge(param13.getBadgeImage(param1), this.var_3884);
            var _loc18_: BitmapData = (param8.getAssetByName(this.var_3885) as BitmapDataAsset).content as BitmapData;
            var _loc19_: IBitmapWrapperWindow = this._window.findChildByName("achievement_bg") as IBitmapWrapperWindow;
            _loc19_.bitmap = new BitmapData(_loc19_.width, _loc19_.height, true, 0);
            _loc19_.bitmap.copyPixels(_loc18_, _loc18_.rect, new Point(0, _loc19_.height - _loc18_.height), null, null, true);
            var _loc20_: Boolean;
            if (param11.keyExists("facebook.user"))
            {
                _loc20_ = true;
            }

            var _loc21_: Boolean = true;
            if (param11.getKey("achievement.post.enabled", "1") == "0")
            {
                _loc21_ = false;
            }

            var _loc22_: IItemListWindow = this._window.findChildByName("view_items") as IItemListWindow;
            var _loc23_: IWindowContainer = this._window.findChildByName("bonus_container") as IWindowContainer;
            var _loc24_: IWindowContainer = this._window.findChildByName("regular_ok_container") as IWindowContainer;
            var _loc25_: IWindowContainer = this._window.findChildByName("facebook_nag_container") as IWindowContainer;
            var _loc26_: IConnection = this._communication.getHabboMainConnection(null);
            if (this.var_3261 <= 0 || !_loc21_)
            {
                _loc22_.removeListItem(_loc23_);
                _loc22_.removeListItem(_loc25_);
                _loc26_.send(new ConversionPointMessageComposer("Achievements", this.var_2925, "client.show.no_post"));
            }
            else
            {
                _loc22_.removeListItem(_loc24_);
                if (_loc20_)
                {
                    _loc22_.removeListItem(_loc25_);
                    _loc26_.send(new ConversionPointMessageComposer("Achievements", this.var_2925, "client.show.post"));
                }
                else
                {
                    _loc22_.removeListItem(_loc23_);
                    _loc26_.send(new ConversionPointMessageComposer("Achievements", this.var_2925, "client.show.no_fb"));
                }

            }

            var _loc27_: int = 32;
            this._window.height = _loc22_.height + _loc27_;
            this._window.header.controls.visible = false;
        }

        private function registerTextParameters(param1: String): String
        {
            this.var_1364.registerParameter(param1, "badge_name", this.var_3887);
            this.var_1364.registerParameter(param1, "badge_desc", this.var_3888);
            this.var_1364.registerParameter(param1, "badge_name_fb", this.var_3889);
            this.var_1364.registerParameter(param1, "badge_desc_fb", this.var_3890);
            this.var_1364.registerParameter(param1, "level", this.var_2924.toString());
            this.var_1364.registerParameter(param1, "name", this.var_2847.userName);
            return this.var_1364.registerParameter(param1, "realname", this.var_2847.realName);
        }

        public function dispose(): void
        {
            if (this.var_2847 != null)
            {
                this.var_2847.events.removeEventListener(BadgeImageReadyEvent.var_101, this.onBadgeImageReady);
                this.var_2847 = null;
            }

            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }

            this.var_1364 = null;
            this._assets = null;
            this._communication = null;
        }

        private function setText(param1: String, param2: String): void
        {
            if (this._window == null)
            {
                return;
            }

            var _loc3_: ITextWindow = this._window.findChildByName(param1) as ITextWindow;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.text = param2;
        }

        private function setImage(param1: String, param2: BitmapData): void
        {
            if (this._window == null)
            {
                return;
            }

            var _loc3_: IBitmapWrapperWindow = this._window.findChildByName(param1) as IBitmapWrapperWindow;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.bitmap = param2;
        }

        private function setBadge(param1: BitmapData, param2: String): void
        {
            var _loc3_: BitmapData = (this._assets.getAssetByName(param2) as BitmapDataAsset).content as BitmapData;
            var _loc4_: BitmapData = _loc3_.clone();
            _loc4_.copyPixels(param1, param1.rect, new Point((_loc3_.width - param1.width) / 2, (_loc3_.height - param1.height) / 2), null, null, true);
            this.setImage("badge_image", _loc4_);
        }

        private function onBadgeImageReady(param1: BadgeImageReadyEvent): void
        {
            if (param1 == null)
            {
                return;
            }

            if (param1.badgeId != this.var_2925)
            {
                return;
            }

            this.setBadge(param1.badgeImage, this.var_3884);
        }

        public function requestPostDialog(param1: String): void
        {
            HabboWebTools.facebookAchievementPost(this.var_2925, this._feedTitleFb, this.var_3891, param1);
        }

        private function eventHandler(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            var _loc3_: IConnection = this._communication.getHabboMainConnection(null);
            switch (param2.name)
            {
                case "post_to_facebook":
                    _loc3_.send(new GetAchievementShareIdComposer(this.var_3886));
                    _loc3_.send(new ConversionPointMessageComposer("Achievements", this.var_2925, "client.start_post"));
                    this._window.visible = false;
                    return;
                case "close":
                    _loc3_.send(new ConversionPointMessageComposer("Achievements", this.var_2925, "client.skip_post"));
                    this.dispose();
                    return;
            }

        }

    }
}
