package com.sulake.core.window.graphics.renderer
{

    import com.sulake.core.window.utils.IChildEntity;

    import flash.geom.Rectangle;

    public class SkinLayoutEntity implements IChildEntity
    {

        public static const var_1965: uint = 0 << 0;
        public static const var_1778: uint = 1 << 0;
        public static const var_1779: uint = 1 << 1;
        public static const var_1780: uint = 1 << 2;
        public static const var_1966: uint = 1 << 3;

        private var _id: uint;
        private var _name: String;
        public var color: uint;
        public var blend: uint;
        public var var_1777: uint;
        public var var_1781: uint;
        public var region: Rectangle;
        public var colorize: Boolean;

        public function SkinLayoutEntity(param1: uint, param2: String)
        {
            this._id = param1;
            this._name = param2;
        }

        public function get id(): uint
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get tags(): Array
        {
            return null;
        }

        public function dispose(): void
        {
            this.region = null;
        }

    }
}
