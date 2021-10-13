package com.sulake.habbo.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetPackageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1347:String = "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED";
        public static const var_1348:String = "RWOPPUE_OPEN_PET_PACKAGE_RESULT";
        public static const var_1349:String = "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE";

        private var var_2358:int = -1;
        private var var_988:BitmapData = null;
        private var var_3311:int = 0;
        private var var_2715:String = null;

        public function RoomWidgetPetPackageUpdateEvent(param1:String, param2:int, param3:BitmapData, param4:int, param5:String, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_2358 = param2;
            this.var_988 = param3;
            this.var_3311 = param4;
            this.var_2715 = param5;
        }

        public function get nameValidationStatus():int
        {
            return (this.var_3311);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_2715);
        }

        public function get image():BitmapData
        {
            return (this.var_988);
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

    }
}