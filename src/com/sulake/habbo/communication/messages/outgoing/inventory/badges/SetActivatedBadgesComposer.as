package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetActivatedBadgesComposer implements IMessageComposer
    {

        private const var_3088: int = 5;

        private var var_3087: Array;

        public function SetActivatedBadgesComposer()
        {
            this.var_3087 = [];
        }

        public function addActivatedBadge(param1: String): void
        {
            if (this.var_3087.length >= this.var_3088)
            {
                return;
            }

            this.var_3087.push(param1);
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            var _loc1_: Array = [];
            var _loc2_: int = 1;
            while (_loc2_ <= this.var_3088)
            {
                if (_loc2_ <= this.var_3087.length)
                {
                    _loc1_.push(_loc2_);
                    _loc1_.push(this.var_3087[(_loc2_ - 1)]);
                }
                else
                {
                    _loc1_.push(_loc2_);
                    _loc1_.push("");
                }

                _loc2_++;
            }

            return _loc1_;
        }

    }
}
