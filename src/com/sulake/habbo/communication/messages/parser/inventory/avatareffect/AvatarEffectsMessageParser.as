package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectsMessageParser implements IMessageParser
    {

        private var _effects: Array;

        public function flush(): Boolean
        {
            this._effects = null;

            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._effects = [];
            var effect: AvatarEffect;
            var effectCount: int = param1.readInteger();
            var i: int;
            
            while (i < effectCount)
            {
                effect = new AvatarEffect();
                
                effect.type = param1.readInteger();
                effect.duration = param1.readInteger();
                effect.inactiveEffectsInInventory = param1.readInteger();
                effect.secondsLeftIfActive = param1.readInteger();
                
                this._effects.push(effect);
                i++;
            }
            
            return true;
        }

        public function get effects(): Array
        {
            return this._effects;
        }

    }
}
