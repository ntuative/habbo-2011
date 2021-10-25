package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActionDefinition extends Triggerable
    {

        private var _type: int;
        private var _delayInPulses: int;
        private var _conflictingTriggers: Array = [];

        public function ActionDefinition(data: IMessageDataWrapper)
        {
            super(data);

            this._type = data.readInteger();
            this._delayInPulses = data.readInteger();
            
            var conflictingTriggerCount: int = data.readInteger();
            var i: int;
            
            while (i < conflictingTriggerCount)
            {
                this._conflictingTriggers.push(data.readInteger());
                i++;
            }

        }

        public function get type(): int
        {
            return this._type;
        }

        override public function get code(): int
        {
            return this._type;
        }

        public function get delayInPulses(): int
        {
            return this._delayInPulses;
        }

        public function get conflictingTriggers(): Array
        {
            return this._conflictingTriggers;
        }

    }
}
