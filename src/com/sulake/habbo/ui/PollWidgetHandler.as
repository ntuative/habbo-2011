package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetPollMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPollUpdateEvent;

    import flash.events.Event;

    public class PollWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_273;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function dispose(): void
        {
            this._disposed = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            return [RoomWidgetPollMessage.ANSWER, RoomWidgetPollMessage.var_1889, RoomWidgetPollMessage.var_1890];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetPollMessage = param1 as RoomWidgetPollMessage;
            if (_loc2_ == null)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetPollMessage.var_1890:
                    this._container.roomSession.sendPollStartMessage(_loc2_.id);
                    break;
                case RoomWidgetPollMessage.var_1889:
                    this._container.roomSession.sendPollRejectMessage(_loc2_.id);
                    break;
                case RoomWidgetPollMessage.ANSWER:
                    this._container.roomSession.sendPollAnswerMessage(_loc2_.id, _loc2_.questionId, _loc2_.answers);
                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomSessionPollEvent.var_397);
            _loc1_.push(RoomSessionPollEvent.var_61);
            _loc1_.push(RoomSessionPollEvent.var_396);
            return _loc1_;
        }

        public function processEvent(param1: Event): void
        {
            var _loc3_: RoomWidgetPollUpdateEvent;
            if (this._container == null || this._container.events == null)
            {
                return;
            }

            var _loc2_: RoomSessionPollEvent = param1 as RoomSessionPollEvent;
            if (_loc2_ == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomSessionPollEvent.var_397:
                    _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id, RoomWidgetPollUpdateEvent.var_397);
                    _loc3_.summary = _loc2_.summary;
                    break;
                case RoomSessionPollEvent.var_61:
                    _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id, RoomWidgetPollUpdateEvent.var_61);
                    _loc3_.summary = _loc2_.summary;
                    break;
                case RoomSessionPollEvent.var_396:
                    _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id, RoomWidgetPollUpdateEvent.var_396);
                    _loc3_.startMessage = _loc2_.startMessage;
                    _loc3_.endMessage = _loc2_.endMessage;
                    _loc3_.numQuestions = _loc2_.numQuestions;
                    _loc3_.questionArray = _loc2_.questionArray;
                    break;
            }

            if (_loc3_ == null)
            {
                return;
            }

            this._container.events.dispatchEvent(_loc3_);
        }

        public function update(): void
        {
        }

    }
}
