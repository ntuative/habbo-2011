package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementData 
    {

        private var _type:int;
        private var var_2924:int;
        private var var_2925:String;
        private var var_2926:int;
        private var var_2927:int;
        private var var_2928:int;
        private var var_2929:int;

        public function AchievementData(param1:IMessageDataWrapper)
        {
            this._type = param1.readInteger();
            this.var_2924 = param1.readInteger();
            this.var_2925 = param1.readString();
            this.var_2926 = param1.readInteger();
            this.var_2927 = param1.readInteger();
            this.var_2928 = param1.readInteger();
            this.var_2929 = param1.readInteger();
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get badgeId():String
        {
            return (this.var_2925);
        }

        public function get level():int
        {
            return (this.var_2924);
        }

        public function get scoreLimit():int
        {
            return (this.var_2926);
        }

        public function get levelRewardPoints():int
        {
            return (this.var_2927);
        }

        public function get levelRewardPointType():int
        {
            return (this.var_2928);
        }

        public function get currentPoints():int
        {
            return (this.var_2929);
        }

    }
}