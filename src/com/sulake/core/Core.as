package com.sulake.core
{

    import com.sulake.core.runtime.ICore;
    import com.sulake.core.runtime.CoreComponentContext;

    import flash.display.DisplayObjectContainer;

    public final class Core
    {

        public static const CORE_SETUP_FRAME_UPDATE_SIMPLE: uint = 0;
        public static const CORE_SETUP_FRAME_UPDATE_COMPLEX: uint = 1;
        public static const CORE_SETUP_FRAME_UPDATE_PROFILER: uint = 2;
        public static const CORE_SETUP_FRAME_UPDATE_EXPERIMENTAL: uint = 4;
        public static const CORE_SETUP_FRAME_UPDATE_MASK: uint = 15;
        public static const CORE_SETUP_DEBUG: uint = 15;
        public static const ERROR_CATEGORY_DOWNLOAD_CONFIG: int = 1;
        public static const ERROR_CATEGORY_DOWNLOAD_LIBRARY: int = 2;
        public static const ERROR_CATEGORY_DOWNLOAD_ASSET: int = 3;
        public static const ERROR_CATEGORY_DOWNLOAD_CRITICAL_ASSET: int = 4;
        public static const ERROR_CATEGORY_DOWNLOAD_RESOURCE_FAILED: int = 5;
        public static const ERROR_CATEGORY_INTERFACE_UNAVAILABLE: int = 6;
        public static const ERROR_CATEGORY_UNKNOWN1: int = 7;
        public static const ERROR_CATEGORY_UNKNOWN2: int = 9;
        public static const ERROR_CATEGORY_PREPARE_CORE: int = 10;
        public static const ERROR_CATEGORY_UNKNOWN3: int = 11;
        public static const ERROR_CATEGORY_DOWNLOAD_EXTERNAL_VARS: int = 20;
        public static const ERROR_CATEGORY_UNKNOWN4: int = 21;
        public static const ERROR_CATEGORY_CONNECTION_INIT: int = 30;
        public static const ERROR_CATEGORY_INTENTIONAL_CRASH: int = 99;

        private static var _instance: ICore;

        public static function get version(): String
        {
            return "0.0.3";
        }

        public static function get instance(): ICore
        {
            return _instance;
        }

        public static function instantiate(container: DisplayObjectContainer, param2: uint): ICore
        {
            if (_instance == null)
            {
                _instance = new CoreComponentContext(container, param2);
            }


            return _instance;
        }

        public static function error(message: String, fatal: Boolean, category: int = -1, err: Error = null): void
        {
            if (_instance)
            {
                _instance.error(message, fatal, category, err);
            }

        }

        public static function warning(message: String): void
        {
            if (_instance)
            {
                _instance.warning(message);
            }

        }

        public static function debug(message: String): void
        {
            if (_instance)
            {
                _instance.debug(message);
            }

        }

        public static function crash(message: String, category: int, err: Error = null): void
        {
            if (_instance)
            {
                _instance.error(message, true, category, err);
            }

        }

        public static function dispose(): void
        {
            if (_instance != null)
            {
                _instance.dispose();
                _instance = null;
            }

        }

    }
}
