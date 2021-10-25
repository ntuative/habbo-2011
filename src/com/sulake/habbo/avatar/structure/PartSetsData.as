package com.sulake.habbo.avatar.structure
{

    import flash.utils.Dictionary;

    import com.sulake.habbo.avatar.structure.parts.PartDefinition;
    import com.sulake.habbo.avatar.structure.parts.ActivePartSet;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.structure.parts.*;

    public class PartSetsData implements IStructureData
    {

        private var _parts: Dictionary;
        private var _activePartSets: Dictionary;

        public function PartSetsData()
        {
            this._parts = new Dictionary();
            this._activePartSets = new Dictionary();
        }

        public function parse(data: XML): Boolean
        {
            var part: XML;
            var activePartSet: XML;

            if (data == null)
            {
                return false;
            }


            for each (part in data.partSet[0].part)
            {
                this._parts[String(part.@["set-type"])] = new PartDefinition(part);
            }


            for each (activePartSet in data.activePartSet)
            {
                this._activePartSets[String(activePartSet.@id)] = new ActivePartSet(activePartSet);
            }


            return true;
        }

        public function appendXML(data: XML): Boolean
        {
            var part: XML;
            var activePartSet: XML;

            if (data == null)
            {
                return false;
            }


            for each (part in data.partSet[0].part)
            {
                this._parts[String(part.@["set-type"])] = new PartDefinition(part);
            }


            for each (activePartSet in data.activePartSet)
            {
                this._activePartSets[String(activePartSet.@id)] = new ActivePartSet(activePartSet);
            }

            return false;
        }

        public function getActiveParts(param1: IActionDefinition): Array
        {
            var activePartSet: ActivePartSet = this._activePartSets[param1.activePartSet];

            if (activePartSet != null)
            {
                return activePartSet.parts;
            }


            return [];
        }

        public function getPartDefinition(setType: String): PartDefinition
        {
            return this._parts[setType] as PartDefinition;
        }

        public function addPartDefinition(data: XML): PartDefinition
        {
            var setType: String = String(data.@["set-type"]);

            if (this._parts[setType] == null)
            {
                this._parts[setType] = new PartDefinition(data);
            }


            return this._parts[setType];
        }

        public function get parts(): Dictionary
        {
            return this._parts;
        }

        public function get activePartSets(): Dictionary
        {
            return this._activePartSets;
        }

        public function getActivePartSet(actionDefinition: ActionDefinition): ActivePartSet
        {
            return this._activePartSets[actionDefinition.activePartSet] as ActivePartSet;
        }

    }
}
