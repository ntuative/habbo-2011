package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class ProductGridItem implements IGridItem 
    {

        private static const var_2841:String = "bg";

        protected var _view:IWindowContainer;
        private var var_2842:IItemGrid;
        private var _icon:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;
        private var var_2843:Object;

        public function get view():IWindowContainer
        {
            return (this._view);
        }

        public function set grid(param1:IItemGrid):void
        {
            this.var_2842 = param1;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            this.var_2842 = null;
            this._icon = null;
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
            this._disposed = true;
        }

        public function activate():void
        {
            this._view.getChildByName(var_2841).style = HabboWindowStyle.var_525;
        }

        public function deActivate():void
        {
            this._view.getChildByName(var_2841).style = 3;
        }

        public function set view(param1:IWindowContainer):void
        {
            if (!param1)
            {
                return;
            };
            this._view = param1;
            this._view.procedure = this.eventProc;
            this._icon = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            var _loc2_:IWindow = this._view.findChildByName("multiContainer");
            if (_loc2_)
            {
                _loc2_.visible = false;
            };
        }

        private function eventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.var_633)
            {
                this.var_2843 = null;
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_628)
                {
                    if (param2 == null)
                    {
                        return;
                    };
                    this.var_2842.select(this);
                    this.var_2843 = param2;
                }
                else
                {
                    if ((((param1.type == WindowMouseEvent.var_626) && (!(this.var_2843 == null))) && (this.var_2843 == param2)))
                    {
                        _loc3_ = this.var_2842.startDragAndDrop(this);
                        if (_loc3_)
                        {
                            this.var_2843 = null;
                        };
                    }
                    else
                    {
                        if (param1.type == WindowMouseEvent.var_633)
                        {
                            (this.var_2843 == null);
                        }
                        else
                        {
                            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                            {
                                (this.var_2843 == null);
                            }
                            else
                            {
                                if (param1.type == WindowMouseEvent.var_627)
                                {
                                    this.var_2843 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

        protected function setIconImage(param1:BitmapData):void
        {
            if (param1 == null)
            {
                return;
            };
            if (this._icon == null)
            {
                return;
            };
            if (this._icon.disposed)
            {
                return;
            };
            var _loc2_:int = int(((this._icon.width - param1.width) / 2));
            var _loc3_:int = int(((this._icon.height - param1.height) / 2));
            if (this._icon.bitmap == null)
            {
                this._icon.bitmap = new BitmapData(this._icon.width, this._icon.height, true, 0xFFFFFF);
            };
            this._icon.bitmap.fillRect(this._icon.bitmap.rect, 0xFFFFFF);
            this._icon.bitmap.copyPixels(param1, param1.rect, new Point(_loc2_, _loc3_), null, null, false);
            this._icon.invalidate();
        }

    }
}