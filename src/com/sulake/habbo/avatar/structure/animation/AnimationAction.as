package com.sulake.habbo.avatar.structure.animation
{

    import flash.utils.Dictionary;

    public class AnimationAction
    {

        private var _id: String;
        private var _parts: Dictionary;

        public function AnimationAction(data: XML)
        {
            super();
            this._id = String(data.@id);
            this._parts = new Dictionary();

            for each (var part: XML in data.part)
            {
                this._parts[String(part.@["set-type"])] = new ActionPart(part);
            }

        }

        public function getPart(param1: String): ActionPart
        {
            return this._parts[param1] as ActionPart;
        }

        public function get id(): String
        {
            return this._id;
        }

        public function get parts(): Dictionary
        {
            return this._parts;
        }

    }
}
