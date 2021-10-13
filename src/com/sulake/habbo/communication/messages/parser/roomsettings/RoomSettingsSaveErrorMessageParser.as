package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsSaveErrorMessageParser implements IMessageParser 
    {

        public static const var_1696:int = 1;
        public static const var_1697:int = 2;
        public static const var_1698:int = 3;
        public static const var_1699:int = 4;
        public static const var_1695:int = 5;
        public static const var_1700:int = 6;
        public static const var_1690:int = 7;
        public static const var_1691:int = 8;
        public static const var_1701:int = 9;
        public static const var_1692:int = 10;
        public static const var_1693:int = 11;
        public static const var_1694:int = 12;

        private var _roomId:int;
        private var var_2102:int;
        private var var_2671:String;

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._roomId = param1.readInteger();
            this.var_2102 = param1.readInteger();
            this.var_2671 = param1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get errorCode():int
        {
            return (this.var_2102);
        }

        public function get info():String
        {
            return (this.var_2671);
        }

    }
}