package com.sulake.habbo.avatar.actions
{

    import com.sulake.core.utils.Map;

    import flash.utils.Dictionary;

    public class ActionDefinition implements IActionDefinition
    {

        private var _id: String;
        private var _state: String;
        private var _precedence: int;
        private var _activePartSet: String;
        private var _assetPartDefinition: String;
        private var _lay: String;
        private var _geometryType: String;
        private var _isMain: Boolean = false;
        private var _isDefault: Boolean = false;
        private var _isAnimation: Boolean = false;
        private var _prevents: Array = [];
        private var _preventHeadTurn: Boolean;
        private var var_2383: Map;
        private var var_2374: Dictionary = new Dictionary();
        private var var_2373: Dictionary = new Dictionary();
        private var var_2384: String = "";

        public function ActionDefinition(param1: XML)
        {
            var _loc3_: XML;
            var _loc4_: XML;
            var _loc5_: String;
            var _loc6_: String;
            var _loc7_: String;
            super();
            this._id = String(param1.@id);
            this._state = String(param1.@state);
            this._precedence = parseInt(param1.@precedence);
            this._activePartSet = String(param1.@activepartset);
            this._assetPartDefinition = String(param1.@assetpartdefinition);
            this._lay = String(param1.@lay);
            this._geometryType = String(param1.@geometrytype);
            this._isMain = Boolean(parseInt(param1.@main));
            this._isDefault = Boolean(parseInt(param1["@default"]));
            this._isAnimation = Boolean(parseInt(param1.@animation));
            this._preventHeadTurn = Boolean(String(param1.@preventheadturn == "true"));
            var _loc2_: String = String(param1.@prevents);
            if (_loc2_ != "")
            {
                this._prevents = _loc2_.split(",");
            }

            for each (_loc3_ in param1.param)
            {
                _loc5_ = String(_loc3_.@id);
                _loc6_ = String(_loc3_.@value);
                if (_loc5_ == "default")
                {
                    this.var_2384 = _loc6_;
                }
                else
                {
                    this.var_2373[_loc5_] = _loc6_;
                }

            }

            for each (_loc4_ in param1.type)
            {
                _loc7_ = String(_loc4_.@id);
                this.var_2374[_loc7_] = new ActionType(_loc4_);
            }

        }

        public function setOffsets(param1: String, param2: int, param3: Array): void
        {
            if (this.var_2383 == null)
            {
                this.var_2383 = new Map();
            }

            if (this.var_2383.getValue(param1) == null)
            {
                this.var_2383.add(param1, new Map());
            }

            var _loc4_: Map = this.var_2383.getValue(param1);
            _loc4_.add(param2, param3);
        }

        public function getOffsets(param1: String, param2: int): Array
        {
            if (this.var_2383 == null)
            {
                return null;
            }

            var _loc3_: Map = this.var_2383.getValue(param1) as Map;
            if (_loc3_ == null)
            {
                return null;
            }

            return _loc3_.getValue(param2) as Array;
        }

        public function getParameterValue(param1: String): String
        {
            if (param1 == "")
            {
                return "";
            }

            var _loc2_: String = this.var_2373[param1];
            if (_loc2_ == null)
            {
                _loc2_ = this.var_2384;
            }

            return _loc2_;
        }

        private function getTypePrevents(param1: String): Array
        {
            if (param1 == "")
            {
                return [];
            }

            var _loc2_: ActionType = this.var_2374[param1];
            if (_loc2_ != null)
            {
                return _loc2_.prevents;
            }

            return [];
        }

        public function toString(): String
        {
            return "[ActionDefinition]\n" + "id:           " + this.id + "\n" + "state:        " + this.state + "\n" + "main:         " + this.isMain + "\n" + "default:      " + this.isDefault + "\n" + "geometry:     " + this.state + "\n" + "precedence:   " + this.precedence + "\n" + "activepartset:" + this.activePartSet + "\n" + "activepartdef:" + this.assetPartDefinition + "";
        }

        public function get id(): String
        {
            return this._id;
        }

        public function get state(): String
        {
            return this._state;
        }

        public function get precedence(): int
        {
            return this._precedence;
        }

        public function get activePartSet(): String
        {
            return this._activePartSet;
        }

        public function get isMain(): Boolean
        {
            return this._isMain;
        }

        public function get isDefault(): Boolean
        {
            return this._isDefault;
        }

        public function get assetPartDefinition(): String
        {
            return this._assetPartDefinition;
        }

        public function get lay(): String
        {
            return this._lay;
        }

        public function get geometryType(): String
        {
            return this._geometryType;
        }

        public function get isAnimation(): Boolean
        {
            return this._isAnimation;
        }

        public function getPrevents(param1: String = ""): Array
        {
            return this._prevents.concat(this.getTypePrevents(param1));
        }

        public function getPreventHeadTurn(param1: String = ""): Boolean
        {
            if (param1 == "")
            {
                return this._preventHeadTurn;
            }

            var _loc2_: ActionType = this.var_2374[param1];
            if (_loc2_ != null)
            {
                return _loc2_.preventHeadTurn;
            }

            return this._preventHeadTurn;
        }

        public function isAnimated(param1: String): Boolean
        {
            if (param1 == "")
            {
                return true;
            }

            var _loc2_: ActionType = this.var_2374[param1];
            if (_loc2_ != null)
            {
                return _loc2_.isAnimated;
            }

            return true;
        }

    }
}
