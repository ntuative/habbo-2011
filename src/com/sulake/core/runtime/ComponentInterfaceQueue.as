package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;

    internal class ComponentInterfaceQueue implements IDisposable 
    {

        private var var_2178:IID;
        private var var_978:Boolean;
        private var var_2179:Array;

        public function ComponentInterfaceQueue(param1:IID)
        {
            this.var_2178 = param1;
            this.var_2179 = new Array();
            this.var_978 = false;
        }

        public function get identifier():IID
        {
            return (this.var_2178);
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function get receivers():Array
        {
            return (this.var_2179);
        }

        public function dispose():void
        {
            if (!this.var_978)
            {
                this.var_978 = true;
                this.var_2178 = null;
                while (this.var_2179.length > 0)
                {
                    this.var_2179.pop();
                };
                this.var_2179 = null;
            };
        }

    }
}