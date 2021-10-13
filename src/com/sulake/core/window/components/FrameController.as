package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class FrameController extends ContainerController implements IFrameWindow 
    {

        private static const var_1992:String = "_TITLE";
        private static const var_1993:String = "_HEADER";
        private static const var_1994:String = "_CONTENT";
        private static const var_1995:String = "_SCALER";

        private var _title:ILabelWindow;
        private var var_1996:IHeaderWindow;
        private var var_1997:IWindowContainer;
        private var var_1998:IMargins;
        private var var_2000:Boolean = false;

        public function FrameController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_593);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            this.var_2000 = true;
            activate();
            this.setupScaling();
        }

        public function get title():ILabelWindow
        {
            if (this._title == null)
            {
                this._title = (findChildByTag(var_1992) as ILabelWindow);
                if (!this._title)
                {
                    throw (new Error("Frame window's title element not available!"));
                };
            };
            return (this._title);
        }

        public function get header():IHeaderWindow
        {
            if (this.var_1996 == null)
            {
                this.var_1996 = (findChildByTag(var_1993) as IHeaderWindow);
                if (!this.var_1996)
                {
                    throw (new Error("Frame window's header element not available!"));
                };
            };
            return (this.var_1996);
        }

        public function get content():IWindowContainer
        {
            if (this.var_1997 == null)
            {
                this.var_1997 = (findChildByTag(var_1994) as IWindowContainer);
                if (!this.var_1997)
                {
                    throw (new Error("Frame window's content element not available!"));
                };
            };
            return (this.var_1997);
        }

        public function get scaler():IScalerWindow
        {
            return (findChildByTag(var_1995) as IScalerWindow);
        }

        public function get margins():IMargins
        {
            var _loc1_:Rectangle;
            if (!this.var_1998)
            {
                _loc1_ = this.content.rectangle;
                this.var_1998 = new TextMargins(_loc1_.left, _loc1_.top, _loc1_.right, _loc1_.bottom, this.marginsCallback);
            };
            return (this.var_1998);
        }

        override public function set caption(value:String):void
        {
            super.caption = value;
            try
            {
                this.title.text = value;
            }
            catch(e:Error)
            {
            };
        }

        override public function set color(param1:uint):void
        {
            var _loc3_:IWindow;
            super.color = param1;
            var _loc2_:Array = new Array();
            groupChildrenWithTag(var_1999, _loc2_, false);
            for each (_loc3_ in _loc2_)
            {
                _loc3_.color = param1;
            };
        }

        override public function get iterator():IIterator
        {
            return (((!(this.content == null)) && (this.var_2000)) ? this.content.iterator : new Iterator(this));
        }

        override public function buildFromXML(param1:XML, param2:Map=null):Boolean
        {
            return (!(context.getWindowParser().parseAndConstruct(param1, this.content, param2) == null));
        }

        override public function setParamFlag(param1:uint, param2:Boolean=true):void
        {
            super.setParamFlag(param1, param2);
            this.setupScaling();
        }

        private function setupScaling():void
        {
            var _loc1_:IWindow = this.scaler;
            var _loc2_:Boolean = testParamFlag(WindowParam.var_675);
            var _loc3_:Boolean = testParamFlag(WindowParam.var_673);
            var _loc4_:Boolean = testParamFlag(WindowParam.var_672);
            if (_loc1_)
            {
                if (((_loc3_) || (_loc2_)))
                {
                    _loc1_.setParamFlag(WindowParam.var_673, true);
                }
                else
                {
                    _loc1_.setParamFlag(WindowParam.var_673, false);
                };
                if (((_loc4_) || (_loc2_)))
                {
                    _loc1_.setParamFlag(WindowParam.var_672, true);
                }
                else
                {
                    _loc1_.setParamFlag(WindowParam.var_672, false);
                };
                _loc1_.visible = (((_loc3_) || (_loc4_)) || (_loc2_));
            };
        }

        public function resizeToFitContent():void
        {
            var _loc5_:IWindow;
            var _loc1_:WindowController = WindowController(this.content);
            var _loc2_:int = _loc1_.width;
            var _loc3_:int = _loc1_.height;
            var _loc4_:uint = _loc1_.numChildren;
            resizeToAccommodateChildren(_loc1_);
        }

        private function marginsCallback(param1:IMargins):void
        {
            var _loc2_:IWindow = this.content;
            var _loc3_:uint = _loc2_.param;
            var _loc4_:uint = (_loc2_.param & (WindowParam.var_697 | WindowParam.var_698));
            if (_loc4_)
            {
                _loc2_.setParamFlag((WindowParam.var_697 | WindowParam.var_698), false);
            };
            var _loc5_:uint = (_loc2_.param & WindowParam.var_710);
            if (_loc5_)
            {
                _loc2_.setParamFlag(WindowParam.var_710, false);
            };
            _loc2_.rectangle = new Rectangle(param1.left, param1.top, (param1.right - param1.left), (param1.bottom - param1.top));
            if (((_loc4_) || (_loc5_)))
            {
                _loc2_.setParamFlag(0xFFFFFFFF, false);
                _loc2_.setParamFlag(_loc3_, true);
            };
        }

        override public function get properties():Array
        {
            var _loc1_:Array = super.properties;
            var _loc2_:* = (!(this.var_1998 == null));
            var _loc3_:Rectangle = this.content.rectangle;
            if (_loc2_)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1125, _loc3_.left, PropertyStruct.var_607, _loc2_));
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1126, _loc3_.top, PropertyStruct.var_607, _loc2_));
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1127, (var_1018.width - _loc3_.right), PropertyStruct.var_607, _loc2_));
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1128, (var_1018.height - _loc3_.bottom), PropertyStruct.var_607, _loc2_));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1145);
                _loc1_.push(PropertyDefaults.var_1147);
                _loc1_.push(PropertyDefaults.var_1149);
                _loc1_.push(PropertyDefaults.var_1151);
            };
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_1125:
                        this.margins.left = (_loc2_.value as int);
                        break;
                    case PropertyDefaults.var_1126:
                        this.margins.top = (_loc2_.value as int);
                        break;
                    case PropertyDefaults.var_1127:
                        this.margins.right = (var_1018.width - (_loc2_.value as int));
                        break;
                    case PropertyDefaults.var_1128:
                        this.margins.bottom = (var_1018.height - (_loc2_.value as int));
                        break;
                };
            };
            super.properties = param1;
        }

    }
}