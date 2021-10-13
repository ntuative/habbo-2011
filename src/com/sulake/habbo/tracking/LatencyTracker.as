package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class LatencyTracker 
    {

        private var _state:Boolean = false;
        private var var_2063:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var var_4596:int = 0;
        private var var_4597:int = 0;
        private var var_4598:int = 0;
        private var var_4599:int = 0;
        private var var_4600:int = 0;
        private var var_4601:int = 0;
        private var var_4602:Array;
        private var var_4603:Map;

        public function set configuration(param1:IHabboConfigurationManager):void
        {
            this.var_2063 = param1;
        }

        public function set communication(param1:IHabboCommunicationManager):void
        {
            this._communication = param1;
        }

        public function set connection(param1:IConnection):void
        {
            this._connection = param1;
        }

        public function dispose():void
        {
            this._state = false;
            this.var_2063 = null;
            this._communication = null;
            this._connection = null;
            if (this.var_4603 != null)
            {
                this.var_4603.dispose();
                this.var_4603 = null;
            };
            this.var_4602 = null;
        }

        public function init():void
        {
            if ((((this.var_2063 == null) || (this._communication == null)) || (this._connection == null)))
            {
                return;
            };
            this.var_4597 = int(this.var_2063.getKey("latencytest.interval"));
            this.var_4598 = int(this.var_2063.getKey("latencytest.report.index"));
            this.var_4599 = int(this.var_2063.getKey("latencytest.report.delta"));
            this._communication.addHabboConnectionMessageEvent(new LatencyPingResponseMessageEvent(this.onPingResponse));
            if (this.var_4597 < 1)
            {
                return;
            };
            this.var_4603 = new Map();
            this.var_4602 = new Array();
            this._state = true;
        }

        public function update(param1:uint, param2:int):void
        {
            if (!this._state)
            {
                return;
            };
            if ((param2 - this.var_4600) > this.var_4597)
            {
                this.testLatency();
            };
        }

        private function testLatency():void
        {
            this.var_4600 = getTimer();
            this.var_4603.add(this.var_4596, this.var_4600);
            this._connection.send(new LatencyPingRequestMessageComposer(this.var_4596));
            this.var_4596++;
        }

        private function onPingResponse(param1:IMessageEvent):void
        {
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:LatencyPingReportMessageComposer;
            if (((this.var_4603 == null) || (this.var_4602 == null)))
            {
                return;
            };
            var _loc2_:LatencyPingResponseMessageParser = (param1 as LatencyPingResponseMessageEvent).getParser();
            var _loc3_:int = this.var_4603.getValue(_loc2_.requestId);
            this.var_4603.remove(_loc2_.requestId);
            var _loc4_:int = (getTimer() - _loc3_);
            this.var_4602.push(_loc4_);
            if (((this.var_4602.length == this.var_4598) && (this.var_4598 > 0)))
            {
                _loc5_ = 0;
                _loc6_ = 0;
                _loc7_ = 0;
                _loc8_ = 0;
                while (_loc8_ < this.var_4602.length)
                {
                    _loc5_ = (_loc5_ + this.var_4602[_loc8_]);
                    _loc8_++;
                };
                _loc9_ = int((_loc5_ / this.var_4602.length));
                _loc8_ = 0;
                while (_loc8_ < this.var_4602.length)
                {
                    if (this.var_4602[_loc8_] < (_loc9_ * 2))
                    {
                        _loc6_ = (_loc6_ + this.var_4602[_loc8_]);
                        _loc7_++;
                    };
                    _loc8_++;
                };
                if (_loc7_ == 0)
                {
                    this.var_4602 = [];
                    return;
                };
                _loc10_ = int((_loc6_ / _loc7_));
                if (((Math.abs((_loc9_ - this.var_4601)) > this.var_4599) || (this.var_4601 == 0)))
                {
                    this.var_4601 = _loc9_;
                    _loc11_ = new LatencyPingReportMessageComposer(_loc9_, _loc10_, this.var_4602.length);
                    this._connection.send(_loc11_);
                };
                this.var_4602 = [];
            };
        }

    }
}