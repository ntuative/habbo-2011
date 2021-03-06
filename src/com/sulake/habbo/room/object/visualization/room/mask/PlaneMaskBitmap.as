package com.sulake.habbo.room.object.visualization.room.mask
{

    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneMaskBitmap
    {

        public static const var_1873: Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE: Number = 1;

        private var var_2242: IGraphicAsset = null;
        private var var_4185: Number = -1;
        private var _normalMaxX: Number = 1;
        private var var_4186: Number = -1;
        private var var_4187: Number = 1;

        public function PlaneMaskBitmap(param1: IGraphicAsset, param2: Number = -1, param3: Number = 1, param4: Number = -1, param5: Number = 1)
        {
            this.var_4185 = param2;
            this._normalMaxX = param3;
            this.var_4186 = param4;
            this.var_4187 = param5;
            this.var_2242 = param1;
        }

        public function get asset(): IGraphicAsset
        {
            return this.var_2242;
        }

        public function get normalMinX(): Number
        {
            return this.var_4185;
        }

        public function get normalMaxX(): Number
        {
            return this._normalMaxX;
        }

        public function get normalMinY(): Number
        {
            return this.var_4186;
        }

        public function get normalMaxY(): Number
        {
            return this.var_4187;
        }

        public function dispose(): void
        {
            this.var_2242 = null;
        }

    }
}
