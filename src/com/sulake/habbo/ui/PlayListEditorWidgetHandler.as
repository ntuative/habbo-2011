package com.sulake.habbo.ui
{

    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.RemoveJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;

    import flash.events.Event;

    public class PlayListEditorWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer;
        private var _connection: IConnection = null;
        private var var_4634: IMessageEvent;
        private var var_4635: IMessageEvent;
        private var var_4636: IMessageEvent;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_284;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function set connection(param1: IConnection): void
        {
            this.var_4634 = new FurniListUpdateEvent(this.onFurniListUpdated);
            this.var_4635 = new FurniListRemoveEvent(this.onFurniListUpdated);
            this.var_4636 = new FurniListInsertEvent(this.onFurniListUpdated);
            this._connection = param1;
            this._connection.addMessageEvent(this.var_4634);
            this._connection.addMessageEvent(this.var_4635);
            this._connection.addMessageEvent(this.var_4636);
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
            }

            this._connection.removeMessageEvent(this.var_4634);
            this._connection.removeMessageEvent(this.var_4635);
            this._connection.removeMessageEvent(this.var_4636);
            this._connection = null;
            this.var_4634 = null;
        }

        public function getWidgetMessages(): Array
        {
            return [
                RoomWidgetFurniToWidgetMessage.var_1544,
                RoomWidgetPlayListModificationMessage.var_1250,
                RoomWidgetPlayListModificationMessage.var_1251,
                RoomWidgetPlayListPlayStateMessage.var_1252,
                RoomWidgetPlayListUserActionMessage.var_1253
            ];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniToWidgetMessage;
            var _loc3_: IRoomObject;
            var _loc4_: RoomWidgetPlayListModificationMessage;
            var _loc5_: RoomWidgetPlayListModificationMessage;
            var _loc6_: RoomWidgetPlayListPlayStateMessage;
            var _loc7_: Boolean;
            var _loc8_: RoomWidgetPlayListEditorEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1544:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc7_ = this._container.roomSession.isRoomOwner;
                        if (_loc7_)
                        {
                            _loc8_ = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1241, _loc2_.id);
                            this._container.events.dispatchEvent(_loc8_);
                        }

                    }

                    break;
                case RoomWidgetPlayListModificationMessage.var_1250:
                    _loc4_ = (param1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new AddJukeboxDiskComposer(_loc4_.diskId, _loc4_.slotNumber));
                    }

                    break;
                case RoomWidgetPlayListModificationMessage.var_1251:
                    _loc5_ = (param1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new RemoveJukeboxDiskComposer(_loc5_.slotNumber));
                    }

                    break;
                case RoomWidgetPlayListPlayStateMessage.var_1252:
                    _loc6_ = (param1 as RoomWidgetPlayListPlayStateMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new UseFurnitureMessageComposer(_loc6_.furniId, _loc6_.position));
                    }

                    break;
                case RoomWidgetPlayListUserActionMessage.var_1253:
                    this._container.habboTracking.track("playlistEditorPanelOpenCatalogue", "click");
                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomEngineSoundMachineEvent.var_420);
            return _loc1_;
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomEngineSoundMachineEvent;
            var _loc3_: RoomWidgetPlayListEditorEvent;
            switch (param1.type)
            {
                case RoomEngineSoundMachineEvent.var_420:
                    _loc2_ = (param1 as RoomEngineSoundMachineEvent);
                    _loc3_ = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1242, _loc2_.objectId);
                    this._container.events.dispatchEvent(_loc3_);
                    return;
            }

        }

        public function update(): void
        {
        }

        private function onFurniListUpdated(param1: IMessageEvent): void
        {
            if (this._container != null)
            {
                if (this._container.events != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1243, -1));
                }

            }

        }

    }
}
