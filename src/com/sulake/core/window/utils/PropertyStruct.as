package com.sulake.core.window.utils
{

    import flash.geom.Point;
    import flash.geom.Rectangle;

    import com.sulake.core.utils.Map;

    import flash.utils.getQualifiedClassName;

    public class PropertyStruct
    {

        public static const var_606: String = "hex";
        public static const var_607: String = "int";
        public static const var_608: String = "uint";
        public static const var_609: String = "Number";
        public static const var_611: String = "Boolean";
        public static const var_613: String = "String";
        public static const var_614: String = "Point";
        public static const var_615: String = "Rectangle";
        public static const var_616: String = "Array";
        public static const var_617: String = "Map";

        private var _key: String;
        private var _value: Object;
        private var _type: String;
        private var _valid: Boolean;
        private var var_2305: Boolean;
        private var _range: Array;

        public function PropertyStruct(param1: String, param2: Object, param3: String, param4: Boolean, param5: Array = null)
        {
            this._key = param1;
            this._value = param2;
            this._type = param3;
            this._valid = param4;
            this.var_2305 = param3 == var_617 || param3 == var_616 || param3 == var_614 || param3 == var_615;
            this._range = param5;
        }

        public function get key(): String
        {
            return this._key;
        }

        public function get value(): Object
        {
            return this._value;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get valid(): Boolean
        {
            return this._valid;
        }

        public function get range(): Array
        {
            return this._range;
        }

        public function toString(): String
        {
            switch (this._type)
            {
                case var_606:
                    return "0x" + uint(this._value).toString(16);
                case var_611:
                    return Boolean(this._value) ? "true" : "false";
                case var_614:
                    return "Point(" + Point(this._value).x + ", " + Point(this._value).y + ")";
                case var_615:
                    return "Rectangle(" + Rectangle(this._value).x + ", " + Rectangle(this._value).y + ", " + Rectangle(this._value).width + ", " + Rectangle(this._value).height + ")";
            }

            return String(this.value);
        }

        public function toXMLString(): String
        {
            var _loc1_: String;
            var _loc2_: int;
            var _loc3_: Map;
            var _loc4_: Array;
            var _loc5_: Point;
            var _loc6_: Rectangle;
            switch (this._type)
            {
                case var_617:
                    _loc3_ = (this._value as Map);
                    _loc1_ = "<var key=\"" + this._key + "\">\r<value>\r<" + this._type + ">\r";
                    _loc2_ = 0;
                    while (_loc2_ < _loc3_.length)
                    {
                        _loc1_ = _loc1_ + ("<var key=\"" + _loc3_.getKey(_loc2_) + "\" value=\"" + _loc3_.getWithIndex(_loc2_) + "\" type=\"" + getQualifiedClassName(_loc3_.getWithIndex(_loc2_)) + "\" />\r");
                        _loc2_++;
                    }

                    _loc1_ = _loc1_ + ("</" + this._type + ">\r</value>\r</var>");
                    break;
                case var_616:
                    _loc4_ = (this._value as Array);
                    _loc1_ = "<var key=\"" + this._key + "\">\r<value>\r<" + this._type + ">\r";
                    _loc2_ = 0;
                    while (_loc2_ < _loc4_.length)
                    {
                        _loc1_ = _loc1_ + ("<var key=\"" + String(_loc2_) + "\" value=\"" + _loc4_[_loc2_] + "\" type=\"" + getQualifiedClassName(_loc4_[_loc2_]) + "\" />\r");
                        _loc2_++;
                    }

                    _loc1_ = _loc1_ + ("</" + this._type + ">\r</value>\r</var>");
                    break;
                case var_614:
                    _loc5_ = (this._value as Point);
                    _loc1_ = "<var key=\"" + this._key + "\">\r<value>\r<" + this._type + ">\r";
                    _loc1_ = _loc1_ + ("<var key=\"x\" value=\"" + _loc5_.x + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("<var key=\"y\" value=\"" + _loc5_.y + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("</" + this._type + ">\r</value>\r</var>");
                    break;
                case var_615:
                    _loc6_ = (this._value as Rectangle);
                    _loc1_ = "<var key=\"" + this._key + "\">\r<value>\r<" + this._type + ">\r";
                    _loc1_ = _loc1_ + ("<var key=\"x\" value=\"" + _loc6_.x + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("<var key=\"y\" value=\"" + _loc6_.y + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("<var key=\"width\" value=\"" + _loc6_.width + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("<var key=\"height\" value=\"" + _loc6_.height + "\" type=\"" + var_607 + "\" />\r");
                    _loc1_ = _loc1_ + ("</" + this._type + ">\r</value>\r</var>");
                    break;
                case var_606:
                    _loc1_ = "<var key=\"" + this._key + "\" value=\"" + "0x" + uint(this._value)
                            .toString(16) + "\" type=\"" + this._type + "\" />";
                    break;
                default:
                    _loc1_ = "<var key=\"" + this._key + "\" value=\"" + this._value + "\" type=\"" + this._type + "\" />";
            }

            return _loc1_;
        }

    }
}
