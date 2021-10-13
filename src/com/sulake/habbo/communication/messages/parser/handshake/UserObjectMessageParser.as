package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserObjectMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _name:String;
        private var var_2534:String;
        private var var_3044:String;
        private var var_3175:String;
        private var var_2912:String;
        private var var_3176:int;
        private var var_3177:String;
        private var var_3178:int;
        private var var_3179:int;
        private var var_3180:int;
        private var _respectLeft:int;
        private var var_3181:int;
        private var var_3182:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = int(param1.readString());
            this._name = param1.readString();
            this.var_2534 = param1.readString();
            this.var_3044 = param1.readString();
            this.var_3175 = param1.readString();
            this.var_2912 = param1.readString();
            this.var_3176 = param1.readInteger();
            this.var_3177 = param1.readString();
            this.var_3178 = param1.readInteger();
            this.var_3179 = param1.readInteger();
            this.var_3180 = param1.readInteger();
            this._respectLeft = param1.readInteger();
            this.var_3181 = param1.readInteger();
            this.var_3182 = param1.readInteger();
            return (true);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get sex():String
        {
            return (this.var_3044);
        }

        public function get customData():String
        {
            return (this.var_3175);
        }

        public function get realName():String
        {
            return (this.var_2912);
        }

        public function get tickets():int
        {
            return (this.var_3176);
        }

        public function get poolFigure():String
        {
            return (this.var_3177);
        }

        public function get photoFilm():int
        {
            return (this.var_3178);
        }

        public function get directMail():int
        {
            return (this.var_3179);
        }

        public function get respectTotal():int
        {
            return (this.var_3180);
        }

        public function get respectLeft():int
        {
            return (this._respectLeft);
        }

        public function get petRespectLeft():int
        {
            return (this.var_3181);
        }

        public function get identityId():int
        {
            return (this.var_3182);
        }

    }
}