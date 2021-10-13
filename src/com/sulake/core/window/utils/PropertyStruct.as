package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;
    import flash.utils.getQualifiedClassName;

    public class PropertyStruct 
    {

        public static const var_606:String = "hex";
        public static const var_607:String = "int";
        public static const var_608:String = "uint";
        public static const var_609:String = "Number";
        public static const var_611:String = "Boolean";
        public static const var_613:String = "String";
        public static const var_614:String = "Point";
        public static const var_615:String = "Rectangle";
        public static const var_616:String = "Array";
        public static const var_617:String = "Map";

        private var var_2161:String;
        private var var_2162:Object;
        private var _type:String;
        private var var_2303:Boolean;
        private var var_2305:Boolean;
        private var var_2304:Array;

        public function PropertyStruct(param1:String, param2:Object, param3:String, param4:Boolean, param5:Array=null)
        {
            this.var_2161 = param1;
            this.var_2162 = param2;
            this._type = param3;
            this.var_2303 = param4;
            this.var_2305 = ((((param3 == var_617) || (param3 == var_616)) || (param3 == var_614)) || (param3 == var_615));
            this.var_2304 = param5;
        }

        public function get key():String
        {
            return (this.var_2161);
        }

        public function get value():Object
        {
            return (this.var_2162);
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get valid():Boolean
        {
            return (this.var_2303);
        }

        public function get range():Array
        {
            return (this.var_2304);
        }

        public function toString():String
        {
            switch (this._type)
            {
                case var_606:
                    return ("0x" + uint(this.var_2162).toString(16));
                case var_611:
                    return ((Boolean(this.var_2162) == true) ? "true" : "false");
                case var_614:
                    return (((("Point(" + Point(this.var_2162).x) + ", ") + Point(this.var_2162).y) + ")");
                case var_615:
                    return (((((((("Rectangle(" + Rectangle(this.var_2162).x) + ", ") + Rectangle(this.var_2162).y) + ", ") + Rectangle(this.var_2162).width) + ", ") + Rectangle(this.var_2162).height) + ")");
            };
            return (String(this.value));
        }

        public function toXMLString():String
        {
            var _loc1_:String;
            var _loc2_:int;
            var _loc3_:Map;
            var _loc4_:Array;
            var _loc5_:Point;
            var _loc6_:Rectangle;
            switch (this._type)
            {
                case var_617:
                    _loc3_ = (this.var_2162 as Map);
                    _loc1_ = (((('<var key="' + this.var_2161) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc2_ = 0;
                    while (_loc2_ < _loc3_.length)
                    {
                        _loc1_ = (_loc1_ + (((((('<var key="' + _loc3_.getKey(_loc2_)) + '" value="') + _loc3_.getWithIndex(_loc2_)) + '" type="') + getQualifiedClassName(_loc3_.getWithIndex(_loc2_))) + '" />\r'));
                        _loc2_++;
                    };
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_616:
                    _loc4_ = (this.var_2162 as Array);
                    _loc1_ = (((('<var key="' + this.var_2161) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc2_ = 0;
                    while (_loc2_ < _loc4_.length)
                    {
                        _loc1_ = (_loc1_ + (((((('<var key="' + String(_loc2_)) + '" value="') + _loc4_[_loc2_]) + '" type="') + getQualifiedClassName(_loc4_[_loc2_])) + '" />\r'));
                        _loc2_++;
                    };
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_614:
                    _loc5_ = (this.var_2162 as Point);
                    _loc1_ = (((('<var key="' + this.var_2161) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc1_ = (_loc1_ + (((('<var key="x" value="' + _loc5_.x) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="y" value="' + _loc5_.y) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_615:
                    _loc6_ = (this.var_2162 as Rectangle);
                    _loc1_ = (((('<var key="' + this.var_2161) + '">\r<value>\r<') + this._type) + ">\r");
                    _loc1_ = (_loc1_ + (((('<var key="x" value="' + _loc6_.x) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="y" value="' + _loc6_.y) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="width" value="' + _loc6_.width) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (((('<var key="height" value="' + _loc6_.height) + '" type="') + var_607) + '" />\r'));
                    _loc1_ = (_loc1_ + (("</" + this._type) + ">\r</value>\r</var>"));
                    break;
                case var_606:
                    _loc1_ = ((((((('<var key="' + this.var_2161) + '" value="') + "0x") + uint(this.var_2162).toString(16)) + '" type="') + this._type) + '" />');
                    break;
                default:
                    _loc1_ = (((((('<var key="' + this.var_2161) + '" value="') + this.var_2162) + '" type="') + this._type) + '" />');
            };
            return (_loc1_);
        }

    }
}