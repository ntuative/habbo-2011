package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoData 
    {

        private var _userId:int;
        private var _userName:String;
        private var var_2961:int;
        private var var_2962:int;
        private var var_2908:Boolean;
        private var var_2963:int;
        private var var_2964:int;
        private var var_2965:int;
        private var var_2966:int;

        public function ModeratorUserInfoData(param1:IMessageDataWrapper)
        {
            this._userId = param1.readInteger();
            this._userName = param1.readString();
            this.var_2961 = param1.readInteger();
            this.var_2962 = param1.readInteger();
            this.var_2908 = param1.readBoolean();
            this.var_2963 = param1.readInteger();
            this.var_2964 = param1.readInteger();
            this.var_2965 = param1.readInteger();
            this.var_2966 = param1.readInteger();
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get minutesSinceRegistration():int
        {
            return (this.var_2961);
        }

        public function get minutesSinceLastLogin():int
        {
            return (this.var_2962);
        }

        public function get online():Boolean
        {
            return (this.var_2908);
        }

        public function get cfhCount():int
        {
            return (this.var_2963);
        }

        public function get abusiveCfhCount():int
        {
            return (this.var_2964);
        }

        public function get cautionCount():int
        {
            return (this.var_2965);
        }

        public function get banCount():int
        {
            return (this.var_2966);
        }

    }
}