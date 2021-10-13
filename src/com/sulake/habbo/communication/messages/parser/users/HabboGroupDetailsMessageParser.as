package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsMessageParser implements IMessageParser 
    {

        private var var_3351:int = -1;
        private var _name:String = "";
        private var var_2400:String = "";
        private var _roomId:int = -1;
        private var var_2970:String = "";

        public function flush():Boolean
        {
            this.var_3351 = -1;
            this._name = "";
            this.var_2400 = "";
            this._roomId = -1;
            this.var_2970 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3351 = param1.readInteger();
            if (this.var_3351 != -1)
            {
                this._name = param1.readString();
                this.var_2400 = param1.readString();
                this._roomId = param1.readInteger();
                this.var_2970 = param1.readString();
            };
            return (true);
        }

        public function get groupId():int
        {
            return (this.var_3351);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get description():String
        {
            return (this.var_2400);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomName():String
        {
            return (this.var_2970);
        }

    }
}