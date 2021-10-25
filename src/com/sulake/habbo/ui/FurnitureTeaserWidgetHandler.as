package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetViralFurniMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.widget.events.RoomWidgetTeaserDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;

    import flash.events.Event;

    public class FurnitureTeaserWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_266;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function dispose(): void
        {
            this.var_978 = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            return [
                RoomWidgetFurniToWidgetMessage.var_1539,
                RoomWidgetViralFurniMessage.var_1380,
                RoomWidgetViralFurniMessage.var_1281
            ];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniToWidgetMessage;
            var _loc3_: IRoomObject;
            var _loc4_: RoomWidgetViralFurniMessage;
            var _loc5_: IRoomObjectModel;
            var _loc6_: String;
            var _loc7_: RoomWidgetTeaserDataUpdateEvent;
            var _loc8_: String;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1539:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc5_ = _loc3_.getModel();
                        if (_loc5_ != null)
                        {
                            _loc6_ = _loc5_.getString(RoomObjectVariableEnum.FURNITURE_DATA);
                            _loc7_ = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.var_1377);
                            _loc8_ = "+";
                            if (_loc6_.indexOf(_loc8_) > -1)
                            {
                                _loc7_.data = _loc6_.substring(0, _loc6_.indexOf(_loc8_));
                                _loc7_.campaignID = _loc6_.substring(_loc6_.indexOf(_loc8_) + 1, _loc6_.length);
                            }
                            else
                            {
                                _loc7_.data = _loc6_;
                                _loc7_.campaignID = null;
                            }

                            this._container.events.dispatchEvent(_loc7_);
                        }

                    }

                    break;
                case RoomWidgetViralFurniMessage.var_1380:
                    if (this._container != null && this._container.roomSession != null)
                    {
                        this._container.roomSession.sendViralFurniFoundMessage();
                    }

                    break;
                case RoomWidgetViralFurniMessage.var_1281:
                    _loc4_ = (param1 as RoomWidgetViralFurniMessage);
                    if (this._container != null && this._container.roomSession != null)
                    {
                        this._container.roomSession.sendPresentOpenMessage(_loc4_.objectId);
                    }

                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [RoomSessionViralFurniStatusEvent.var_374, RoomSessionViralFurniStatusEvent.var_375];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomSessionViralFurniStatusEvent;
            var _loc3_: RoomWidgetTeaserDataUpdateEvent;
            if (this._container == null || this._container.events == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomSessionViralFurniStatusEvent.var_374:
                    _loc2_ = (param1 as RoomSessionViralFurniStatusEvent);
                    _loc3_ = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.var_1378);
                    _loc3_.campaignID = _loc2_.campaignID;
                    _loc3_.objectId = _loc2_.objectId;
                    _loc3_.status = _loc2_.status;
                    _loc3_.data = _loc2_.shareId;
                    _loc3_.itemCategory = _loc2_.itemCategory;
                    _loc3_.firstClickUserName = _loc2_.firstClickUserName;
                    _loc3_.ownRealName = this._container.sessionDataManager.realName;
                    this._container.events.dispatchEvent(_loc3_);
                    return;
                case RoomSessionViralFurniStatusEvent.var_375:
                    _loc2_ = (param1 as RoomSessionViralFurniStatusEvent);
                    _loc3_ = new RoomWidgetTeaserDataUpdateEvent(RoomWidgetTeaserDataUpdateEvent.var_1379);
                    _loc3_.campaignID = _loc2_.campaignID;
                    _loc3_.status = _loc2_.status;
                    _loc3_.data = _loc2_.shareId;
                    _loc3_.itemCategory = _loc2_.itemCategory;
                    _loc3_.firstClickUserName = _loc2_.firstClickUserName;
                    _loc3_.giftWasReceived = _loc2_.giftWasReceived;
                    this._container.events.dispatchEvent(_loc3_);
                    return;
                default:
                    Logger.log("Error, invalid viral room event type: " + param1.type);
            }

        }

        public function update(): void
        {
        }

    }
}
