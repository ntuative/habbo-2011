package com.sulake.habbo.communication.messages.incoming.handshake
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.HelloMessageParser;

    public class HelloMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function HelloMessageEvent(param1: Function)
        {
            super(param1, HelloMessageParser);
        }

        public function get x(): int
        {
            return (this._parser as HelloMessageParser).x;
        }

    }
}
