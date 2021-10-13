package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.WindowRectLimits;
    import com.sulake.core.window.enum.WindowState;
    import flash.geom.Point;
    import com.sulake.core.window.utils.IRectLimiter;

    public class WindowModel implements IDisposable 
    {

        protected var var_1018:Rectangle;
        protected var var_1012:Rectangle;
        protected var var_1014:Rectangle;
        protected var var_1031:Rectangle;
        protected var var_1032:Rectangle;
        protected var var_1017:WindowRectLimits;
        protected var _context:WindowContext;
        protected var var_1015:Boolean = false;
        protected var var_1016:uint = 0xFFFFFF;
        protected var var_1021:uint;
        protected var var_1030:uint = 10;
        protected var var_1027:Boolean = true;
        protected var var_1023:Boolean = true;
        protected var var_1033:Number = 1;
        protected var var_1013:uint;
        protected var _state:uint;
        protected var var_1025:uint;
        protected var _type:uint;
        protected var var_1034:String = "";
        protected var _name:String;
        protected var _id:uint;
        protected var var_1029:Array;
        protected var _disposed:Boolean = false;

        public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array=null)
        {
            this._id = param1;
            this._name = param2;
            this._type = param3;
            this.var_1013 = param5;
            this._state = WindowState.var_990;
            this.var_1025 = param4;
            this.var_1029 = ((param8 == null) ? new Array() : param8);
            this._context = param6;
            this.var_1018 = param7.clone();
            this.var_1012 = param7.clone();
            this.var_1014 = param7.clone();
            this.var_1031 = new Rectangle();
            this.var_1032 = null;
            this.var_1017 = new WindowRectLimits((this as IWindow));
        }

        public function get x():int
        {
            return (this.var_1018.x);
        }

        public function get y():int
        {
            return (this.var_1018.y);
        }

        public function get width():int
        {
            return (this.var_1018.width);
        }

        public function get height():int
        {
            return (this.var_1018.height);
        }

        public function get position():Point
        {
            return (this.var_1018.topLeft);
        }

        public function get rectangle():Rectangle
        {
            return (this.var_1018);
        }

        public function get limits():IRectLimiter
        {
            return (this.var_1017);
        }

        public function get context():IWindowContext
        {
            return (this._context);
        }

        public function get mouseThreshold():uint
        {
            return (this.var_1030);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get background():Boolean
        {
            return (this.var_1015);
        }

        public function get clipping():Boolean
        {
            return (this.var_1027);
        }

        public function get visible():Boolean
        {
            return (this.var_1023);
        }

        public function get color():uint
        {
            return (this.var_1016);
        }

        public function get alpha():uint
        {
            return (this.var_1021 >>> 24);
        }

        public function get blend():Number
        {
            return (this.var_1033);
        }

        public function get param():uint
        {
            return (this.var_1013);
        }

        public function get state():uint
        {
            return (this._state);
        }

        public function get style():uint
        {
            return (this.var_1025);
        }

        public function get type():uint
        {
            return (this._type);
        }

        public function get caption():String
        {
            return (this.var_1034);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function get tags():Array
        {
            return (this.var_1029);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_1018 = null;
                this._context = null;
                this._state = WindowState.var_991;
                this.var_1029 = null;
            };
        }

        public function invalidate(param1:Rectangle=null):void
        {
        }

        public function getInitialWidth():int
        {
            return (this.var_1012.width);
        }

        public function getInitialHeight():int
        {
            return (this.var_1012.height);
        }

        public function getPreviousWidth():int
        {
            return (this.var_1014.width);
        }

        public function getPreviousHeight():int
        {
            return (this.var_1014.height);
        }

        public function getMinimizedWidth():int
        {
            return (this.var_1031.width);
        }

        public function getMinimizedHeight():int
        {
            return (this.var_1031.height);
        }

        public function getMaximizedWidth():int
        {
            return (this.var_1032.width);
        }

        public function getMaximizedHeight():int
        {
            return (this.var_1032.height);
        }

        public function hasMaxWidth():Boolean
        {
            return (this.var_1017.maxWidth < int.MAX_VALUE);
        }

        public function getMaxWidth():int
        {
            return (this.var_1017.maxWidth);
        }

        public function setMaxWidth(param1:int):int
        {
            var _loc2_:int = this.var_1017.maxWidth;
            this.var_1017.maxWidth = param1;
            return (_loc2_);
        }

        public function hasMinWidth():Boolean
        {
            return (this.var_1017.minWidth > int.MIN_VALUE);
        }

        public function getMinWidth():int
        {
            return (this.var_1017.minWidth);
        }

        public function setMinWidth(param1:int):int
        {
            var _loc2_:int = this.var_1017.minWidth;
            this.var_1017.minWidth = param1;
            return (_loc2_);
        }

        public function hasMaxHeight():Boolean
        {
            return (this.var_1017.maxHeight < int.MAX_VALUE);
        }

        public function getMaxHeight():int
        {
            return (this.var_1017.maxHeight);
        }

        public function setMaxHeight(param1:int):int
        {
            var _loc2_:int = this.var_1017.maxHeight;
            this.var_1017.maxHeight = param1;
            return (_loc2_);
        }

        public function hasMinHeight():Boolean
        {
            return (this.var_1017.minHeight > int.MIN_VALUE);
        }

        public function getMinHeight():int
        {
            return (this.var_1017.minHeight);
        }

        public function setMinHeight(param1:int):int
        {
            var _loc2_:int = this.var_1017.minHeight;
            this.var_1017.minHeight = param1;
            return (_loc2_);
        }

        public function testTypeFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this._type & param2) ^ param1) == 0);
            };
            return ((this._type & param1) == param1);
        }

        public function testStateFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this._state & param2) ^ param1) == 0);
            };
            return ((this._state & param1) == param1);
        }

        public function testStyleFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this.var_1025 & param2) ^ param1) == 0);
            };
            return ((this.var_1025 & param1) == param1);
        }

        public function testParamFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this.var_1013 & param2) ^ param1) == 0);
            };
            return ((this.var_1013 & param1) == param1);
        }

    }
}