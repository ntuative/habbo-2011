package com.sulake.core.window.utils
{

    import flash.utils.Dictionary;

    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.window.WindowController;

    import flash.geom.Rectangle;

    import com.sulake.core.window.enum.WindowParam;

    import flash.filters.BitmapFilter;
    import flash.filters.DropShadowFilter;
    import flash.utils.*;

    public class WindowParser implements IWindowParser
    {

        public static const var_1763: String = "_EXCLUDE";
        public static const var_1764: String = "_INCLUDE";
        public static const var_1765: String = "_TEMP";
        private static const var_2319: String = "layout";
        private static const var_2320: String = "window";
        private static const var_2321: String = "variables";
        private static const var_2322: String = "filters";
        private static const var_341: String = "name";
        private static const var_2323: String = "style";
        private static const var_2324: String = "params";
        private static const var_2325: String = "tags";
        private static const X: String = "x";
        private static const Y: String = "y";
        private static const var_622: String = "width";
        private static const var_623: String = "height";
        private static const var_2326: String = "visible";
        private static const var_2327: String = "caption";
        private static const ID: String = "id";
        private static const var_23: String = "background";
        private static const var_1022: String = "blend";
        private static const var_2328: String = "clipping";
        private static const COLOR: String = "color";
        private static const var_2329: String = "treshold";
        private static const var_2330: String = "children";
        private static const var_2331: String = "width_min";
        private static const WIDTH_MAX: String = "width_max";
        private static const var_2332: String = "height_min";
        private static const var_2333: String = "height_max";
        private static const var_620: String = "true";
        private static const var_1568: String = "0";
        private static const var_2334: String = "$";
        private static const var_621: String = ",";
        private static const var_1231: String = "";
        private static const var_2335: RegExp = /^(\s|\n|\r|\t|\v)*/m;
        private static const var_2336: RegExp = /(\s|\n|\r|\t|\v)*$/;

        protected var var_2315: Dictionary;
        protected var var_2316: Dictionary;
        protected var var_2317: Dictionary;
        protected var var_2318: Dictionary;
        protected var var_2337: Map;
        protected var _context: IWindowContext;
        private var _disposed: Boolean = false;

        public function WindowParser(param1: IWindowContext)
        {
            this._context = param1;
            this.var_2315 = new Dictionary();
            this.var_2316 = new Dictionary();
            TypeCodeTable.fillTables(this.var_2315, this.var_2316);
            this.var_2317 = new Dictionary();
            this.var_2318 = new Dictionary();
            ParamCodeTable.fillTables(this.var_2317, this.var_2318);
            this.var_2337 = new Map();
        }

        private static function trimWhiteSpace(param1: String): String
        {
            param1 = param1.replace(var_2336, var_1231);
            return param1.replace(var_2335, var_1231);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            var _loc1_: Object;
            if (!this._disposed)
            {
                for (_loc1_ in this.var_2315)
                {
                    this.var_2315[_loc1_] = null;
                }

                for (_loc1_ in this.var_2316)
                {
                    this.var_2316[_loc1_] = null;
                }

                for (_loc1_ in this.var_2317)
                {
                    this.var_2317[_loc1_] = null;
                }

                for (_loc1_ in this.var_2318)
                {
                    this.var_2318[_loc1_] = null;
                }

                this.var_2337.dispose();
                this.var_2337 = null;
                this._context = null;
                this._disposed = true;
            }

        }

        public function parseAndConstruct(param1: XML, param2: IWindow, param3: Map): IWindow
        {
            var _loc4_: XMLList;
            var _loc5_: uint;
            var _loc6_: IWindow;
            var _loc7_: uint;
            var _loc8_: XMLList;
            var _loc9_: XMLList;
            var _loc10_: XML;
            var _loc11_: XMLList;
            var _loc12_: Array;
            var _loc13_: uint;
            if (param1.localName() == var_2319)
            {
                _loc8_ = param1.child(var_2321);
                if (_loc8_.length() > 0)
                {
                    _loc10_ = _loc8_[0];
                    _loc11_ = XML(_loc10_[0]).children();
                    if (_loc11_.length() > 0)
                    {
                        if (param3 == null)
                        {
                            param3 = new Map();
                        }

                        XMLVariableParser.parseVariableList(_loc11_, param3);
                    }

                }

                _loc9_ = param1.child(var_2322).children();
                if (_loc9_.length() > 0)
                {
                    _loc12_ = [];
                    _loc13_ = 0;
                    while (_loc13_ < _loc9_.length())
                    {
                        _loc12_.push(this.var_2338(_loc9_[_loc13_]));
                        _loc13_++;
                    }

                    param2.filters = _loc12_;
                }

                _loc4_ = param1.child(var_2320);
                _loc5_ = _loc4_.length();
                switch (_loc5_)
                {
                    case 0:
                        return null;
                    case 1:
                        param1 = _loc4_[0];
                        break;
                    default:
                        _loc7_ = 0;
                        while (_loc7_ < _loc5_)
                        {
                            _loc6_ = this.parseSingleWindowEntity(_loc4_[_loc7_], WindowController(param2), param3);
                            _loc7_++;
                        }

                        return _loc6_;
                }

            }

            if (param1.localName() == var_2320)
            {
                _loc4_ = param1.children();
                _loc5_ = _loc4_.length();
                if (_loc5_ > 1)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc5_)
                    {
                        _loc6_ = this.parseSingleWindowEntity(_loc4_[_loc7_], WindowController(param2), param3);
                        _loc7_++;
                    }

                    return _loc6_;
                }

                param1 = param1.children()[0];
            }

            return param1 != null ? this.parseSingleWindowEntity(param1, WindowController(param2), param3) : null;
        }

        private function parseSingleWindowEntity(xml: XML, parent: WindowController, variables: Map): IWindow
        {
            var window: WindowController;
            var type: uint;
            var name: String;
            var rect: Rectangle;
            var node: XML;
            var list: XMLList;
            var length: uint;
            var i: uint;
            var tags: Array;
            var param: String;
            var filters: Array;
            var iterator: IIterator;
            var caption: String = var_1231;
            var visible: Boolean = true;
            var clipping: Boolean = true;
            var color: String = "0x00ffffff";
            var blend: Number = 1;
            var background: Boolean;
            var treshold: uint = 10;
            var style: uint = parent != null ? parent.style : 0;
            var params: uint;
            var tag: String = var_1231;
            var id: int;
            type = this.var_2315[xml.localName()];
            name = unescape(String(this.parseAttribute(xml, var_341, variables, "")));
            style = uint(this.parseAttribute(xml, var_2323, variables, style));
            params = uint(this.parseAttribute(xml, var_2324, variables, params));
            tag = unescape(String(this.parseAttribute(xml, var_2325, variables, tag)));
            rect = new Rectangle();
            rect.x = Number(this.parseAttribute(xml, X, variables, var_1568));
            rect.y = Number(this.parseAttribute(xml, Y, variables, var_1568));
            rect.width = Number(this.parseAttribute(xml, var_622, variables, var_1568));
            rect.height = Number(this.parseAttribute(xml, var_623, variables, var_1568));
            visible = this.parseAttribute(xml, var_2326, variables, visible.toString()) == var_620;
            id = int(this.parseAttribute(xml, ID, variables, id.toString()));
            if (xml.child(var_2324).length() > 0)
            {
                list = xml.child(var_2324).children();
                length = list.length();
                i = 0;
                while (i < length)
                {
                    node = list[i];
                    param = (this.parseAttribute(node, var_341, variables, "") as String);
                    if (this.var_2317[param] != null)
                    {
                        params = params | this.var_2317[param];
                    }
                    else
                    {
                        throw new Error("Unknown window parameter \"" + String(node.attribute(var_341)) + "\"!");
                    }

                    i++;
                }

            }

            caption = params & WindowParam.var_714 ? (parent ? parent.caption : var_1231) : var_1231;
            caption = unescape(String(this.parseAttribute(xml, var_2327, variables, caption)));
            if (tag != var_1231)
            {
                tags = tag.split(var_621);
                length = tags.length;
                i = 0;
                while (i < length)
                {
                    tags[i] = WindowParser.trimWhiteSpace(tags[i]);
                    i++;
                }

            }

            window = (this._context.create(name, null, type, style, params, rect, null, (parent is IIterable)
                    ? null
                    : parent, id, this.parseProperties(xml.child(var_2321)[0]), tags) as WindowController);
            window.limits.minWidth = int(this.parseAttribute(xml, var_2331, variables, window.limits.minWidth));
            window.limits.maxWidth = int(this.parseAttribute(xml, WIDTH_MAX, variables, window.limits.maxWidth));
            window.limits.minHeight = int(this.parseAttribute(xml, var_2332, variables, window.limits.minHeight));
            window.limits.maxHeight = int(this.parseAttribute(xml, var_2333, variables, window.limits.maxHeight));
            background = this.parseAttribute(xml, var_23, variables, window.background.toString()) == var_620;
            blend = Number(this.parseAttribute(xml, var_1022, variables, window.blend.toString()));
            clipping = this.parseAttribute(xml, var_2328, variables, window.clipping.toString()) == var_620;
            color = String(this.parseAttribute(xml, COLOR, variables, window.color.toString()));
            treshold = uint(this.parseAttribute(xml, var_2329, variables, window.mouseThreshold.toString()));
            if (window.caption != caption)
            {
                window.caption = caption;
            }

            if (window.blend != blend)
            {
                window.blend = blend;
            }

            if (window.visible != visible)
            {
                window.visible = visible;
            }

            if (window.clipping != clipping)
            {
                window.clipping = clipping;
            }

            if (window.background != background)
            {
                window.background = background;
            }

            if (window.mouseThreshold != treshold)
            {
                window.mouseThreshold = treshold;
            }

            var temp: uint = color.charAt(1) == X ? parseInt(color, 16) : uint(color);
            if (window.color != temp)
            {
                window.color = temp;
            }

            list = xml.child(var_2322).children();
            length = list.length();
            if (length > 0)
            {
                filters = [];
                i = 0;
                while (i < length)
                {
                    filters.push(this.var_2338(list[i]));
                    i++;
                }

                window.filters = filters;
            }

            if (window != null)
            {
                if (parent != null)
                {
                    if (parent is IIterable)
                    {
                        if (window.x != rect.x || window.y != rect.y || window.width != rect.width || window.height != rect.height)
                        {
                            if ((params & WindowParam.var_697) == WindowParam.var_666)
                            {
                                window.x = rect.x;
                            }

                            if ((params & WindowParam.var_698) == WindowParam.var_670)
                            {
                                window.y = rect.y;
                            }

                        }

                        try
                        {
                            iterator = IIterable(parent).iterator;
                        }
                        catch (e: Error)
                        {
                        }

                        if (iterator != null)
                        {
                            iterator[iterator.length] = window;
                        }
                        else
                        {
                            parent.addChild(window);
                        }

                    }

                }

            }

            list = xml.child(var_2330);
            if (list.length() > 0)
            {
                node = list[0];
                list = node.children();
                length = list.length();
                i = 0;
                while (i < length)
                {
                    this.parseAndConstruct(list[i], window, variables);
                    i++;
                }

            }

            return window;
        }

        private function parseAttribute(param1: XML, param2: String, param3: Map, param4: Object): Object
        {
            var _loc5_: XMLList = param1.attribute(param2);
            if (_loc5_.length() == 0)
            {
                return param4;
            }

            var _loc6_: String = String(_loc5_);
            if (param3 != null)
            {
                if (_loc6_.charAt(0) == var_2334)
                {
                    _loc6_ = param3[_loc6_.slice(1, _loc6_.length)];
                    if (_loc6_ == null)
                    {
                        throw new Error("Shared variable not defined: \"" + param1.attribute(param2) + "\"!");
                    }

                }

            }

            return _loc6_;
        }

        private function parseProperties(param1: XML): Array
        {
            return param1 != null ? XMLPropertyArrayParser.parse(param1.children()) : [];
        }

        public function windowToXMLString(param1: IWindow): String
        {
            var _loc8_: IIterator;
            var _loc10_: IWindow;
            var _loc12_: uint;
            var _loc14_: PropertyStruct;
            var _loc15_: BitmapFilter;
            var _loc16_: String;
            var _loc17_: Boolean;
            var _loc2_: String = var_1231;
            var _loc3_: String = this.var_2316[param1.type];
            var _loc4_: uint = param1.param;
            var _loc5_: uint = param1.style;
            var _loc6_: IRectLimiter = param1.limits;
            var _loc7_: WindowController = param1 as WindowController;
            _loc2_ = _loc2_ + ("<" + _loc3_ + " x=\"" + param1.x + "\"" + " y=\"" + param1.y + "\"" + " width=\"" + param1.width + "\"" + " height=\"" + param1.height + "\"" + " params=\"" + param1.param + "\"" + " style=\"" + param1.style + "\"" + (param1.name != var_1231
                    ? " name=\"" + escape(param1.name) + "\""
                    : var_1231) + (param1.caption != var_1231
                    ? " caption=\"" + escape(param1.caption) + "\""
                    : var_1231) + (param1.id != 0
                    ? " id=\"" + param1.id.toString() + "\""
                    : var_1231) + (param1.color != 0xFFFFFF
                    ? " color=\"" + "0x" + param1.alpha.toString(16) + param1.color.toString(16) + "\""
                    : var_1231) + (param1.blend != 1
                    ? " blend=\"" + param1.blend.toString() + "\""
                    : var_1231) + (!param1.visible
                    ? " visible=\"" + param1.visible.toString() + "\""
                    : var_1231) + (!param1.clipping
                    ? " clipping=\"" + param1.clipping.toString() + "\""
                    : var_1231) + (param1.background
                    ? " background=\"" + param1.background.toString() + "\""
                    : var_1231) + (param1.mouseThreshold != 10
                    ? " treshold=\"" + param1.mouseThreshold.toString() + "\""
                    : var_1231) + (param1.tags.length > 0
                    ? " tags=\"" + escape(param1.tags.toString()) + "\""
                    : var_1231) + (_loc6_.minWidth > int.MIN_VALUE
                    ? " width_min=\"" + _loc6_.minWidth + "\""
                    : var_1231) + (_loc6_.maxWidth < int.MAX_VALUE
                    ? " width_max=\"" + _loc6_.maxWidth + "\""
                    : var_1231) + (_loc6_.minHeight > int.MIN_VALUE
                    ? " height_min=\"" + _loc6_.minHeight + "\""
                    : var_1231) + (_loc6_.maxHeight < int.MAX_VALUE
                    ? " height_max=\"" + _loc6_.maxHeight + "\""
                    : var_1231) + ">\r");
            if (param1.filters && param1.filters.length > 0)
            {
                _loc2_ = _loc2_ + "\t<filters>\r";
                for each (_loc15_ in param1.filters)
                {
                    _loc2_ = _loc2_ + ("\t\t" + this.filterToXmlString(_loc15_) + "\r");
                }

                _loc2_ = _loc2_ + "\t</filters>\r";
            }

            var _loc9_: uint = _loc7_.numChildren;
            var _loc11_: String = var_1231;
            if (_loc7_ is IIterable)
            {
                _loc8_ = IIterable(_loc7_).iterator;
                _loc9_ = _loc8_.length;
                if (_loc9_ > 0)
                {
                    _loc12_ = 0;
                    while (_loc12_ < _loc9_)
                    {
                        _loc10_ = (_loc8_[_loc12_] as IWindow);
                        if (_loc10_.tags.indexOf(WindowParser.var_1763) == -1)
                        {
                            _loc11_ = _loc11_ + this.windowToXMLString(_loc10_);
                        }

                        _loc12_++;
                    }

                }

            }
            else
            {
                _loc9_ = _loc7_.numChildren;
                if (_loc9_ > 0)
                {
                    _loc12_ = 0;
                    while (_loc12_ < _loc9_)
                    {
                        _loc10_ = _loc7_.getChildAt(_loc12_);
                        if (_loc10_.tags.indexOf(WindowParser.var_1763) == -1)
                        {
                            _loc11_ = _loc11_ + this.windowToXMLString(_loc10_);
                        }

                        _loc12_++;
                    }

                }

            }

            if (_loc11_.length > 0)
            {
                _loc2_ = _loc2_ + ("\t<children>\r" + _loc11_ + "\t</children>\r");
            }

            var _loc13_: Array = param1.properties;
            if (_loc13_ != null && _loc13_.length > 0)
            {
                _loc16_ = "\t<variables>\r";
                _loc17_ = false;
                _loc12_ = 0;
                while (_loc12_ < _loc13_.length)
                {
                    _loc14_ = (_loc13_[_loc12_] as PropertyStruct);
                    if (_loc14_.valid)
                    {
                        _loc16_ = _loc16_ + ("\t\t" + _loc14_.toXMLString() + "\r");
                        _loc17_ = true;
                    }

                    _loc12_++;
                }

                _loc16_ = _loc16_ + "\t</variables>\r";
                if (_loc17_)
                {
                    _loc2_ = _loc2_ + _loc16_;
                }

            }

            return _loc2_ + ("</" + _loc3_ + ">\r");
        }

        private function var_2338(param1: XML): BitmapFilter
        {
            var _loc3_: BitmapFilter;
            var _loc2_: String = param1.localName() as String;
            switch (_loc2_)
            {
                case "DropShadowFilter":
                    _loc3_ = new DropShadowFilter(Number(this.parseAttribute(param1, "distance", null, "0")), Number(this.parseAttribute(param1, "angle", null, "45")), uint(this.parseAttribute(param1, "color", null, "0")), Number(this.parseAttribute(param1, "alpha", null, "1")), Number(this.parseAttribute(param1, "blurX", null, "0")), Number(this.parseAttribute(param1, "blurY", null, "0")), Number(this.parseAttribute(param1, "strength", null, "1")), int(this.parseAttribute(param1, "quality", null, "1")), Boolean(this.parseAttribute(param1, "inner", null, "false") == "true"), Boolean(this.parseAttribute(param1, "knockout", null, "false") == "true"), Boolean(this.parseAttribute(param1, "hideObject", null, "false") == "true"));
                    break;
            }

            return _loc3_;
        }

        private function filterToXmlString(param1: BitmapFilter): String
        {
            var _loc2_: String;
            if (param1 is DropShadowFilter)
            {
                _loc2_ = "<DropShadowFilter";
                _loc2_ = _loc2_ + (DropShadowFilter(param1).distance != 0
                        ? " distance=\"" + DropShadowFilter(param1).distance + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).angle != 45
                        ? " angle=\"" + DropShadowFilter(param1).angle + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).color != 0
                        ? " color=\"" + DropShadowFilter(param1).color + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).alpha != 1
                        ? " alpha=\"" + DropShadowFilter(param1).alpha + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).blurX != 0
                        ? " blurX=\"" + DropShadowFilter(param1).blurX + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).blurY != 0
                        ? " blurY=\"" + DropShadowFilter(param1).blurY + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).strength != 1
                        ? " strength=\"" + DropShadowFilter(param1).strength + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).quality != 1
                        ? " quality=\"" + DropShadowFilter(param1).quality + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).inner
                        ? " inner=\"" + DropShadowFilter(param1).inner + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).knockout
                        ? " knockout=\"" + DropShadowFilter(param1).knockout + "\""
                        : "");
                _loc2_ = _loc2_ + (DropShadowFilter(param1).hideObject
                        ? " hideObject=\"" + DropShadowFilter(param1).hideObject + "\""
                        : "");
                _loc2_ = _loc2_ + " />";
            }

            return _loc2_;
        }

    }
}
