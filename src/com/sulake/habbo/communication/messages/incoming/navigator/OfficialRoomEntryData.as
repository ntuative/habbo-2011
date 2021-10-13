package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomEntryData implements IDisposable 
    {

        public static const var_1703:int = 1;
        public static const var_910:int = 2;
        public static const var_911:int = 3;
        public static const var_909:int = 4;

        private var _index:int;
        private var var_2991:String;
        private var var_2992:String;
        private var var_2993:Boolean;
        private var var_2994:String;
        private var var_2995:String;
        private var var_2996:int;
        private var var_2973:int;
        private var _type:int;
        private var var_2997:String;
        private var var_2998:GuestRoomData;
        private var var_2999:PublicRoomData;
        private var _open:Boolean;
        private var _disposed:Boolean;

        public function OfficialRoomEntryData(param1:IMessageDataWrapper)
        {
            this._index = param1.readInteger();
            this.var_2991 = param1.readString();
            this.var_2992 = param1.readString();
            this.var_2993 = (param1.readInteger() == 1);
            this.var_2994 = param1.readString();
            this.var_2995 = param1.readString();
            this.var_2996 = param1.readInteger();
            this.var_2973 = param1.readInteger();
            this._type = param1.readInteger();
            if (this._type == var_1703)
            {
                this.var_2997 = param1.readString();
            }
            else
            {
                if (this._type == var_911)
                {
                    this.var_2999 = new PublicRoomData(param1);
                }
                else
                {
                    if (this._type == var_910)
                    {
                        this.var_2998 = new GuestRoomData(param1);
                    }
                    else
                    {
                        this._open = param1.readBoolean();
                    };
                };
            };
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_2998 != null)
            {
                this.var_2998.dispose();
                this.var_2998 = null;
            };
            if (this.var_2999 != null)
            {
                this.var_2999.dispose();
                this.var_2999 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get popupCaption():String
        {
            return (this.var_2991);
        }

        public function get popupDesc():String
        {
            return (this.var_2992);
        }

        public function get showDetails():Boolean
        {
            return (this.var_2993);
        }

        public function get picText():String
        {
            return (this.var_2994);
        }

        public function get picRef():String
        {
            return (this.var_2995);
        }

        public function get folderId():int
        {
            return (this.var_2996);
        }

        public function get tag():String
        {
            return (this.var_2997);
        }

        public function get userCount():int
        {
            return (this.var_2973);
        }

        public function get guestRoomData():GuestRoomData
        {
            return (this.var_2998);
        }

        public function get publicRoomData():PublicRoomData
        {
            return (this.var_2999);
        }

        public function get open():Boolean
        {
            return (this._open);
        }

        public function toggleOpen():void
        {
            this._open = (!(this._open));
        }

        public function get maxUsers():int
        {
            if (this.type == var_1703)
            {
                return (0);
            };
            if (this.type == var_910)
            {
                return (this.var_2998.maxUserCount);
            };
            if (this.type == var_911)
            {
                return (this.var_2999.maxUsers);
            };
            return (0);
        }

    }
}