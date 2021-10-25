package com.sulake.core.window.utils
{

    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import flash.text.GridFitType;

    import com.sulake.core.window.enum.LinkTarget;

    public class PropertyDefaults
    {

        public static const ANTIALIAS_TYPE: String = "antialias_type";
        public static const var_1738: String = "auto_arrange_items";
        public static const var_1121: String = "auto_size";
        public static const var_1730: String = "bitmap_asset_name";
        public static const var_1167: String = "display_as_password";
        public static const var_1157: String = "editable";
        public static const var_1160: String = "focus_capturer";
        public static const var_1137: String = "grid_fit_type";
        public static const var_1727: String = "handle_bitmap_disposing";
        public static const var_1173: String = "link_target";
        public static const var_1736: String = "spacing";
        public static const var_1125: String = "margin_left";
        public static const var_1126: String = "margin_top";
        public static const var_1127: String = "margin_right";
        public static const var_1128: String = "margin_bottom";
        public static const var_1724: String = "item_array";
        public static const var_1122: String = "mouse_wheel_enabled";
        public static const var_1742: String = "resize_on_item_update";
        public static const var_1740: String = "scale_to_fit_items";
        public static const var_1745: String = "scroll_step_h";
        public static const var_1748: String = "scroll_step_v";
        public static const var_1163: String = "selectable";
        public static const var_1123: String = "text_color";
        public static const var_1124: String = "text_style";
        public static const var_1717: String = "tool_tip_caption";
        public static const var_1718: String = "tool_tip_delay";
        public static const ANTIALIAS_TYPE_VALUE: String = AntiAliasType.NORMAL;
        public static const var_1131: Array = [AntiAliasType.NORMAL, AntiAliasType.ADVANCED];
        public static const var_1733: Boolean = true;
        public static const var_1133: String = TextFieldAutoSize.NONE;//"none"
        public static const var_1134: Array = [
            TextFieldAutoSize.NONE,
            TextFieldAutoSize.LEFT,
            TextFieldAutoSize.CENTER,
            TextFieldAutoSize.RIGHT
        ];
        public static const var_1729: String = null;
        public static const var_1165: Boolean = false;
        public static const var_1782: Boolean = true;
        public static const var_1159: Boolean = false;
        public static const var_1136: String = GridFitType.PIXEL;
        public static const var_1138: Array = [GridFitType.PIXEL, GridFitType.NONE, GridFitType.SUBPIXEL];
        public static const var_1726: Boolean = true;
        public static const HTML_LINK_TARGET_VALUE: String = LinkTarget.var_525;
        public static const var_1169: Array = [
            LinkTarget.var_525,
            LinkTarget.var_1783,
            LinkTarget.var_1784,
            LinkTarget.var_1785,
            LinkTarget.TOP,
            LinkTarget.var_1172
        ];
        public static const var_1732: int = 0;
        public static const var_1144: int = 0;
        public static const var_1146: int = 0;
        public static const var_1148: int = 0;
        public static const var_1150: int = 0;
        public static const var_1786: Array = [];
        public static const var_1152: Boolean = true;
        public static const var_1735: Boolean = false;
        public static const var_1734: Boolean = false;
        public static const var_1744: Number = -1;
        public static const var_1747: Number = -1;
        public static const var_1162: Boolean = true;
        public static const var_1140: uint = 0;
        public static const var_1787: String = TextStyleManager.var_1118;//"regular"
        public static const var_1142: Array = TextStyleManager.getStyleNameArrayRef();
        public static const var_1716: String = "";
        public static const var_1715: int = 500;
        public static const var_1132: PropertyStruct = new PropertyStruct(ANTIALIAS_TYPE, ANTIALIAS_TYPE_VALUE, PropertyStruct.var_613, false, var_1131);
        public static const var_1739: PropertyStruct = new PropertyStruct(var_1738, var_1733, PropertyStruct.var_611, false);
        public static const var_1135: PropertyStruct = new PropertyStruct(var_1121, var_1133, PropertyStruct.var_613, false, var_1134);
        public static const var_1731: PropertyStruct = new PropertyStruct(var_1730, var_1729, PropertyStruct.var_613, false);
        public static const var_1166: PropertyStruct = new PropertyStruct(var_1167, var_1165, PropertyStruct.var_611, false);
        public static const var_1158: PropertyStruct = new PropertyStruct(var_1157, var_1782, PropertyStruct.var_611, false);
        public static const var_1161: PropertyStruct = new PropertyStruct(var_1160, var_1159, PropertyStruct.var_611, false);
        public static const var_1139: PropertyStruct = new PropertyStruct(var_1137, var_1136, PropertyStruct.var_613, false, var_1138);
        public static const var_1728: PropertyStruct = new PropertyStruct(var_1727, var_1726, PropertyStruct.var_611, false);
        public static const var_1174: PropertyStruct = new PropertyStruct(var_1173, HTML_LINK_TARGET_VALUE, PropertyStruct.var_613, false, var_1169);
        public static const var_1737: PropertyStruct = new PropertyStruct(var_1736, var_1732, PropertyStruct.var_607, false);
        public static const var_1145: PropertyStruct = new PropertyStruct(var_1125, var_1144, PropertyStruct.var_607, false);
        public static const var_1147: PropertyStruct = new PropertyStruct(var_1126, var_1146, PropertyStruct.var_607, false);
        public static const var_1149: PropertyStruct = new PropertyStruct(var_1127, var_1148, PropertyStruct.var_607, false);
        public static const var_1151: PropertyStruct = new PropertyStruct(var_1128, var_1150, PropertyStruct.var_607, false);
        public static const var_1725: PropertyStruct = new PropertyStruct(var_1724, var_1786, PropertyStruct.var_616, false);
        public static const var_1153: PropertyStruct = new PropertyStruct(var_1122, var_1152, PropertyStruct.var_611, false);
        public static const var_1743: PropertyStruct = new PropertyStruct(var_1742, var_1735, PropertyStruct.var_611, false);
        public static const var_1741: PropertyStruct = new PropertyStruct(var_1740, var_1734, PropertyStruct.var_611, false);
        public static const var_1746: PropertyStruct = new PropertyStruct(var_1745, var_1744, PropertyStruct.var_609, false);
        public static const var_1749: PropertyStruct = new PropertyStruct(var_1748, var_1747, PropertyStruct.var_609, false);
        public static const var_1164: PropertyStruct = new PropertyStruct(var_1163, var_1162, PropertyStruct.var_611, false);
        public static const var_1141: PropertyStruct = new PropertyStruct(var_1123, var_1140, PropertyStruct.var_606, false);
        public static const var_1143: PropertyStruct = new PropertyStruct(var_1124, var_1787, PropertyStruct.var_613, false, var_1142);
        public static const var_1719: PropertyStruct = new PropertyStruct(var_1717, var_1716, PropertyStruct.var_613, false);
        public static const TOOL_TIP_DELAY: PropertyStruct = new PropertyStruct(var_1718, var_1715, PropertyStruct.var_608, false);

    }
}
