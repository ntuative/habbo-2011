package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboActivityPointNotificationMessageParser implements IMessageParser 
    {

        private var var_3266:int = 0;
        private var var_3267:int = 0;
        private var _type:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3266 = param1.readInteger();
            this.var_3267 = param1.readInteger();
            this._type = param1.readInteger();
            return (true);
        }

        public function get amount():int
        {
            return (this.var_3266);
        }

        public function get change():int
        {
            return (this.var_3267);
        }

        public function get type():int
        {
            return (this._type);
        }

    }
}