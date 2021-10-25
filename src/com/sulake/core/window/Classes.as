package com.sulake.core.window
{

    import flash.utils.Dictionary;

    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.components.ActivatorController;
    import com.sulake.core.window.components.BackgroundController;
    import com.sulake.core.window.components.BorderController;
    import com.sulake.core.window.components.ButtonController;
    import com.sulake.core.window.components.SelectableButtonController;
    import com.sulake.core.window.components.BitmapWrapperController;
    import com.sulake.core.window.components.CanvasController;
    import com.sulake.core.window.components.CheckBoxController;
    import com.sulake.core.window.components.ContainerController;
    import com.sulake.core.window.components.ContainerButtonController;
    import com.sulake.core.window.components.CloseButtonController;
    import com.sulake.core.window.components.DisplayObjectWrapperController;
    import com.sulake.core.window.components.ScrollbarLiftController;
    import com.sulake.core.window.components.DropMenuController;
    import com.sulake.core.window.components.DropMenuItemController;
    import com.sulake.core.window.components.FrameController;
    import com.sulake.core.window.components.HeaderController;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.window.components.IconController;
    import com.sulake.core.window.components.ItemListController;
    import com.sulake.core.window.components.ItemGridController;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.components.PasswordFieldController;
    import com.sulake.core.window.components.RadioButtonController;
    import com.sulake.core.window.components.RegionController;
    import com.sulake.core.window.components.ScalerController;
    import com.sulake.core.window.components.ScrollbarController;
    import com.sulake.core.window.components.ScrollableItemListWindow;
    import com.sulake.core.window.components.SelectorController;
    import com.sulake.core.window.components.TabSelectorController;
    import com.sulake.core.window.components.TabButtonController;
    import com.sulake.core.window.components.TabContainerButtonController;
    import com.sulake.core.window.components.TabContextController;
    import com.sulake.core.window.components.TextController;
    import com.sulake.core.window.components.TextFieldController;
    import com.sulake.core.window.components.ToolTipController;
    import com.sulake.core.window.components.*;

    public class Classes
    {

        protected static var var_992: Dictionary;

        public static function init(): void
        {
            if (!var_992)
            {
                var_992 = new Dictionary();
                var_992[WindowType.var_847] = WindowController;
                var_992[WindowType.var_993] = ActivatorController;
                var_992[WindowType.var_884] = BackgroundController;
                var_992[WindowType.var_891] = BorderController;
                var_992[WindowType.var_864] = ButtonController;
                var_992[WindowType.var_865] = ButtonController;
                var_992[WindowType.var_892] = SelectableButtonController;
                var_992[WindowType.var_893] = SelectableButtonController;
                var_992[WindowType.var_894] = SelectableButtonController;
                var_992[WindowType.var_885] = BitmapWrapperController;
                var_992[WindowType.var_873] = CanvasController;
                var_992[WindowType.var_879] = CheckBoxController;
                var_992[WindowType.var_868] = ContainerController;
                var_992[WindowType.var_870] = ContainerButtonController;
                var_992[WindowType.var_994] = CloseButtonController;
                var_992[WindowType.var_887] = DisplayObjectWrapperController;
                var_992[WindowType.var_995] = ScrollbarLiftController;
                var_992[WindowType.var_871] = DropMenuController;
                var_992[WindowType.var_872] = DropMenuItemController;
                var_992[WindowType.var_848] = FrameController;
                var_992[WindowType.var_866] = HeaderController;
                var_992[WindowType.var_996] = HTMLTextController;
                var_992[WindowType.var_997] = IconController;
                var_992[WindowType.var_998] = ItemListController;
                var_992[WindowType.var_850] = ItemListController;
                var_992[WindowType.var_851] = ItemListController;
                var_992[WindowType.var_999] = ItemGridController;
                var_992[WindowType.var_853] = ItemGridController;
                var_992[WindowType.var_855] = ItemGridController;
                var_992[WindowType.WINDOW_TYPE_LABEL] = TextLabelController;
                var_992[WindowType.var_889] = PasswordFieldController;
                var_992[WindowType.var_877] = RadioButtonController;
                var_992[WindowType.var_1000] = RegionController;
                var_992[WindowType.var_204] = ScalerController;
                var_992[WindowType.var_856] = ScrollbarController;
                var_992[WindowType.var_857] = ScrollbarController;
                var_992[WindowType.var_1001] = ButtonController;
                var_992[WindowType.var_1002] = ButtonController;
                var_992[WindowType.var_1003] = ButtonController;
                var_992[WindowType.var_1004] = ButtonController;
                var_992[WindowType.var_1005] = ScrollbarLiftController;
                var_992[WindowType.var_1006] = ScrollbarLiftController;
                var_992[WindowType.var_1007] = WindowController;
                var_992[WindowType.var_1008] = WindowController;
                var_992[WindowType.var_205] = ScrollableItemListWindow;
                var_992[WindowType.var_874] = SelectorController;
                var_992[WindowType.var_876] = TabSelectorController;
                var_992[WindowType.var_880] = TabButtonController;
                var_992[WindowType.var_1009] = TabContainerButtonController;
                var_992[WindowType.var_1010] = ContainerController;
                var_992[WindowType.var_202] = TabContextController;
                var_992[WindowType.var_882] = TabSelectorController;
                var_992[WindowType.var_213] = TextController;
                var_992[WindowType.var_867] = TextFieldController;
                var_992[WindowType.var_203] = ToolTipController;
            }

        }

        public static function getWindowClassByType(param1: uint): Class
        {
            return var_992[param1];
        }

    }
}
