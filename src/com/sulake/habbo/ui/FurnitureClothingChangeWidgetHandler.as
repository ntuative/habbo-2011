package com.sulake.habbo.ui
{

    import com.sulake.habbo.avatar.IHabboAvatarEditorDataSaver;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.avatar.events.AvatarEditorClosedEvent;
    import com.sulake.habbo.widget.events.RoomWidgetClothingChangeUpdateEvent;

    import flash.events.Event;

    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetClothingChangeMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    public class FurnitureClothingChangeWidgetHandler implements IRoomWidgetHandler, IHabboAvatarEditorDataSaver
    {

        private static const var_4629: String = "hr-165-45.hd-208-2.ch-250-64.lg-285-82.sh-290-64";
        private static const var_4630: String = "hr-681-41.hd-620-9.ch-879-90.lg-700-85.sh-735-68";

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var var_2358: int = -1;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_278;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            if (this._container != null)
            {
                if (this._container.avatarEditor)
                {
                    this._container.avatarEditor.events.removeEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED, this.onAvatarEditorClosed);
                }

            }

            this._container = param1;
            if (this._container.avatarEditor)
            {
                this._container.avatarEditor.events.addEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED, this.onAvatarEditorClosed);
            }

        }

        private function onAvatarEditorClosed(param1: Event = null): void
        {
            if (this._container == null)
            {
                return;
            }

            var _loc2_: RoomWidgetClothingChangeUpdateEvent = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.var_1373);
            this._container.events.dispatchEvent(_loc2_);
        }

        public function dispose(): void
        {
            if (this._container != null)
            {
                if (this._container.avatarEditor && this._container.avatarEditor.events)
                {
                    this._container.avatarEditor.events.removeEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED, this.onAvatarEditorClosed);
                }

            }

            this.var_978 = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            return [
                RoomWidgetFurniToWidgetMessage.var_1543,
                RoomWidgetClothingChangeMessage.var_1376,
                RoomWidgetAvatarEditorMessage.var_1822
            ];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc6_: RoomWidgetFurniToWidgetMessage;
            var _loc7_: RoomWidgetClothingChangeMessage;
            var _loc8_: Boolean;
            var _loc9_: String;
            var _loc10_: String;
            var _loc11_: int;
            var _loc2_: String;
            var _loc3_: IRoomObject;
            var _loc4_: IRoomObjectModel;
            var _loc5_: RoomWidgetClothingChangeUpdateEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1543:
                    _loc6_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc6_.roomId, _loc6_.roomCategory, _loc6_.id, _loc6_.category);
                    if (_loc3_ != null)
                    {
                        _loc4_ = _loc3_.getModel();
                        if (_loc4_ != null)
                        {
                            _loc8_ = this._container.roomSession.isRoomOwner || this._container.sessionDataManager.isAnyRoomController;
                            if (_loc8_)
                            {
                                _loc5_ = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.var_1371, _loc6_.id, _loc6_.category, _loc6_.roomId, _loc6_.roomCategory);
                                this._container.events.dispatchEvent(_loc5_);
                            }

                        }

                    }

                    break;
                case RoomWidgetClothingChangeMessage.var_1376:
                    _loc7_ = (param1 as RoomWidgetClothingChangeMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc7_.roomId, _loc7_.roomCategory, _loc7_.objectId, _loc7_.objectCategory);
                    if (_loc3_ != null)
                    {
                        _loc4_ = _loc3_.getModel();
                        if (_loc4_ != null)
                        {
                            this.var_2358 = _loc7_.objectId;
                            _loc9_ = FigureData.MALE;
                            _loc10_ = _loc4_.getString(RoomObjectVariableEnum.var_753);
                            if (_loc10_ == null)
                            {
                                _loc10_ = var_4629;
                            }

                            if (_loc7_.gender == FigureData.FEMALE)
                            {
                                _loc9_ = FigureData.FEMALE;
                                _loc10_ = _loc4_.getString(RoomObjectVariableEnum.var_752);
                                if (_loc10_ == null)
                                {
                                    _loc10_ = var_4630;
                                }

                            }

                            if (this._container.avatarEditor.openEditor(_loc7_.window, this, [
                                AvatarEditorFigureCategory.var_521,
                                AvatarEditorFigureCategory.var_522
                            ], true))
                            {
                                _loc11_ = HabboClubLevelEnum.HC_LEVEL_NONE;
                                this._container.avatarEditor.loadAvatarInEditor(_loc10_, _loc9_, _loc11_);
                                _loc2_ = _loc4_.getString(RoomObjectVariableEnum.FURNITURE_DATA);
                                if (_loc2_ == null)
                                {
                                    _loc2_ = "";
                                }

                                _loc5_ = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.var_1371, _loc7_.objectId, _loc7_.objectCategory, _loc7_.roomId, _loc7_.roomCategory);
                                this._container.events.dispatchEvent(_loc5_);
                            }

                        }

                    }

                    break;
                case RoomWidgetAvatarEditorMessage.var_1822:
                    _loc5_ = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.var_1373);
                    this._container.events.dispatchEvent(_loc5_);
                    break;
            }

            return null;
        }

        public function update(): void
        {
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processEvent(param1: Event): void
        {
        }

        public function saveFigure(param1: String, param2: String): void
        {
            if (this._container == null)
            {
                return;
            }

            this._container.roomSession.sendUpdateClothingChangeFurniture(this.var_2358, param2, param1);
            this._container.avatarEditor.close();
        }

    }
}
