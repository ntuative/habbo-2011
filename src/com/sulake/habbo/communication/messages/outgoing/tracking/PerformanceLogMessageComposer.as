package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PerformanceLogMessageComposer implements IMessageComposer 
    {

        private var var_2171:int = 0;
        private var var_3113:String = "";
        private var var_3114:String = "";
        private var var_3115:String = "";
        private var var_3116:String = "";
        private var var_3117:int = 0;
        private var var_3118:int = 0;
        private var var_3119:int = 0;
        private var var_3120:int = 0;
        private var var_3121:int = 0;
        private var var_3122:int = 0;

        public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
        {
            this.var_2171 = param1;
            this.var_3113 = param2;
            this.var_3114 = param3;
            this.var_3115 = param4;
            this.var_3116 = param5;
            if (param6)
            {
                this.var_3117 = 1;
            }
            else
            {
                this.var_3117 = 0;
            };
            this.var_3118 = param7;
            this.var_3119 = param8;
            this.var_3120 = param9;
            this.var_3121 = param10;
            this.var_3122 = param11;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_2171, this.var_3113, this.var_3114, this.var_3115, this.var_3116, this.var_3117, this.var_3118, this.var_3119, this.var_3120, this.var_3121, this.var_3122]);
        }

    }
}