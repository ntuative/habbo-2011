package 
{
    import mx.core.SimpleApplication;
    import com.sulake.room.renderer.RoomRendererFactory;
    import com.sulake.iid.IIDRoomRendererFactory;

    public class RoomSpriteRendererLib extends SimpleApplication 
    {

        public static var manifest:Class = RoomSpriteRendererLib_manifest;
        public static var RoomSpriteRendererFactory:Class = RoomRendererFactory;
        public static var IIDRoomSpriteRendererFactory:Class = IIDRoomRendererFactory;

    }
}