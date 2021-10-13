package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEntryInfoMessageParser implements IMessageParser 
    {

        private var var_3302:Boolean;
        private var var_3303:int;
        private var var_2197:Boolean;
        private var var_3304:PublicRoomShortData;

        public function get guestRoom():Boolean
        {
            return (this.var_3302);
        }

        public function get guestRoomId():int
        {
            return (this.var_3303);
        }

        public function get publicSpace():PublicRoomShortData
        {
            return (this.var_3304);
        }

        public function get owner():Boolean
        {
            return (this.var_2197);
        }

        public function flush():Boolean
        {
            if (this.var_3304 != null)
            {
                this.var_3304.dispose();
                this.var_3304 = null;
            };
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3302 = param1.readBoolean();
            if (this.var_3302)
            {
                this.var_3303 = param1.readInteger();
                this.var_2197 = param1.readBoolean();
            }
            else
            {
                this.var_3304 = new PublicRoomShortData(param1);
            };
            return (true);
        }

    }
}