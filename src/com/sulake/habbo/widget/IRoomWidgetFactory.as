package com.sulake.habbo.widget
{

    import com.sulake.core.runtime.IUnknown;

    public interface IRoomWidgetFactory extends IUnknown
    {

        function createWidget(param1: String): IRoomWidget;

    }
}
