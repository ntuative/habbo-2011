package com.sulake.habbo.session.handler
{

    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.enum.GenericErrorEnum;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class GenericErrorHandler extends BaseHandler
    {

        public function GenericErrorHandler(param1: IConnection, param2: IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            }

            param1.addMessageEvent(new GenericErrorEvent(this.onGenericError));
        }

        private function onGenericError(param1: IMessageEvent): void
        {
            var _loc4_: String;
            var _loc2_: GenericErrorParser = (param1 as GenericErrorEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            }

            switch (_loc2_.errorCode)
            {
                case GenericErrorEnum.var_535:
                    _loc4_ = RoomSessionErrorMessageEvent.var_378;
                    break;
                case GenericErrorEnum.var_385:
                    _loc4_ = RoomSessionErrorMessageEvent.var_385;
                    break;
                case GenericErrorEnum.var_386:
                    _loc4_ = RoomSessionErrorMessageEvent.var_386;
                    break;
                case GenericErrorEnum.var_387:
                    _loc4_ = RoomSessionErrorMessageEvent.var_387;
                    break;
                default:
                    return;
            }

            if (listener && listener.events)
            {
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc4_, _loc3_));
            }

        }

    }
}
