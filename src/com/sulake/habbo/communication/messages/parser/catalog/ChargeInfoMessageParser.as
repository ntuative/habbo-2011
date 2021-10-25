package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfoMessageParser implements IMessageParser
    {

        private var _chartInfo: ChargeInfo;

        public function flush(): Boolean
        {
            this._chartInfo = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._chartInfo = new ChargeInfo(data);

            return true;
        }

        public function get chargeInfo(): ChargeInfo
        {
            return this._chartInfo;
        }

    }
}
