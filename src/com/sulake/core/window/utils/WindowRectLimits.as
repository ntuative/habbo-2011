package com.sulake.core.window.utils
{
    import com.sulake.core.window.IWindow;

    public class WindowRectLimits implements IRectLimiter 
    {

        private var var_2339:int = -2147483648;
        private var var_2340:int = 2147483647;
        private var var_2341:int = -2147483648;
        private var var_2342:int = 2147483647;
        private var _target:IWindow;

        public function WindowRectLimits(param1:IWindow)
        {
            this._target = param1;
        }

        public function get minWidth():int
        {
            return (this.var_2339);
        }

        public function get maxWidth():int
        {
            return (this.var_2340);
        }

        public function get minHeight():int
        {
            return (this.var_2341);
        }

        public function get maxHeight():int
        {
            return (this.var_2342);
        }

        public function set minWidth(param1:int):void
        {
            this.var_2339 = param1;
            if ((((this.var_2339 > int.MIN_VALUE) && (!(this._target.disposed))) && (this._target.width < this.var_2339)))
            {
                this._target.width = this.var_2339;
            };
        }

        public function set maxWidth(param1:int):void
        {
            this.var_2340 = param1;
            if ((((this.var_2340 < int.MAX_VALUE) && (!(this._target.disposed))) && (this._target.width > this.var_2340)))
            {
                this._target.width = this.var_2340;
            };
        }

        public function set minHeight(param1:int):void
        {
            this.var_2341 = param1;
            if ((((this.var_2341 > int.MIN_VALUE) && (!(this._target.disposed))) && (this._target.height < this.var_2341)))
            {
                this._target.height = this.var_2341;
            };
        }

        public function set maxHeight(param1:int):void
        {
            this.var_2342 = param1;
            if ((((this.var_2342 < int.MAX_VALUE) && (!(this._target.disposed))) && (this._target.height > this.var_2342)))
            {
                this._target.height = this.var_2342;
            };
        }

        public function get isEmpty():Boolean
        {
            return ((((this.var_2339 == int.MIN_VALUE) && (this.var_2340 == int.MAX_VALUE)) && (this.var_2341 == int.MIN_VALUE)) && (this.var_2342 == int.MAX_VALUE));
        }

        public function setEmpty():void
        {
            this.var_2339 = int.MIN_VALUE;
            this.var_2340 = int.MAX_VALUE;
            this.var_2341 = int.MIN_VALUE;
            this.var_2342 = int.MAX_VALUE;
        }

        public function limit():void
        {
            if (((!(this.isEmpty)) && (this._target)))
            {
                if (this._target.width < this.var_2339)
                {
                    this._target.width = this.var_2339;
                }
                else
                {
                    if (this._target.width > this.var_2340)
                    {
                        this._target.width = this.var_2340;
                    };
                };
                if (this._target.height < this.var_2341)
                {
                    this._target.height = this.var_2341;
                }
                else
                {
                    if (this._target.height > this.var_2342)
                    {
                        this._target.height = this.var_2342;
                    };
                };
            };
        }

        public function assign(param1:int, param2:int, param3:int, param4:int):void
        {
            this.var_2339 = param1;
            this.var_2340 = param2;
            this.var_2341 = param3;
            this.var_2342 = param4;
            this.limit();
        }

        public function clone(param1:IWindow):WindowRectLimits
        {
            var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
            _loc2_.var_2339 = this.var_2339;
            _loc2_.var_2340 = this.var_2340;
            _loc2_.var_2341 = this.var_2341;
            _loc2_.var_2342 = this.var_2342;
            return (_loc2_);
        }

    }
}