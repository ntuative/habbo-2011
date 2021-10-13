package 
{
    import mx.core.SimpleApplication;
    import com.sulake.room.RoomManager;
    import com.sulake.iid.IIDRoomManager;

    public class RoomManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = RoomManagerLib_manifest;
        public static var RoomManager:Class = com.sulake.room.RoomManager;
        public static var IIDRoomEngine:Class = IIDRoomManager;

    }
}