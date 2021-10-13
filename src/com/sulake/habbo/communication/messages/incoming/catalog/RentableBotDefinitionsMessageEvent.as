package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.RentableBotDefinitionsMessageParser;

    public class RentableBotDefinitionsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RentableBotDefinitionsMessageEvent(param1:Function)
        {
            super(param1, RentableBotDefinitionsMessageParser);
        }

        public function getParser():RentableBotDefinitionsMessageParser
        {
            return (var_361 as RentableBotDefinitionsMessageParser);
        }

    }
}