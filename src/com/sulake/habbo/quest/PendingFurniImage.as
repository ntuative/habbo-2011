package com.sulake.habbo.quest
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.display.BitmapData;

    public class PendingFurniImage implements IGetImageListener, IDisposable 
    {

        private var var_3922:HabboQuestEngine;
        private var var_3924:IBitmapWrapperWindow;
        private var var_3925:int;

        public function PendingFurniImage(param1:HabboQuestEngine, param2:IBitmapWrapperWindow, param3:IFurnitureData, param4:int)
        {
            this.var_3922 = param1;
            this.var_3924 = param2;
            var _loc5_:ImageResult = this.var_3922.roomEngine.getFurnitureImage(param3.id, new Vector3d(90, 0, 0), 64, this, param4, "");
            this.var_3925 = _loc5_.id;
            if (((_loc5_) && (_loc5_.data)))
            {
                this.imageReady(_loc5_.id, _loc5_.data);
            };
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (this.var_3922 == null);
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (this.var_3925 == param1)
            {
                QuestUtils.setElementImage(this.var_3924, param2, this.var_3924.height);
                this.dispose();
            };
        }

    }
}