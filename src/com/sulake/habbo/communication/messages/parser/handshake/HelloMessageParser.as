package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HelloMessageParser implements IMessageParser 
    {

        protected var _x:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._x = 200;
            return (true);
        }

        public function get x():int
        {
            return (this._x);
        }

    }
}