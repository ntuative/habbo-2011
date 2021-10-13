package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.ITextWindow;

    public class SpacesCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const var_1488:String = "floor";
        private static const var_2794:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";

        private var var_2063:XML;
        private var var_2795:Array = [];
        private var _activeWallpaperPatterns:Array = [];
        private var var_2796:int = 0;
        private var var_2797:int = 0;
        private var var_2798:int = 0;
        private var var_2721:String = "default";
        private var var_2799:Array = [];
        private var var_2800:Array = [];
        private var var_2801:int = 0;
        private var var_2802:int = 0;
        private var var_2803:int = 0;
        private var _floorType:String = "default";
        private var var_2804:Array = [];
        private var var_2805:Array = [];
        private var var_2806:int = 0;
        private var var_2807:int = 0;
        private var var_2808:int = 0;
        private var var_2722:String = "1.1";

        public function SpacesCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function init():Boolean
        {
            var _loc2_:Offer;
            var _loc3_:int;
            var _loc4_:IProduct;
            var _loc5_:String;
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:Boolean;
            var _loc9_:XML;
            var _loc10_:XML;
            var _loc11_:XML;
            var _loc12_:IWindow;
            if (!super.init())
            {
                return (false);
            };
            var _loc1_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset);
            if (_loc1_ != null)
            {
                this.var_2063 = (_loc1_.content as XML);
            }
            else
            {
                return (false);
            };
            for each (_loc2_ in page.offers)
            {
                _loc4_ = _loc2_.productContainer.firstProduct;
                _loc5_ = _loc2_.localizationId;
                _loc6_ = _loc5_.split(" ")[0];
                _loc7_ = _loc5_.split(" ")[1];
                _loc8_ = false;
                switch (_loc4_.furnitureData.name)
                {
                    case "floor":
                        for each (_loc9_ in this.var_2063.floors.pattern)
                        {
                            this.var_2800.push(String(_loc9_.@id));
                            this.var_2799.push(_loc2_);
                        };
                        break;
                    case "wallpaper":
                        for each (_loc10_ in this.var_2063.walls.pattern)
                        {
                            if (_loc10_.@id == _loc7_)
                            {
                                this._activeWallpaperPatterns.push(_loc7_);
                                _loc8_ = true;
                            };
                        };
                        if (_loc8_)
                        {
                            this.var_2795.push(_loc2_);
                        }
                        else
                        {
                            Logger.log(("[SpacesCatalogWidget] Could not find wallpaper pattern configuration! " + [_loc2_.localizationId, _loc4_.furnitureData.name]));
                        };
                        break;
                    case "landscape":
                        for each (_loc11_ in this.var_2063.landscapes.pattern)
                        {
                            if (_loc11_.@id == _loc7_)
                            {
                                this.var_2805.push(_loc7_);
                                _loc8_ = true;
                            };
                        };
                        if (_loc8_)
                        {
                            this.var_2804.push(_loc2_);
                        }
                        else
                        {
                            Logger.log(("[SpacesCatalogWidget] Could not find landscape pattern configuration! " + [_loc2_.localizationId, _loc4_.furnitureData.name]));
                        };
                        break;
                    default:
                        Logger.log(("[SpacesCatalogWidget] : " + _loc4_.furnitureData.name));
                };
            };
            _loc3_ = 0;
            while (_loc3_ < _window.numChildren)
            {
                _loc12_ = _window.getChildAt(_loc3_);
                if ((_loc12_ is IButtonWindow))
                {
                    _loc12_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                };
                _loc3_++;
            };
            this.changePattern(var_2794, 0);
            this.changePattern(TYPE_LANDSCAPE, 0);
            this.changePattern(var_1488, 0);
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this.var_2721, this.var_2722, 64));
            return (true);
        }

        private function onClick(param1:WindowMouseEvent):void
        {
            var _loc3_:Offer;
            var _loc2_:IWindow = (param1.target as IWindow);
            if (_loc2_ == null)
            {
                return;
            };
            switch (_loc2_.name)
            {
                case "ctlg_wall_pattern_prev":
                    this.changePattern(var_2794, -1);
                    break;
                case "ctlg_wall_pattern_next":
                    this.changePattern(var_2794, 1);
                    break;
                case "ctlg_wall_color_prev":
                    this.changeColor(var_2794, -1);
                    break;
                case "ctlg_wall_color_next":
                    this.changeColor(var_2794, 1);
                    break;
                case "ctlg_buy_wall":
                    _loc3_ = this.var_2795[this.var_2796];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this.var_2721);
                    };
                    break;
                case "ctlg_floor_pattern_prev":
                    this.changePattern(var_1488, -1);
                    break;
                case "ctlg_floor_pattern_next":
                    this.changePattern(var_1488, 1);
                    break;
                case "ctlg_floor_color_prev":
                    this.changeColor(var_1488, -1);
                    break;
                case "ctlg_floor_color_next":
                    this.changeColor(var_1488, 1);
                    break;
                case "ctlg_buy_floor":
                    _loc3_ = this.var_2799[this.var_2801];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this._floorType);
                    };
                    break;
                case "ctlg_landscape_pattern_next":
                    this.changePattern(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_pattern_prev":
                    this.changePattern(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_landscape_color_prev":
                    this.changeColor(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_color_next":
                    this.changeColor(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_buy_landscape":
                    _loc3_ = this.var_2804[this.var_2806];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this.var_2722);
                    };
                    break;
                default:
                    Logger.log(("Spaces, unknown button: " + _loc2_.name));
            };
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this.var_2721, this.var_2722, 64));
        }

        private function updateConfiguration():void
        {
            var _loc1_:XML;
            var _loc3_:Offer;
            var _loc4_:ICoreLocalizationManager;
            var _loc6_:Offer;
            var _loc8_:Offer;
            var _loc9_:XML;
            var _loc10_:ITextWindow;
            var _loc11_:XML;
            var _loc12_:ITextWindow;
            var _loc13_:XML;
            var _loc14_:ITextWindow;
            var _loc2_:String = this._activeWallpaperPatterns[this.var_2796];
            for each (_loc1_ in this.var_2063.walls.pattern)
            {
                if (_loc1_.@id == _loc2_)
                {
                    if (this.var_2797 >= 0)
                    {
                        _loc9_ = _loc1_.children()[this.var_2797];
                        if (_loc9_ != null)
                        {
                            this.var_2721 = _loc9_.@id;
                        };
                    };
                };
            };
            _loc3_ = this.var_2795[this.var_2796];
            _loc4_ = (page.viewer.catalog as HabboCatalog).localization;
            if (_loc3_ != null)
            {
                _loc10_ = (_window.findChildByName("ctlg_wall_price") as ITextWindow);
                if (_loc10_ != null)
                {
                    _loc10_.caption = _loc4_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc3_.priceInCredits));
                };
            };
            var _loc5_:String = this.var_2800[this.var_2801];
            for each (_loc1_ in this.var_2063.floors.pattern)
            {
                if (_loc1_.@id == _loc5_)
                {
                    _loc11_ = _loc1_.children()[this.var_2802];
                    if (_loc11_ != null)
                    {
                        this._floorType = _loc11_.@id;
                    };
                };
            };
            _loc6_ = this.var_2799[this.var_2801];
            if (_loc6_ != null)
            {
                _loc12_ = (_window.findChildByName("ctlg_floor_price") as ITextWindow);
                if (_loc12_ != null)
                {
                    _loc12_.caption = _loc4_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc6_.priceInCredits));
                };
            };
            var _loc7_:String = this.var_2805[this.var_2806];
            for each (_loc1_ in this.var_2063.landscapes.pattern)
            {
                if (_loc1_.@id == _loc7_)
                {
                    _loc13_ = _loc1_.children()[this.var_2807];
                    if (_loc13_ != null)
                    {
                        this.var_2722 = _loc13_.@id;
                    };
                };
            };
            _loc8_ = this.var_2804[this.var_2806];
            if (_loc8_ != null)
            {
                _loc14_ = (_window.findChildByName("ctlg_landscape_price") as ITextWindow);
                if (_loc14_ != null)
                {
                    _loc14_.caption = _loc4_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc8_.priceInCredits));
                };
            };
        }

        private function changePattern(param1:String, param2:int):void
        {
            var _loc3_:IButtonWindow;
            var _loc4_:IButtonWindow;
            var _loc5_:String;
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:XML;
            var _loc9_:XML;
            var _loc10_:XML;
            switch (param1)
            {
                case var_2794:
                    this.var_2796 = (this.var_2796 + param2);
                    if (this.var_2796 < 0)
                    {
                        this.var_2796 = (this._activeWallpaperPatterns.length - 1);
                    };
                    if (this.var_2796 == this._activeWallpaperPatterns.length)
                    {
                        this.var_2796 = 0;
                    };
                    this.var_2797 = 0;
                    this.var_2798 = 0;
                    _loc5_ = this._activeWallpaperPatterns[this.var_2796];
                    for each (_loc8_ in this.var_2063.walls.pattern)
                    {
                        if (_loc8_.@id == _loc5_)
                        {
                            this.var_2798 = _loc8_.children().length();
                        };
                    };
                    _loc4_ = (_window.findChildByName("ctlg_wall_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_wall_color_next") as IButtonWindow);
                    if (this.var_2798 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
                case var_1488:
                    this.var_2801 = (this.var_2801 + param2);
                    if (this.var_2801 < 0)
                    {
                        this.var_2801 = (this.var_2800.length - 1);
                    };
                    if (this.var_2801 >= this.var_2800.length)
                    {
                        this.var_2801 = 0;
                    };
                    this.var_2802 = 0;
                    this.var_2803 = 0;
                    _loc6_ = this.var_2800[this.var_2801];
                    for each (_loc9_ in this.var_2063.floors.pattern)
                    {
                        if (_loc9_.@id == _loc6_)
                        {
                            this.var_2803 = _loc9_.children().length();
                        };
                    };
                    _loc4_ = (_window.findChildByName("ctlg_floor_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_floor_color_next") as IButtonWindow);
                    if (this.var_2803 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this.var_2806 = (this.var_2806 + param2);
                    if (this.var_2806 < 0)
                    {
                        this.var_2806 = (this.var_2805.length - 1);
                    };
                    if (this.var_2806 >= this.var_2805.length)
                    {
                        this.var_2806 = 0;
                    };
                    this.var_2807 = 0;
                    this.var_2808 = 0;
                    _loc7_ = this.var_2805[this.var_2806];
                    for each (_loc10_ in this.var_2063.landscapes.pattern)
                    {
                        if (_loc10_.@id == _loc7_)
                        {
                            this.var_2808 = _loc10_.children().length();
                        };
                    };
                    _loc4_ = (_window.findChildByName("ctlg_landscape_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_landscape_color_next") as IButtonWindow);
                    if (this.var_2808 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
            };
        }

        private function changeColor(param1:String, param2:int):void
        {
            switch (param1)
            {
                case var_2794:
                    this.var_2797 = (this.var_2797 + param2);
                    if (this.var_2797 < 0)
                    {
                        if (this.var_2798 > 0)
                        {
                            this.var_2797 = (this.var_2798 - 1);
                        }
                        else
                        {
                            this.var_2797 = 0;
                        };
                    };
                    if (this.var_2797 >= this.var_2798)
                    {
                        this.var_2797 = 0;
                    };
                    return;
                case var_1488:
                    this.var_2802 = (this.var_2802 + param2);
                    if (this.var_2802 < 0)
                    {
                        if (this.var_2803 > 0)
                        {
                            this.var_2802 = (this.var_2803 - 1);
                        }
                        else
                        {
                            this.var_2802 = 0;
                        };
                    };
                    if (this.var_2802 >= this.var_2803)
                    {
                        this.var_2802 = 0;
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this.var_2807 = (this.var_2807 + param2);
                    if (this.var_2807 < 0)
                    {
                        if (this.var_2808 > 0)
                        {
                            this.var_2807 = (this.var_2808 - 1);
                        }
                        else
                        {
                            this.var_2807 = 0;
                        };
                    };
                    if (this.var_2807 >= this.var_2808)
                    {
                        this.var_2807 = 0;
                    };
                    return;
            };
        }

    }
}