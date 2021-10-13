package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsDataMessageParser implements IMessageParser 
    {

        private var var_3336:RoomSettingsData;

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3336 = new RoomSettingsData();
            this.var_3336.roomId = param1.readInteger();
            this.var_3336.name = param1.readString();
            this.var_3336.description = param1.readString();
            this.var_3336.doorMode = param1.readInteger();
            this.var_3336.categoryId = param1.readInteger();
            this.var_3336.maximumVisitors = param1.readInteger();
            this.var_3336.maximumVisitorsLimit = param1.readInteger();
            this.var_3336.tags = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3336.tags.push(param1.readString());
                _loc3_++;
            };
            this.var_3336.controllers = [];
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                this.var_3336.controllers.push(new FlatControllerData(param1));
                _loc5_++;
            };
            this.var_3336.controllerCount = param1.readInteger();
            this.var_3336.allowPets = (param1.readInteger() == 1);
            this.var_3336.allowFoodConsume = (param1.readInteger() == 1);
            this.var_3336.allowWalkThrough = (param1.readInteger() == 1);
            this.var_3336.hideWalls = (param1.readInteger() == 1);
            return (true);
        }

        public function flush():Boolean
        {
            this.var_3336 = null;
            return (true);
        }

        public function get data():RoomSettingsData
        {
            return (this.var_3336);
        }

    }
}