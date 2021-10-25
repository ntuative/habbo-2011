package com.sulake.habbo.communication.messages.incoming.recycler
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageParser;

    public class RecyclerStatusMessageEvent extends MessageEvent implements IMessageEvent
    {

        public static const var_644: int = 1;
        public static const var_645: int = 2;
        public static const var_646: int = 3;

        public function RecyclerStatusMessageEvent(param1: Function)
        {
            super(param1, RecyclerStatusMessageParser);
        }

        public function getParser(): RecyclerStatusMessageParser
        {
            return _parser as RecyclerStatusMessageParser;
        }

    }
}
