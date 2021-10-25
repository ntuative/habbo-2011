package com.sulake.habbo.avatar
{

    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    import flash.geom.ColorTransform;

    public class AvatarImagePartContainer
    {

        private var _bodyPartId: String;
        private var _partType: String;
        private var _flippedPartType: String;
        private var _partId: String;
        private var _color: IPartColor;
        private var _frames: Array;
        private var _action: IActionDefinition;
        private var _isColorable: Boolean;
        private var _isBlendable: Boolean;
        private var _blendTransform: ColorTransform;
        private var _paletteMapId: int;

        public function AvatarImagePartContainer(param1: String, param2: String, param3: String, param4: IPartColor, param5: Array, param6: IActionDefinition, param7: Boolean, param8: int, param9: String = "", param10: Boolean = false, param11: Number = 1)
        {
            this._bodyPartId = param1;
            this._partType = param2;
            this._partId = param3;
            this._color = param4;
            this._frames = param5;
            this._action = param6;
            this._isColorable = param7;
            this._paletteMapId = param8;
            this._flippedPartType = param9;
            this._isBlendable = param10;
            this._blendTransform = new ColorTransform(1, 1, 1, param11);
            if (this._frames == null)
            {
                Logger.log("Null frame list");
            }

            if (this._partType == "ey")
            {
                this._isColorable = false;
            }

        }

        public function getFrameIndex(param1: int): int
        {
            return this._frames[(param1 % this._frames.length)];
        }

        public function get frames(): Array
        {
            return this._frames;
        }

        public function get bodyPartId(): String
        {
            return this._bodyPartId;
        }

        public function get partType(): String
        {
            return this._partType;
        }

        public function get partId(): String
        {
            return this._partId;
        }

        public function get color(): IPartColor
        {
            return this._color;
        }

        public function get action(): IActionDefinition
        {
            return this._action;
        }

        public function set isColorable(param1: Boolean): void
        {
            this._isColorable = param1;
        }

        public function get isColorable(): Boolean
        {
            return this._isColorable;
        }

        public function get paletteMapId(): int
        {
            return this._paletteMapId;
        }

        public function get flippedPartType(): String
        {
            return this._flippedPartType;
        }

        public function get isBlendable(): Boolean
        {
            return this._isBlendable;
        }

        public function get blendTransform(): ColorTransform
        {
            return this._blendTransform;
        }

    }
}
