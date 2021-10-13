package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.enum.HabboIconType;

    public class AvatarEditorGridColorItem 
    {

        private var var_2446:IAvatarEditorCategoryModel;
        private var _window:IWindowContainer;
        private var var_2447:IPartColor;
        private var _isSelected:Boolean = false;
        private var var_2448:BitmapData;
        private var var_2449:BitmapData;
        private var var_2450:BitmapData;

        public function AvatarEditorGridColorItem(param1:IWindowContainer, param2:IAvatarEditorCategoryModel, param3:IPartColor)
        {
            this.var_2446 = param2;
            this._window = param1;
            this._window.background = true;
            this.var_2447 = param3;
            var _loc4_:BitmapDataAsset = (param2.controller.assets.getAssetByName("editor_clr_40x32_1") as BitmapDataAsset);
            this.var_2448 = (_loc4_.content as BitmapData);
            var _loc5_:BitmapDataAsset = (param2.controller.assets.getAssetByName("editor_clr_40x32_2") as BitmapDataAsset);
            this.var_2449 = (_loc5_.content as BitmapData);
            var _loc6_:BitmapDataAsset = (param2.controller.assets.getAssetByName("editor_clr_40x32_3") as BitmapDataAsset);
            this.var_2450 = (_loc6_.content as BitmapData);
            this.updateThumbData();
        }

        public function dispose():void
        {
            this.var_2446 = null;
            if (this._window != null)
            {
                if (!this._window.disposed)
                {
                    this._window.dispose();
                };
            };
            this._window = null;
            this.var_2447 = null;
            this.var_2448 = null;
            this.var_2449 = null;
            this.var_2450 = null;
        }

        public function get view():IWindowContainer
        {
            return (this._window);
        }

        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }

        public function set isSelected(param1:Boolean):void
        {
            this._isSelected = param1;
            this.updateThumbData();
        }

        private function updateThumbData():void
        {
            var _loc5_:BitmapData;
            if (this._window == null)
            {
                return;
            };
            if (this._window.disposed)
            {
                return;
            };
            var _loc1_:IBitmapWrapperWindow = (this._window.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
            if (_loc1_ != null)
            {
                _loc1_.bitmap = new BitmapData(this.var_2448.width, this.var_2448.height, true, 0);
                _loc1_.bitmap.copyPixels(this.var_2448, this.var_2448.rect, new Point(0, 0));
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.bitmap = new BitmapData(this.var_2449.width, this.var_2449.height, true, 0);
                _loc5_ = this.var_2449.clone();
                _loc5_.colorTransform(_loc5_.rect, this.var_2447.colorTransform);
                _loc2_.bitmap.copyPixels(_loc5_, _loc5_.rect, new Point(0, 0));
            };
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
            if (_loc3_ != null)
            {
                if (this._isSelected)
                {
                    _loc3_.bitmap = new BitmapData(this.var_2450.width, this.var_2450.height, true, 0xFFFFFF);
                    _loc3_.bitmap.copyPixels(this.var_2450, this.var_2450.rect, new Point(0, 0), null, null, true);
                    _loc3_.visible = true;
                }
                else
                {
                    _loc3_.visible = false;
                };
            };
            var _loc4_:IIconWindow = (this._window.findChildByTag("CLUB_ICON") as IIconWindow);
            if (_loc4_)
            {
                if (this.var_2447)
                {
                    switch (this.var_2447.clubLevel)
                    {
                        case HabboClubLevelEnum.var_255:
                            _loc4_.visible = false;
                            break;
                        case HabboClubLevelEnum.var_256:
                            _loc4_.style = HabboIconType.var_143;
                            _loc4_.visible = true;
                            break;
                        case HabboClubLevelEnum.var_122:
                            _loc4_.style = HabboIconType.var_144;
                            _loc4_.visible = true;
                            break;
                    };
                }
                else
                {
                    _loc4_.visible = false;
                };
            };
        }

        public function get partColor():IPartColor
        {
            return (this.var_2447);
        }

    }
}