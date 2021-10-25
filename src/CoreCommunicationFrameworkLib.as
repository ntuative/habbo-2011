package
{

    import mx.core.SimpleApplication;

    import com.sulake.core.communication.CoreCommunicationManager;
    import com.sulake.iid.IIDCoreCommunicationManager;

    public class CoreCommunicationFrameworkLib extends SimpleApplication
    {

        public static var manifest: Class = CoreCommunicationFrameworkLib_manifest;
        public static var CoreCommunicationManager: Class = com.sulake.core.communication.CoreCommunicationManager;
        public static var IIDCoreCommunicationManager: Class = com.sulake.iid.IIDCoreCommunicationManager;

    }
}
