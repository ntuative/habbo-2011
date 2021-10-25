package com.sulake.habbo.quest
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class PendingImage implements IDisposable
    {

        private var var_3922: HabboQuestEngine;
        private var var_3924: IBitmapWrapperWindow;

        public function PendingImage(param1: HabboQuestEngine, param2: IBitmapWrapperWindow, param3: String)
        {
            this.var_3922 = param1;
            this.var_3924 = param2;
            this.var_3922.setImageFromAsset(param2, param3, this.onPreviewImageReady);
        }

        public function dispose(): void
        {
            this.var_3924 = null;
            this.var_3922 = null;
        }

        public function get disposed(): Boolean
        {
            return this.var_3922 == null;
        }

        private function onPreviewImageReady(param1: AssetLoaderEvent): void
        {
            var _loc2_: AssetLoaderStruct;
            if (!this.disposed)
            {
                _loc2_ = (param1.target as AssetLoaderStruct);
                if (_loc2_ != null)
                {
                    this.var_3922.setImageFromAsset(this.var_3924, _loc2_.assetName, null);
                }

            }

            this.dispose();
        }

    }
}
