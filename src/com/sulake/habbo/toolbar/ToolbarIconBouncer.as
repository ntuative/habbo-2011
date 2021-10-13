package com.sulake.habbo.toolbar
{
    public class ToolbarIconBouncer 
    {

        private var var_4562:Number;
        private var var_4089:Number;
        private var var_4563:Number;
        private var var_2494:Number = 0;

        public function ToolbarIconBouncer(param1:Number, param2:Number)
        {
            this.var_4562 = param1;
            this.var_4089 = param2;
        }

        public function reset(param1:int):void
        {
            this.var_4563 = param1;
            this.var_2494 = 0;
        }

        public function update():void
        {
            this.var_4563 = (this.var_4563 + this.var_4089);
            this.var_2494 = (this.var_2494 + this.var_4563);
            if (this.var_2494 > 0)
            {
                this.var_2494 = 0;
                this.var_4563 = ((this.var_4562 * -1) * this.var_4563);
            };
        }

        public function get location():Number
        {
            return (this.var_2494);
        }

    }
}