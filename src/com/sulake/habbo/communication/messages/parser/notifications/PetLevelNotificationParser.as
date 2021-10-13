package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetLevelNotificationParser implements IMessageParser 
    {

        private var var_3097:int;
        private var var_3100:String;
        private var var_2924:int;
        private var var_2603:int;
        private var var_2517:int;
        private var _color:String;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3097 = param1.readInteger();
            this.var_3100 = param1.readString();
            this.var_2924 = param1.readInteger();
            this.var_2603 = param1.readInteger();
            this.var_2517 = param1.readInteger();
            this._color = param1.readString();
            return (true);
        }

        public function get petId():int
        {
            return (this.var_3097);
        }

        public function get petName():String
        {
            return (this.var_3100);
        }

        public function get level():int
        {
            return (this.var_2924);
        }

        public function get petType():int
        {
            return (this.var_2603);
        }

        public function get breed():int
        {
            return (this.var_2517);
        }

        public function get color():String
        {
            return (this._color);
        }

    }
}