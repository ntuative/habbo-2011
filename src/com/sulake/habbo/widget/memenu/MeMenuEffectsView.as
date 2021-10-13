package com.sulake.habbo.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.widget.messages.RoomWidgetSelectEffectMessage;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetGetEffectsMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;

    public class MeMenuEffectsView implements IMeMenuView 
    {

        public static const var_1824:Number = 55;

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;
        private var var_4837:Array;
        private var _effectsContainer:IWindowContainer;

        public function get widget():MeMenuWidget
        {
            return (this._widget);
        }

        public function get effectsContainer():IWindowContainer
        {
            return (this._effectsContainer);
        }

        public function init(param1:MeMenuWidget, param2:String):void
        {
            this._widget = param1;
            this.var_4837 = new Array();
            this.createWindow(param2);
        }

        public function dispose():void
        {
            this.disposeEffects();
            this.var_4837 = null;
            this._widget = null;
            this._window.dispose();
            this._window = null;
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function updateEffects(param1:Array):Boolean
        {
            var _loc3_:IWidgetAvatarEffect;
            var _loc4_:int;
            var _loc5_:Number;
            var _loc6_:EffectView;
            this.disposeEffects();
            var _loc2_:int;
            this.showInfoText((param1.length == 0));
            for each (_loc3_ in param1)
            {
                _loc6_ = new EffectView();
                _loc6_.init(this, ("active_effect_" + _loc2_), _loc3_);
                this.var_4837.push(_loc6_);
                _loc6_.window.y = (_loc2_ * var_1824);
                _loc2_++;
            };
            _loc4_ = this._effectsContainer.height;
            _loc5_ = (this.var_4837.length * var_1824);
            this._effectsContainer.height = Math.max(_loc5_, 50);
            this._window.height = (this._window.height + (this._effectsContainer.height - _loc4_));
            this._widget.updateSize();
            return (false);
        }

        private function showInfoText(param1:Boolean):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_loc2_ != null)
            {
                _loc2_.visible = param1;
            };
        }

        public function selectEffect(param1:EffectView):void
        {
            if (param1.effect.isInUse)
            {
                this._widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.var_1825, param1.effect.type));
            }
            else
            {
                this._widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.var_1826, param1.effect.type));
            };
        }

        private function disposeEffects():void
        {
            var _loc1_:EffectView;
            for each (_loc1_ in this.var_4837)
            {
                _loc1_.dispose();
                _loc1_ = null;
            };
            this.var_4837 = [];
        }

        private function createWindow(param1:String):void
        {
            var _loc3_:IWindow;
            var _loc2_:XmlAsset = (this._widget.assets.getAssetByName("memenu_effects") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IWindowContainer);
            if (this._window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this._window.name = param1;
            var _loc4_:int;
            while (_loc4_ < this._window.numChildren)
            {
                _loc3_ = this._window.getChildAt(_loc4_);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _loc4_++;
            };
            this._effectsContainer = (this._window.findChildByName("effects_cnvs") as IWindowContainer);
            this._widget.mainContainer.addChild(this._window);
            this._widget.messageListener.processWidgetMessage(new RoomWidgetGetEffectsMessage());
        }

        private function onResized(param1:WindowEvent):void
        {
            this._window.x = 0;
            this._window.y = 0;
        }

        private function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:String;
            var _loc3_:IWindow = (param1.target as IWindow);
            var _loc4_:String = _loc3_.name;
            switch (_loc4_)
            {
                case "back_btn":
                    this._widget.changeView(MeMenuWidget.var_1291);
                    return;
                case "moreEffects_btn":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage(RoomWidgetOpenInventoryMessage.var_1827));
                    return;
                case "hideEffects_btn":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.var_1828));
                    return;
                default:
                    Logger.log(("Me Menu Effects View: unknown button: " + _loc4_));
            };
        }

    }
}