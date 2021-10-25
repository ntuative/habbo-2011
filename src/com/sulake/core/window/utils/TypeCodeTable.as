package com.sulake.core.window.utils
{

    import com.sulake.core.window.enum.WindowType;

    import flash.utils.Dictionary;

    public class TypeCodeTable extends WindowType
    {

        public static function fillTables(param1: Dictionary, param2: Dictionary = null): void
        {
            var _loc3_: String;
            param1["background"] = var_884;
            param1["bitmap"] = var_885;
            param1["border"] = var_891;
            param1["border_notify"] = var_1074;
            param1["button"] = var_864;
            param1["button_thick"] = var_865;
            param1["button_icon"] = var_1079;
            param1["button_group_left"] = var_892;
            param1["button_group_center"] = var_893;
            param1["button_group_right"] = var_894;
            param1["canvas"] = var_873;
            param1["checkbox"] = var_879;
            param1["closebutton"] = var_994;
            param1["container"] = var_868;
            param1["container_button"] = var_870;
            param1["display_object_wrapper"] = var_887;
            param1["dropmenu"] = var_871;
            param1["dropmenu_item"] = var_872;
            param1["frame"] = var_848;
            param1["frame_notify"] = var_1077;
            param1["header"] = var_866;
            param1["html"] = var_996;
            param1["icon"] = var_997;
            param1["itemgrid"] = var_999;
            param1["itemgrid_horizontal"] = var_853;
            param1["itemgrid_vertical"] = var_855;
            param1["itemlist"] = var_998;
            param1["itemlist_horizontal"] = var_850;
            param1["itemlist_vertical"] = var_851;
            param1["label"] = WINDOW_TYPE_LABEL;
            param1["maximizebox"] = var_1085;
            param1["menu"] = var_1087;
            param1["menu_item"] = var_1088;
            param1["submenu"] = var_1089;
            param1["minimizebox"] = var_1084;
            param1["notify"] = var_1070;
            param1["null"] = var_847;
            param1["password"] = var_889;
            param1["radiobutton"] = var_877;
            param1["region"] = var_1000;
            param1["restorebox"] = var_1086;
            param1["scaler"] = var_204;
            param1["scaler_horizontal"] = var_1094;
            param1["scaler_vertical"] = var_1093;
            param1["scrollbar_horizontal"] = var_856;
            param1["scrollbar_vertical"] = var_857;
            param1["scrollbar_slider_button_up"] = var_1001;
            param1["scrollbar_slider_button_down"] = var_1002;
            param1["scrollbar_slider_button_left"] = var_1003;
            param1["scrollbar_slider_button_right"] = var_1004;
            param1["scrollbar_slider_bar_horizontal"] = var_1005;
            param1["scrollbar_slider_bar_vertical"] = var_1006;
            param1["scrollbar_slider_track_horizontal"] = var_1007;
            param1["scrollbar_slider_track_vertical"] = var_1008;
            param1["scrollable_itemlist"] = var_1078;
            param1["scrollable_itemlist_vertical"] = var_205;
            param1["scrollable_itemlist_horizontal"] = var_861;
            param1["selector"] = var_874;
            param1["selector_list"] = var_876;
            param1["submenu"] = var_1089;
            param1["tab_button"] = var_880;
            param1["tab_container_button"] = var_1009;
            param1["tab_context"] = var_202;
            param1["tab_content"] = var_1010;
            param1["tab_selector"] = var_882;
            param1["text"] = var_213;
            param1["input"] = var_867;
            param1["toolbar"] = var_1069;
            param1["tooltip"] = var_203;
            if (param2 != null)
            {
                for (_loc3_ in param1)
                {
                    param2[param1[_loc3_]] = _loc3_;
                }

            }

        }

    }
}
