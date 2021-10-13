package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.getQualifiedClassName;

    internal final class InterfaceStruct implements IDisposable 
    {

        private var var_2188:IID;
        private var var_2189:String;
        private var var_2129:IUnknown;
        private var var_2174:uint;

        public function InterfaceStruct(param1:IID, param2:IUnknown)
        {
            this.var_2188 = param1;
            this.var_2189 = getQualifiedClassName(this.var_2188);
            this.var_2129 = param2;
            this.var_2174 = 0;
        }

        public function get iid():IID
        {
            return (this.var_2188);
        }

        public function get iis():String
        {
            return (this.var_2189);
        }

        public function get unknown():IUnknown
        {
            return (this.var_2129);
        }

        public function get references():uint
        {
            return (this.var_2174);
        }

        public function get disposed():Boolean
        {
            return (this.var_2129 == null);
        }

        public function dispose():void
        {
            this.var_2188 = null;
            this.var_2189 = null;
            this.var_2129 = null;
            this.var_2174 = 0;
        }

        public function reserve():uint
        {
            return (++this.var_2174);
        }

        public function release():uint
        {
            return ((this.references > 0) ? --this.var_2174 : 0);
        }

    }
}