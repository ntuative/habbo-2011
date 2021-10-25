package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TriggerDefinition extends Triggerable
    {

        private var _code: int;
        private var _conflictingActions: Array = [];

        public function TriggerDefinition(data: IMessageDataWrapper)
        {
            super(data);

            this._code = data.readInteger();
            
            var conflictingActionCount: int = data.readInteger();
            var i: int;
            
            while (i < conflictingActionCount)
            {
                this._conflictingActions.push(data.readInteger());
                i++;
            }

        }

        public function get triggerConf(): int
        {
            return this._code;
        }

        override public function get code(): int
        {
            return this._code;
        }

        public function get conflictingActions(): Array
        {
            return this._conflictingActions;
        }

    }
}
