package com.sulake.habbo.room.object.visualization.data
{

    public class LayerData
    {

        public static const var_1446: String = "";
        public static const var_1447: int = 0;
        public static const var_1448: int = 0xFF;
        public static const var_1450: Boolean = false;
        public static const var_1451: int = 0;
        public static const var_1452: int = 0;
        public static const var_1453: int = 0;
        public static const var_1456: int = 1;
        public static const var_1457: int = 2;
        public static const INK_DARKEN: int = 3;

        private var var_2997: String = "";
        private var var_2394: int = 0;
        private var var_4054: int = 0xFF;
        private var var_4055: Boolean = false;
        private var var_4056: int = 0;
        private var var_4057: int = 0;
        private var var_4058: Number = 0;

        public function set tag(param1: String): void
        {
            this.var_2997 = param1;
        }

        public function get tag(): String
        {
            return this.var_2997;
        }

        public function set ink(param1: int): void
        {
            this.var_2394 = param1;
        }

        public function get ink(): int
        {
            return this.var_2394;
        }

        public function set alpha(param1: int): void
        {
            this.var_4054 = param1;
        }

        public function get alpha(): int
        {
            return this.var_4054;
        }

        public function set ignoreMouse(param1: Boolean): void
        {
            this.var_4055 = param1;
        }

        public function get ignoreMouse(): Boolean
        {
            return this.var_4055;
        }

        public function set xOffset(param1: int): void
        {
            this.var_4056 = param1;
        }

        public function get xOffset(): int
        {
            return this.var_4056;
        }

        public function set yOffset(param1: int): void
        {
            this.var_4057 = param1;
        }

        public function get yOffset(): int
        {
            return this.var_4057;
        }

        public function set zOffset(param1: Number): void
        {
            this.var_4058 = param1;
        }

        public function get zOffset(): Number
        {
            return this.var_4058;
        }

        public function copyValues(param1: LayerData): void
        {
            if (param1 != null)
            {
                this.tag = param1.tag;
                this.ink = param1.ink;
                this.alpha = param1.alpha;
                this.ignoreMouse = param1.ignoreMouse;
                this.xOffset = param1.xOffset;
                this.yOffset = param1.yOffset;
                this.zOffset = param1.zOffset;
            }

        }

    }
}
