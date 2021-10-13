package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultData 
    {

        private var var_2916:int;
        private var var_2917:String;
        private var var_2918:String;
        private var var_2919:Boolean;
        private var var_2920:Boolean;
        private var var_2921:int;
        private var var_2922:String;
        private var var_2923:String;
        private var var_2912:String;

        public function HabboSearchResultData(param1:IMessageDataWrapper)
        {
            this.var_2916 = param1.readInteger();
            this.var_2917 = param1.readString();
            this.var_2918 = param1.readString();
            this.var_2919 = param1.readBoolean();
            this.var_2920 = param1.readBoolean();
            param1.readString();
            this.var_2921 = param1.readInteger();
            this.var_2922 = param1.readString();
            this.var_2923 = param1.readString();
            this.var_2912 = param1.readString();
        }

        public function get avatarId():int
        {
            return (this.var_2916);
        }

        public function get avatarName():String
        {
            return (this.var_2917);
        }

        public function get avatarMotto():String
        {
            return (this.var_2918);
        }

        public function get isAvatarOnline():Boolean
        {
            return (this.var_2919);
        }

        public function get canFollow():Boolean
        {
            return (this.var_2920);
        }

        public function get avatarGender():int
        {
            return (this.var_2921);
        }

        public function get avatarFigure():String
        {
            return (this.var_2922);
        }

        public function get lastOnlineDate():String
        {
            return (this.var_2923);
        }

        public function get realName():String
        {
            return (this.var_2912);
        }

    }
}