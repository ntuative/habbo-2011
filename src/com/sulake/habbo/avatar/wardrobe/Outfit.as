package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class Outfit implements IOutfit, IAvatarImageListener 
    {

        private var _controller:HabboAvatarEditor;
        private var var_2534:String;
        private var var_2071:String;
        private var _view:OutfitView;
        private var var_978:Boolean;

        public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
        {
            this._controller = param1;
            this._view = new OutfitView(param1.windowManager, param1.assets, (!(param2 == "")));
            switch (param3)
            {
                case FigureData.var_517:
                case "m":
                case "M":
                    param3 = FigureData.var_517;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    param3 = FigureData.FEMALE;
                    break;
            };
            this.var_2534 = param2;
            this.var_2071 = param3;
            this.update();
        }

        public function dispose():void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_2534 = null;
            this.var_2071 = null;
            this.var_978 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function update():void
        {
            var _loc2_:BitmapData;
            var _loc1_:IAvatarImage = this._controller.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType.var_305, this.var_2071, this);
            if (_loc1_)
            {
                _loc1_.setDirection(AvatarSetType.var_136, int(FigureData.var_1639));
                _loc2_ = _loc1_.getImage(AvatarSetType.var_136, true);
                if (this._view)
                {
                    this._view.udpate(_loc2_);
                };
                _loc1_.dispose();
            };
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get gender():String
        {
            return (this.var_2071);
        }

        public function get view():OutfitView
        {
            return (this._view);
        }

        public function avatarImageReady(param1:String):void
        {
            this.update();
        }

    }
}