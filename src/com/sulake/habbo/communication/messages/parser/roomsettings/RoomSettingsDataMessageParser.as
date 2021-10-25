package com.sulake.habbo.communication.messages.parser.roomsettings
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsDataMessageParser implements IMessageParser
    {

        private var _data: RoomSettingsData;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._data = new RoomSettingsData();

            this._data.roomId = data.readInteger();
            this._data.name = data.readString();
            this._data.description = data.readString();
            this._data.doorMode = data.readInteger();
            this._data.categoryId = data.readInteger();
            this._data.maximumVisitors = data.readInteger();
            this._data.maximumVisitorsLimit = data.readInteger();
            this._data.tags = [];
            
            var tagCount: int = data.readInteger();
            var i: int;
            
            while (i < tagCount)
            {
                this._data.tags.push(data.readString());
                i++;
            }

            this._data.controllers = [];
           
            var controllerCount: int = data.readInteger();
            var j: int;
            while (j < controllerCount)
            {
                this._data.controllers.push(new FlatControllerData(data));
                j++;
            }

            this._data.controllerCount = data.readInteger();
            this._data.allowPets = data.readInteger() == 1;
            this._data.allowFoodConsume = data.readInteger() == 1;
            this._data.allowWalkThrough = data.readInteger() == 1;
            this._data.hideWalls = data.readInteger() == 1;
            
            return true;
        }

        public function flush(): Boolean
        {
            this._data = null;
            
            return true;
        }

        public function get data(): RoomSettingsData
        {
            return this._data;
        }

    }
}
