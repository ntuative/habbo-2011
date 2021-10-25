package com.sulake.habbo.communication.messages.outgoing.quest
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class StartCampaignMessageComposer implements IMessageComposer
    {

        private var _data: Array = [];

        public function StartCampaignMessageComposer(param1: String)
        {
            this._data.push(param1);
        }

        public function getMessageArray(): Array
        {
            return this._data;
        }

        public function dispose(): void
        {
            this._data = null;
        }

    }
}
