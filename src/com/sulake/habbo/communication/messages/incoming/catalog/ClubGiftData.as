package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftData 
    {

        private var _offerId:int;
        private var var_2903:Boolean;
        private var var_2513:Boolean;
        private var var_2904:int;

        public function ClubGiftData(param1:IMessageDataWrapper)
        {
            this._offerId = param1.readInteger();
            this.var_2903 = param1.readBoolean();
            this.var_2904 = param1.readInteger();
            this.var_2513 = param1.readBoolean();
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get isVip():Boolean
        {
            return (this.var_2903);
        }

        public function get isSelectable():Boolean
        {
            return (this.var_2513);
        }

        public function get daysRequired():int
        {
            return (this.var_2904);
        }

    }
}