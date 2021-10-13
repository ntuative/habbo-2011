package com.sulake.habbo.communication.messages.parser.facebook
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaceBookAppRequestMessageParser implements IMessageParser 
    {

        private var var_3141:String;
        private var _data:String;
        private var var_3142:String;
        private var var_3143:int;

        public function get authToken():String
        {
            return (this.var_3141);
        }

        public function get data():String
        {
            return (this._data);
        }

        public function get userFilter():String
        {
            return (this.var_3142);
        }

        public function get senderReference():int
        {
            return (this.var_3143);
        }

        public function flush():Boolean
        {
            this.var_3141 = (this._data = (this.var_3142 = null));
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3141 = param1.readString();
            this._data = param1.readString();
            this.var_3142 = param1.readString();
            this.var_3143 = param1.readInteger();
            return (true);
        }

    }
}