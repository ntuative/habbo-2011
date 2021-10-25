package
{

    import mx.core.SimpleApplication;

    import com.sulake.habbo.session.SessionDataManager;
    import com.sulake.iid.IIDSessionDataManager;

    public class HabboSessionDataManagerLib extends SimpleApplication
    {

        public static var manifest: Class = HabboSessionDataManagerLib_manifest;
        public static var SessionDataManager: Class = com.sulake.habbo.session.SessionDataManager;
        public static var IIDSessionDataManager: Class = com.sulake.iid.IIDSessionDataManager;
        public static var loading_icon: Class = HabboSessionDataManagerLib_loading_icon;
        public static var group_info: Class = HabboSessionDataManagerLib_group_info;

    }
}
