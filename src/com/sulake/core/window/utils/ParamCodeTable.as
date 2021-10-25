package com.sulake.core.window.utils
{

    import com.sulake.core.window.enum.WindowParam;

    import flash.utils.Dictionary;

    public class ParamCodeTable extends WindowParam
    {

        public static function fillTables(param1: Dictionary, param2: Dictionary = null): void
        {
            var _loc3_: String;
            param1["null"] = var_694;
            param1["bound_to_parent_rect"] = var_691;
            param1["child_window"] = var_712;
            param1["embedded_controller"] = var_713;
            param1["resize_to_accommodate_children"] = var_706;
            param1["input_event_processor"] = var_593;
            param1["internal_event_handling"] = var_696;
            param1["mouse_dragging_target"] = var_148;
            param1["mouse_dragging_trigger"] = var_671;
            param1["mouse_scaling_target"] = var_675;
            param1["mouse_scaling_trigger"] = var_674;
            param1["horizontal_mouse_scaling_trigger"] = var_672;
            param1["vertical_mouse_scaling_trigger"] = var_673;
            param1["observe_parent_input_events"] = var_695;
            param1["optimize_region_to_layout_size"] = var_690;
            param1["parent_window"] = var_711;
            param1["relative_horizontal_scale_center"] = var_666;
            param1["relative_horizontal_scale_fixed"] = var_663;
            param1["relative_horizontal_scale_move"] = var_664;
            param1["relative_horizontal_scale_strech"] = var_665;
            param1["relative_scale_center"] = var_702;
            param1["relative_scale_fixed"] = var_699;
            param1["relative_scale_move"] = var_700;
            param1["relative_scale_strech"] = var_701;
            param1["relative_vertical_scale_center"] = var_670;
            param1["relative_vertical_scale_fixed"] = var_667;
            param1["relative_vertical_scale_move"] = var_668;
            param1["relative_vertical_scale_strech"] = var_669;
            param1["on_resize_align_left"] = var_682;
            param1["on_resize_align_right"] = var_684;
            param1["on_resize_align_center"] = var_683;
            param1["on_resize_align_top"] = var_685;
            param1["on_resize_align_bottom"] = var_687;
            param1["on_resize_align_middle"] = var_686;
            param1["on_accommodate_align_left"] = var_680;
            param1["on_accommodate_align_right"] = var_676;
            param1["on_accommodate_align_center"] = var_678;
            param1["on_accommodate_align_top"] = var_681;
            param1["on_accommodate_align_bottom"] = var_677;
            param1["on_accommodate_align_middle"] = var_679;
            param1["route_input_events_to_parent"] = var_692;
            param1["use_parent_graphic_context"] = var_693;
            param1["draggable_with_mouse"] = var_703;
            param1["scalable_with_mouse"] = var_705;
            param1["reflect_horizontal_resize_to_parent"] = var_688;
            param1["reflect_vertical_resize_to_parent"] = var_689;
            param1["reflect_resize_to_parent"] = var_710;
            param1["force_clipping"] = WINDOW_PARAM_FORCE_CLIPPING;
            param1["inherit_caption"] = var_714;
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
