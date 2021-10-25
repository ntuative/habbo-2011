package com.sulake.habbo.communication.messages.incoming.quest
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageData
    {

        private var _campaignCode: String;
        private var _completedQuestsInCampaign: int;
        private var _questCountInCampaign: int;
        private var _activityPointType: int;
        private var _id: int;
        private var _accepted: Boolean;
        private var _type: String;
        private var _roomItemTypeName: String;
        private var _rewardCurrencyAmount: int;
        private var _localizationCode: String;
        private var _completedSteps: int;
        private var _totalSteps: int;

        public function QuestMessageData(param1: IMessageDataWrapper)
        {
            this._campaignCode = param1.readString();
            this._completedQuestsInCampaign = param1.readInteger();
            this._questCountInCampaign = param1.readInteger();
            this._activityPointType = param1.readInteger();
            this._id = param1.readInteger();
            this._accepted = param1.readBoolean();
            this._type = param1.readString();
            this._roomItemTypeName = param1.readString();
            this._rewardCurrencyAmount = param1.readInteger();
            this._localizationCode = param1.readString();
            this._completedSteps = param1.readInteger();
            this._totalSteps = param1.readInteger();
        }

        public function dispose(): void
        {
            this._id = 0;
            this._type = "";
            this._roomItemTypeName = "";
            this._rewardCurrencyAmount = 0;
        }

        public function get campaignCode(): String
        {
            return this._campaignCode;
        }

        public function get completedQuestsInCampaign(): int
        {
            return this._completedQuestsInCampaign;
        }

        public function get questCountInCampaign(): int
        {
            return this._questCountInCampaign;
        }

        public function get activityPointType(): int
        {
            return this._activityPointType;
        }

        public function get accepted(): Boolean
        {
            return this._accepted;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get roomItemTypeName(): String
        {
            return this._roomItemTypeName;
        }

        public function get rewardCurrencyAmount(): int
        {
            return this._rewardCurrencyAmount;
        }

        public function get localizationCode(): String
        {
            return this._localizationCode;
        }

        public function get completedSteps(): int
        {
            return this._completedSteps;
        }

        public function get totalSteps(): int
        {
            return this._totalSteps;
        }

    }
}
