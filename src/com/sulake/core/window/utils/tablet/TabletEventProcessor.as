package com.sulake.core.window.utils.tablet
{

    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.window.utils.IEventQueue;

    public class TabletEventProcessor extends MouseEventProcessor
    {

        private var var_2292: String = "";

        override public function process(param1: EventProcessorState, param2: IEventQueue): void
        {
            if (param2.length == 0)
            {
                return;
            }

            var_2060 = param1.desktop;
            var_2059 = (param1.var_1766 as WindowController);
            var_2058 = (param1.var_1767 as WindowController);
            var_1063 = param1.renderer;
            var_2061 = param1.var_1768;
            param2.begin();
            param2.end();
            param1.desktop = var_2060;
            param1.var_1766 = var_2059;
            param1.var_1767 = var_2058;
            param1.renderer = var_1063;
            param1.var_1768 = var_2061;
        }

    }
}
