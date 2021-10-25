package com.sulake.habbo.avatar.wardrobe
{

    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.assets.XmlAsset;

    import flash.display.BitmapData;

    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    import flash.geom.Matrix;

    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class WardrobeSlot implements IOutfit, IAvatarImageListener
    {

        private var _controller: HabboAvatarEditor;
        private var _figure: String;
        private var _gender: String;
        private var var_2536: Boolean;
        private var _view: IWindowContainer;
        private var var_2537: IBitmapWrapperWindow;
        private var _id: int;
        private var _disposed: Boolean;

        public function WardrobeSlot(param1: HabboAvatarEditor, param2: int, param3: Boolean, param4: String = null, param5: String = null)
        {
            this._controller = param1;
            this._id = param2;
            this.createView();
            this.update(param4, param5, param3);
        }

        public function get id(): int
        {
            return this._id;
        }

        public function update(param1: String, gender: String, param3: Boolean): void
        {
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

            this._figure = param1;
            this._gender = gender;
            this.var_2536 = param3;
            this.updateView();
        }

        private function createView(): void
        {
            var _loc1_: XmlAsset = this._controller.assets.getAssetByName("wardrobe_slot") as XmlAsset;
            if (!_loc1_)
            {
                return;
            }

            this._view = (this._controller.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer);
            this._view.procedure = this.eventHandler;
            this._view.visible = false;
            this.var_2537 = (this._view.findChildByName("image") as IBitmapWrapperWindow);
        }

        public function dispose(): void
        {
            this._controller = null;
            this._figure = null;
            this._gender = null;
            this.var_2537 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            }

            this._disposed = true;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function updateView(): void
        {
            var _loc1_: BitmapData;
            var _loc5_: IAvatarImage;
            var _loc6_: BitmapDataAsset;
            var _loc7_: int;
            var _loc8_: int;
            var _loc2_: Boolean = true;
            if (this._figure && this.var_2536)
            {
                _loc5_ = this._controller.avatarRenderManager.createAvatarImage(this.figure, AvatarScaleType.var_305, this._gender, this);
                if (_loc5_)
                {
                    _loc5_.setDirection(AvatarSetType.var_136, parseInt(FigureData.var_1639));
                    _loc1_ = _loc5_.getCroppedImage(AvatarSetType.var_136);
                    _loc5_.dispose();
                }

            }
            else
            {
                _loc6_ = (this._controller.assets.getAssetByName("wardrobe_empty_slot") as BitmapDataAsset);
                if (_loc6_)
                {
                    _loc1_ = (_loc6_.content as BitmapData);
                    _loc2_ = false;
                }

            }

            if (!_loc1_)
            {
                return;
            }

            if (this.var_2537)
            {
                if (this.var_2537.bitmap)
                {
                    this.var_2537.bitmap.dispose();
                }

                this.var_2537.bitmap = new BitmapData(this.var_2537.width, this.var_2537.height, true, 0);
                _loc7_ = int((this.var_2537.width - _loc1_.width) / 2);
                _loc8_ = int((this.var_2537.height - _loc1_.height) / 2);
                this.var_2537.bitmap.draw(_loc1_, new Matrix(1, 0, 0, 1, _loc7_, _loc8_));
            }

            if (_loc2_)
            {
                _loc1_.dispose();
            }

            var _loc3_: IContainerButtonWindow = this._view.findChildByName("set_button") as IContainerButtonWindow;
            if (_loc3_)
            {
                _loc3_.visible = this.var_2536;
            }

            var _loc4_: IContainerButtonWindow = this._view.findChildByName("get_button") as IContainerButtonWindow;
            if (_loc4_)
            {
                _loc4_.visible = this.var_2536 && this._figure != null;
            }

        }

        private function eventHandler(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            switch (param2.name)
            {
                case "set_button":
                    this._figure = this._controller.figureData.getFigureString();
                    this._gender = this._controller.gender;
                    this._controller.handler.saveWardrobeOutfit(this._id, this);
                    this.updateView();
                    return;
                case "get_button":
                    if (this._figure)
                    {
                        this._controller.loadAvatarInEditor(this._figure, this._gender, this._controller.clubMemberLevel);
                    }

                    return;
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

        public function get view(): IWindowContainer
        {
            return this._view;
        }

        public function avatarImageReady(param1: String): void
        {
            this.updateView();
        }

    }
}
