package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageRequestedMessageParser implements IMessageParser 
    {

        private var var_2358:int = -1;
        private var var_2603:int = -1;
        private var var_2517:int = -1;
        private var _color:String = "";

        public function get objectId():int
        {
            return (this.var_2358);
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

        public function flush():Boolean
        {
            this.var_2358 = -1;
            this.var_2603 = -1;
            this.var_2517 = -1;
            this._color = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_2358 = param1.readInteger();
            this.var_2603 = param1.readInteger();
            this.var_2517 = param1.readInteger();
            this._color = param1.readString();
            return (true);
        }

    }
}