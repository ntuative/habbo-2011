package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const RORMUM_ADD_MASK: String = "RORMUM_ADD_MASK";
        public static const RORMUM_ADD_MASK2: String = "RORMUM_ADD_MASK";
        public static const DOOR: String = "door";
        public static const WINDOW: String = "window";
        public static const HOLE: String = "hole";

        private var _type: String = "";
        private var _maskId: String = "";
        private var _maskType: String = "";
        private var _maskLocation: Vector3d = null;
        private var _maskCategory: String = "window";

        public function RoomObjectRoomMaskUpdateMessage(type: String, maskId: String, maskType: String = null, maskLocation: IVector3d = null, maskCategory: String = "window")
        {
            super(null, null);
            this._type = type;
            this._maskId = maskId;
            this._maskType = maskType;
            
            if (maskLocation != null)
            {
                this._maskLocation = new Vector3d(maskLocation.x, maskLocation.y, maskLocation.z);
            }

            this._maskCategory = maskCategory;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get maskId(): String
        {
            return this._maskId;
        }

        public function get maskType(): String
        {
            return this._maskType;
        }

        public function get maskLocation(): IVector3d
        {
            return this._maskLocation;
        }

        public function get maskCategory(): String
        {
            return this._maskCategory;
        }

    }
}
