package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetPackageEvent extends RoomSessionEvent 
    {

        public static const var_372:String = "RSOPPE_OPEN_PET_PACKAGE_REQUESTED";
        public static const var_373:String = "RSOPPE_OPEN_PET_PACKAGE_RESULT";

        private var var_2358:int = -1;
        private var var_2603:int = -1;
        private var var_2517:int = -1;
        private var _color:String = "";
        private var var_3311:int = 0;
        private var var_2715:String = null;

        public function RoomSessionPetPackageEvent(param1:String, param2:IRoomSession, param3:int, param4:int, param5:int, param6:String, param7:int, param8:String, param9:Boolean=false, param10:Boolean=false)
        {
            super(param1, param2, param9, param10);
            this.var_2358 = param3;
            this.var_2603 = param4;
            this.var_2517 = param5;
            this._color = param6;
            this.var_3311 = param7;
            this.var_2715 = param8;
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get petType():int
        {
            return (this.var_2603);
        }

        public function get breed():int
        {
            return (this.var_2517);
        }

        public function get color():String
        {
            return (this._color);
        }

        public function get nameValidationStatus():int
        {
            return (this.var_3311);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_2715);
        }

    }
}