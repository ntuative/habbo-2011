package com.sulake.habbo.localization
{

    import com.sulake.core.localization.CoreLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    import flash.utils.Dictionary;

    import com.sulake.habbo.localization.enum.HabboLocalizationFlags;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.assets.TextAsset;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.localization.enum.LocalizationEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;

    import flash.events.Event;

    import com.sulake.iid.*;

    public class HabboLocalizationManager extends CoreLocalizationManager implements IHabboLocalizationManager
    {

        private static var var_168: String = "%";

        private var var_2063: IHabboConfigurationManager;
        private var var_3621: Boolean = false;
        private var var_3622: Dictionary = new Dictionary();
        private var var_3623: Array = [
            "I",
            "II",
            "III",
            "IV",
            "V",
            "VI",
            "VII",
            "VIII",
            "IX",
            "X",
            "XI",
            "XII",
            "XIII",
            "XIV",
            "XV",
            "XVI",
            "XVII",
            "XVIII",
            "XIX",
            "XX"
        ];

        public function HabboLocalizationManager(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null)
        {
            super(param1, param2, param3);
            this.var_3621 = (param2 & HabboLocalizationFlags.var_167) > 0;
            if (!this.var_3621)
            {
                lock();
            }

            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
            var _loc4_: TextAsset = param3.getAssetByName("default_localization") as TextAsset;
            parseLocalizationData(_loc4_.content.toString());
        }

        override public function dispose(): void
        {
            if (this.var_2063)
            {
                this.var_2063.release(new IIDHabboConfigurationManager());
                this.var_2063 = null;
            }

            super.dispose();
        }

        public function getKeyWithParams(param1: String, param2: Dictionary = null, param3: String = ""): String
        {
            var _loc4_: String = getKey(param1);
            if (param2 != null)
            {
                _loc4_ = this.fillParams(_loc4_, param2);
            }

            return _loc4_;
        }

        private function fillParams(param1: String, param2: Dictionary): String
        {
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: String;
            var _loc7_: String;
            var _loc3_: int;
            while (_loc3_ < 10)
            {
                _loc4_ = param1.indexOf(var_168);
                if (_loc4_ < 0)
                {
                    break;
                }
                _loc5_ = param1.indexOf(var_168, _loc4_ + 1);
                if (_loc5_ < 0)
                {
                    break;
                }
                _loc6_ = param1.substring(_loc4_ + 1, _loc5_);
                _loc7_ = param2[_loc6_];
                param1 = param1.replace("%" + _loc6_ + "%", _loc7_);
                _loc3_++;
            }

            return param1;
        }

        private function showKeys(param1: IAlertDialog, param2: *): void
        {
            param1.dispose();
            printNonExistingKeys();
        }

        private function onHabboConfigurationInit(param1: IID = null, param2: IUnknown = null): void
        {
            var _loc3_: String;
            var _loc4_: int;
            var _loc5_: String;
            var _loc6_: String;
            var _loc7_: String;
            var _loc8_: String;
            if (param2 != null)
            {
                this.var_2063 = (param2 as IHabboConfigurationManager);
                _loc3_ = "";
                _loc3_ = this.var_2063.getKey("url.prefix", _loc3_);
                _loc3_ = _loc3_.replace("http://", "");
                _loc3_ = _loc3_.replace("https://", "");
                super.setPredefinedUrl(_loc3_);
                if (!this.var_3621)
                {
                    if ("false" == this.var_2063.getKey("use.default.localizations", "false"))
                    {
                        _loc5_ = this.var_2063.getKey("external.texts.txt", "external_texts.txt");
                        events.addEventListener(LocalizationEvent.var_54, this.onLocalizationLoaded);
                        super.loadLocalizationFromURL(_loc5_);
                    }

                }

                _loc4_ = 1;
                while (this.var_2063.keyExists("localization." + _loc4_))
                {
                    _loc6_ = this.var_2063.getKey("localization." + _loc4_, "");
                    _loc7_ = this.var_2063.getKey("localization." + _loc4_ + ".name", "");
                    _loc8_ = this.var_2063.getKey("localization." + _loc4_ + ".url", "");
                    super.registerLocalizationDefinition(_loc6_, _loc7_, _loc8_);
                    _loc4_++;
                }

            }

        }

        public function onLocalizationLoaded(param1: Event): void
        {
            var _loc2_: String;
            events.removeEventListener(LocalizationEvent.var_54, this.onLocalizationLoaded);
            if (this.var_2063.keyExists("external.override.texts.txt"))
            {
                _loc2_ = this.var_2063.getKey("external.override.texts.txt");
                events.addEventListener(LocalizationEvent.var_54, this.onLocalizationOverrideLoaded);
                super.loadLocalizationFromURL(_loc2_);
            }
            else
            {
                unlock();
            }

        }

        public function onLocalizationOverrideLoaded(param1: Event): void
        {
            events.removeEventListener(LocalizationEvent.var_54, this.onLocalizationOverrideLoaded);
            unlock();
        }

        private function checkDefaultKeys(): void
        {
            var _loc6_: String;
            var _loc1_: TextAsset = assets.getAssetByName("keys_in_use") as TextAsset;
            var _loc2_: String = _loc1_.content.toString();
            var _loc3_: RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _loc4_: RegExp = /^\s+|\s+$/g;
            var _loc5_: Array = _loc2_.split(_loc3_);
            for each (_loc6_ in _loc5_)
            {
                if (_loc6_.substr(0, 1) != "#")
                {
                    if (_loc6_.length != 0)
                    {
                        if (getLocalization(_loc6_) == null)
                        {
                            Logger.log(_loc6_);
                        }

                    }

                }

            }

        }

        public function getAchievementDescForFacebook(param1: String, param2: String, param3: String, param4: int): String
        {
            return this.getAchievementTextForFacebook("badge_desc_fb_", param1, param2, param3, param4);
        }

        public function getAchievementNameForFacebook(param1: String, param2: String, param3: String, param4: int): String
        {
            return this.getAchievementTextForFacebook("badge_name_fb_", param1, param2, param3, param4);
        }

        private function getAchievementTextForFacebook(param1: String, param2: String, param3: String, param4: String, param5: int): String
        {
            var _loc6_: BadgeBaseAndLevel = new BadgeBaseAndLevel(param2);
            var _loc7_: String = this.getExistingKey([(param1 + param2), (param1 + _loc6_.base)]);
            registerParameter(_loc7_, "roman", this.getRomanNumeral(_loc6_.level));
            registerParameter(_loc7_, "level", param5.toString());
            registerParameter(_loc7_, "name", param3);
            registerParameter(_loc7_, "limit", "" + this.getBadgePointLimit(param2));
            return registerParameter(_loc7_, "realname", param4);
        }

        public function getAchievementName(param1: String): String
        {
            var _loc2_: BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
            var _loc3_: String = this.getExistingKey([
                                                         ("badge_name_al_" + param1),
                                                         ("badge_name_al_" + _loc2_.base),
                                                         ("badge_name_" + param1),
                                                         ("badge_name_" + _loc2_.base)
                                                     ]);
            this.registerParameter(_loc3_, "roman", this.getRomanNumeral(_loc2_.level));
            return this.getKey(_loc3_);
        }

        public function getAchievementDesc(param1: String, param2: int): String
        {
            var _loc3_: BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
            var _loc4_: String = this.getExistingKey([
                                                         ("badge_desc_al_" + param1),
                                                         ("badge_desc_al_" + _loc3_.base),
                                                         ("badge_desc_" + param1),
                                                         ("badge_desc_" + _loc3_.base)
                                                     ]);
            this.registerParameter(_loc4_, "limit", "" + param2);
            return this.getKey(_loc4_);
        }

        public function getBadgeName(param1: String): String
        {
            var _loc2_: BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
            var _loc3_: String = this.getExistingKey([("badge_name_" + param1), ("badge_name_" + _loc2_.base)]);
            this.registerParameter(_loc3_, "roman", this.getRomanNumeral(_loc2_.level));
            return this.getKey(_loc3_);
        }

        public function getBadgeDesc(param1: String): String
        {
            var _loc2_: BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
            var _loc3_: String = this.getExistingKey([("badge_desc_" + param1), ("badge_desc_" + _loc2_.base)]);
            this.registerParameter(_loc3_, "limit", "" + this.getBadgePointLimit(param1));
            return this.getKey(_loc3_);
        }

        public function setBadgePointLimit(param1: String, param2: int): void
        {
            this.var_3622[param1] = param2;
        }

        private function getBadgePointLimit(param1: String): int
        {
            return this.var_3622[param1];
        }

        private function getExistingKey(param1: Array): String
        {
            var _loc2_: String;
            var _loc3_: String;
            for each (_loc2_ in param1)
            {
                _loc3_ = this.getKey(_loc2_);
                if (_loc3_ != "")
                {
                    return _loc2_;
                }

            }

            return param1[0];
        }

        private function getRomanNumeral(param1: int): String
        {
            return this.var_3623[Math.max(0, param1 - 1)];
        }

    }
}
