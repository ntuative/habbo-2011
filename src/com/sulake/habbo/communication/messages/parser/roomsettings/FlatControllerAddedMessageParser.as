﻿package com.sulake.habbo.communication.messages.parser.roomsettings
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerAddedMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _data: FlatControllerData;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._data = new FlatControllerData(data);
            
            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get data(): FlatControllerData
        {
            return this._data;
        }

    }
}
