package com.sulake.core.utils.profiler.tracking
{
    import flash.display.BitmapData;

    public class TrackedBitmapData extends BitmapData 
    {

        private static var var_2195:uint = 0;
        private static var var_595:uint = 0;
        private static const var_2196:uint = 0xFFFFFF;

        private var var_2197:Object;
        private var _disposed:Boolean = false;

        public function TrackedBitmapData(param1:*, param2:int, param3:int, param4:Boolean=true, param5:uint=0xFFFFFFFF)
        {
            super(param2, param3, param4, param5);
            var_2195++;
            var_595 = (var_595 + ((param2 * param3) * 4));
            this.var_2197 = param1;
        }

        public static function get numInstances():uint
        {
            return (var_2195);
        }

        public static function get allocatedByteCount():uint
        {
            return (var_595);
        }

        override public function dispose():void
        {
            if (!this._disposed)
            {
                var_595 = (var_595 - ((width * height) * 4));
                var_2195--;
                super.dispose();
                this._disposed = true;
                this.var_2197 = null;
            };
        }

    }
}