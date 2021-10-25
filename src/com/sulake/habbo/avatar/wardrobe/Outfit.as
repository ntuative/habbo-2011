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

        private var _controller: HabboAvatarEditor;
        private var _figure: String;
        private var _gender: String;
        private var _view: OutfitView;
        private var _disposed: Boolean;

        public function Outfit(habboAvatarEditor: HabboAvatarEditor, figure: String, gender: String)
        {
            this._controller = habboAvatarEditor;
            this._view = new OutfitView(habboAvatarEditor.windowManager, habboAvatarEditor.assets, figure != "");

            switch (gender)
            {
                case FigureData.MALE:
                case "m":
                case "M":
                    gender = FigureData.MALE;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    gender = FigureData.FEMALE;
                    break;
            }


            this._figure = figure;
            this._gender = gender;
            this.update();
        }

        public function dispose(): void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            }

            this._figure = null;
            this._gender = null;
            this._disposed = true;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function update(): void
        {
            var _loc2_: BitmapData;
            var _loc1_: IAvatarImage = this._controller.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType.var_305, this._gender, this);
            if (_loc1_)
            {
                _loc1_.setDirection(AvatarSetType.var_136, int(FigureData.var_1639));
                _loc2_ = _loc1_.getImage(AvatarSetType.var_136, true);
                if (this._view)
                {
                    this._view.udpate(_loc2_);
                }

                _loc1_.dispose();
            }

        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get gender(): String
        {
            return this._gender;
        }

        public function get view(): OutfitView
        {
            return this._view;
        }

        public function avatarImageReady(param1: String): void
        {
            this.update();
        }

    }
}
