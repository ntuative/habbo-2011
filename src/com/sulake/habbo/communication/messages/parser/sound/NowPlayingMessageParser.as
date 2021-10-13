package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NowPlayingMessageParser implements IMessageParser 
    {

        private var var_3339:int;
        private var _currentPosition:int;
        private var var_3340:int;
        private var var_3341:int;
        private var var_3342:int;

        public function get currentSongId():int
        {
            return (this.var_3339);
        }

        public function get currentPosition():int
        {
            return (this._currentPosition);
        }

        public function get nextSongId():int
        {
            return (this.var_3340);
        }

        public function get nextPosition():int
        {
            return (this.var_3341);
        }

        public function get syncCount():int
        {
            return (this.var_3342);
        }

        public function flush():Boolean
        {
            this.var_3339 = -1;
            this._currentPosition = -1;
            this.var_3340 = -1;
            this.var_3341 = -1;
            this.var_3342 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3339 = param1.readInteger();
            this._currentPosition = param1.readInteger();
            this.var_3340 = param1.readInteger();
            this.var_3341 = param1.readInteger();
            this.var_3342 = param1.readInteger();
            return (true);
        }

    }
}