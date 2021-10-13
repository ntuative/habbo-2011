package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageData 
    {

        private var var_3020:String;
        private var var_3021:int;
        private var var_3022:int;
        private var var_2831:int;
        private var _id:int;
        private var var_3023:Boolean;
        private var _type:String;
        private var var_3024:String;
        private var var_3025:int;
        private var var_3026:String;
        private var var_3027:int;
        private var var_3028:int;

        public function QuestMessageData(param1:IMessageDataWrapper)
        {
            this.var_3020 = param1.readString();
            this.var_3021 = param1.readInteger();
            this.var_3022 = param1.readInteger();
            this.var_2831 = param1.readInteger();
            this._id = param1.readInteger();
            this.var_3023 = param1.readBoolean();
            this._type = param1.readString();
            this.var_3024 = param1.readString();
            this.var_3025 = param1.readInteger();
            this.var_3026 = param1.readString();
            this.var_3027 = param1.readInteger();
            this.var_3028 = param1.readInteger();
        }

        public function dispose():void
        {
            this._id = 0;
            this._type = "";
            this.var_3024 = "";
            this.var_3025 = 0;
        }

        public function get campaignCode():String
        {
            return (this.var_3020);
        }

        public function get completedQuestsInCampaign():int
        {
            return (this.var_3021);
        }

        public function get questCountInCampaign():int
        {
            return (this.var_3022);
        }

        public function get activityPointType():int
        {
            return (this.var_2831);
        }

        public function get accepted():Boolean
        {
            return (this.var_3023);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get roomItemTypeName():String
        {
            return (this.var_3024);
        }

        public function get rewardCurrencyAmount():int
        {
            return (this.var_3025);
        }

        public function get localizationCode():String
        {
            return (this.var_3026);
        }

        public function get completedSteps():int
        {
            return (this.var_3027);
        }

        public function get totalSteps():int
        {
            return (this.var_3028);
        }

    }
}