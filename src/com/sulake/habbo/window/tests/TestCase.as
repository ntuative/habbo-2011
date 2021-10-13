package com.sulake.habbo.window.tests
{
    import com.sulake.habbo.window.HabboWindowManagerComponent;

    public class TestCase 
    {

        public var result:int;
        protected var windowManager:HabboWindowManagerComponent;

        public function begin(param1:HabboWindowManagerComponent):void
        {
            this.windowManager = param1;
        }

        public function test(param1:Object):void
        {
        }

        public function end():void
        {
            this.windowManager = null;
        }

    }
}