package com.sulake.habbo.communication.messages.outgoing.tracking
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class LatencyPingReportMessageComposer implements IMessageComposer
    {

        private var var_3110: int;
        private var var_3111: int;
        private var var_3112: int;

        public function LatencyPingReportMessageComposer(param1: int, param2: int, param3: int)
        {
            this.var_3110 = param1;
            this.var_3111 = param2;
            this.var_3112 = param3;
        }

        public function getMessageArray(): Array
        {
            return [this.var_3110, this.var_3111, this.var_3112];
        }

        public function dispose(): void
        {
        }

    }
}
