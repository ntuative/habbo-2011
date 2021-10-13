package com.sulake.core.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class XMLVariableParser 
    {

        public static const var_606:String = "hex";
        public static const var_607:String = "int";
        public static const var_608:String = "uint";
        public static const var_609:String = "Number";
        public static const var_610:String = "float";
        public static const var_611:String = "Boolean";
        public static const var_612:String = "bool";
        public static const var_613:String = "String";
        public static const var_614:String = "Point";
        public static const var_615:String = "Rectangle";
        public static const var_616:String = "Array";
        public static const var_617:String = "Map";
        private static const var_618:String = "key";
        private static const TYPE:String = "type";
        private static const var_619:String = "value";
        private static const var_620:String = "true";
        private static const var_2218:String = "false";
        private static const X:String = "x";
        private static const Y:String = "y";
        private static const var_622:String = "width";
        private static const var_623:String = "height";
        private static const var_621:String = ",";

        public static function parseVariableList(param1:XMLList, param2:Map, param3:Array=null):uint
        {
            var _loc5_:uint;
            var _loc4_:uint = param1.length();
            _loc5_ = 0;
            while (_loc5_ < _loc4_)
            {
                XMLVariableParser.parseVariableToken(param1[_loc5_], param2, param3);
                _loc5_++;
            };
            return (_loc4_);
        }

        private static function parseVariableToken(param1:XML, param2:Map, param3:Array=null):void
        {
            var _loc4_:String;
            var _loc6_:String;
            var _loc7_:XMLList;
            var _loc8_:XML;
            var _loc9_:XML;
            var _loc5_:String = var_613;
            _loc7_ = param1.attribute(var_618);
            if (_loc7_.length() > 0)
            {
                _loc4_ = String(param1.attribute(var_618));
            }
            else
            {
                _loc4_ = param1.child(var_618)[0];
            };
            _loc7_ = param1.attribute(TYPE);
            if (_loc7_.length() > 0)
            {
                _loc5_ = String(param1.attribute(TYPE));
            };
            _loc7_ = param1.attribute(var_619);
            if (_loc7_.length() > 0)
            {
                _loc6_ = String(param1.attribute(var_619));
            };
            if (_loc6_ != null)
            {
                param2[_loc4_] = XMLVariableParser.castStringToType(_loc6_, _loc5_);
            }
            else
            {
                _loc8_ = param1.child(var_619)[0];
                if (_loc8_ != null)
                {
                    _loc9_ = _loc8_.child(0)[0];
                    _loc6_ = _loc9_.children()[0];
                    _loc5_ = _loc9_.localName();
                    param2[_loc4_] = XMLVariableParser.parseValueType(_loc9_, _loc5_);
                }
                else
                {
                    if (((_loc5_ == var_617) || (_loc5_ == var_616)))
                    {
                        param2[_loc4_] = XMLVariableParser.parseValueType(param1, _loc5_);
                    };
                };
            };
            if (param3)
            {
                param3.push(_loc5_);
            };
        }

        public static function castStringToType(param1:String, param2:String):Object
        {
            switch (param2)
            {
                case var_608:
                    return (uint(param1));
                case var_607:
                    return (int(param1));
                case var_609:
                    return (Number(param1));
                case var_610:
                    return (Number(param1));
                case var_611:
                    return ((param1 == var_620) || (int(param1) > 0));
                case var_612:
                    return ((param1 == var_620) || (int(param1) > 0));
                case var_606:
                    return (uint(param1));
                case var_616:
                    return (param1.split(var_621));
                default:
                    return (String(param1));
            };
        }

        public static function parseValueType(param1:XML, param2:String):Object
        {
            var _loc3_:Map;
            var _loc4_:Point;
            var _loc5_:Rectangle;
            var _loc6_:Array;
            var _loc7_:String;
            switch (param2)
            {
                case var_613:
                    return (String(param1));
                case var_614:
                    _loc4_ = new Point();
                    _loc4_.x = Number(param1.attribute(X));
                    _loc4_.y = Number(param1.attribute(Y));
                    return (_loc4_);
                case var_615:
                    _loc5_ = new Rectangle();
                    _loc5_.x = Number(param1.attribute(X));
                    _loc5_.y = Number(param1.attribute(Y));
                    _loc5_.width = Number(param1.attribute(var_622));
                    _loc5_.height = Number(param1.attribute(var_623));
                    return (_loc5_);
                case var_616:
                    _loc3_ = new Map();
                    parseVariableList(param1.children(), _loc3_);
                    _loc6_ = new Array();
                    for (_loc7_ in _loc3_)
                    {
                        _loc6_.push(_loc3_[_loc7_]);
                    };
                    return (_loc6_);
                case var_617:
                    _loc3_ = new Map();
                    XMLVariableParser.parseVariableList(param1.children(), _loc3_);
                    return (_loc3_);
            };
            throw (new Error((('Unable to parse data type "' + param2) + '", unknown type!')));
        }

    }
}