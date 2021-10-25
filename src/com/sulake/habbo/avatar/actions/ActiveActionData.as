package com.sulake.habbo.avatar.actions
{

    public class ActiveActionData implements IActiveActionData
    {

        private var _actionType: String = "";
        private var _actionParameter: String = "";
        private var _definition: IActionDefinition;
        private var _startFrame: int = 0;
        private var _overridingAction: String;

        public function ActiveActionData(param1: String, param2: String = "", param3: int = 0)
        {
            this._actionType = param1;
            this._actionParameter = param2;
            this._startFrame = param3;
        }

        public function get actionType(): String
        {
            return this._actionType;
        }

        public function get actionParameter(): String
        {
            return this._actionParameter;
        }

        public function get definition(): IActionDefinition
        {
            return this._definition;
        }

        public function get id(): String
        {
            if (this._definition == null)
            {
                return "";
            }

            return this._definition.id + "_" + this._actionParameter;
        }

        public function set actionParameter(param1: String): void
        {
            this._actionParameter = param1;
        }

        public function set definition(param1: IActionDefinition): void
        {
            this._definition = param1;
        }

        public function dispose(): void
        {
            this._actionType = null;
            this._actionParameter = null;
            this._definition = null;
        }

        public function get startFrame(): int
        {
            return this._startFrame;
        }

        public function get overridingAction(): String
        {
            return this._overridingAction;
        }

        public function set overridingAction(param1: String): void
        {
            this._overridingAction = param1;
        }

    }
}
