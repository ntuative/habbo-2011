package com.sulake.core.runtime.exceptions
{
    import com.sulake.core.Core;

    public class CrashMeError extends Error 
    {

        public function CrashMeError()
        {
            super("An intentional crash triggered by the user", Core.var_87);
        }

    }
}