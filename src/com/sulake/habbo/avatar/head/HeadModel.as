package com.sulake.habbo.avatar.head
{

    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.figuredata.FigureData;

    public class HeadModel extends CategoryBaseModel implements IAvatarEditorCategoryModel
    {

        public function HeadModel(param1: HabboAvatarEditor)
        {
            super(param1);
        }

        override protected function init(): void
        {
            super.init();
            initCategory(FigureData.var_1640);
            initCategory(FigureData.var_1641);
            initCategory(FigureData.var_1642);
            initCategory(FigureData.var_1643);
            initCategory(FigureData.var_1644);
            var_2067 = true;
            if (!_view)
            {
                _view = new HeadView(this, controller.windowManager, controller.assets);
                if (_view)
                {
                    _view.init();
                }

            }

        }

    }
}
