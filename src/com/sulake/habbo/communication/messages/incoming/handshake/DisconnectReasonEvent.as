package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;

    public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent 
    {

        public static const var_1574:int = 0;
        public static const var_1575:int = 1;
        public static const var_1576:int = 2;
        public static const var_1577:int = 3;
        public static const var_1578:int = 4;
        public static const var_1579:int = 5;
        public static const var_1580:int = 10;
        public static const var_1581:int = 11;
        public static const var_1582:int = 12;
        public static const var_1583:int = 13;
        public static const var_1584:int = 16;
        public static const var_1585:int = 17;
        public static const var_1586:int = 18;
        public static const var_1587:int = 19;
        public static const var_1588:int = 20;
        public static const var_1589:int = 22;
        public static const var_1590:int = 23;
        public static const var_1591:int = 24;
        public static const var_1592:int = 25;
        public static const var_1593:int = 26;
        public static const var_1594:int = 27;
        public static const var_1595:int = 28;
        public static const var_1596:int = 29;
        public static const var_1597:int = 100;
        public static const var_1598:int = 101;
        public static const var_1599:int = 102;
        public static const var_1600:int = 103;
        public static const var_1601:int = 104;
        public static const var_1602:int = 105;
        public static const var_1603:int = 106;
        public static const var_1604:int = 107;
        public static const var_1605:int = 108;
        public static const var_1606:int = 109;
        public static const var_1607:int = 110;
        public static const var_1608:int = 111;
        public static const var_1609:int = 112;
        public static const var_1610:int = 113;
        public static const var_1611:int = 114;
        public static const var_1612:int = 115;
        public static const var_1613:int = 116;
        public static const var_1614:int = 117;
        public static const var_1615:int = 118;
        public static const var_1616:int = 119;

        public function DisconnectReasonEvent(param1:Function)
        {
            super(param1, DisconnectReasonParser);
        }

        public function get reason():int
        {
            return ((this.var_361 as DisconnectReasonParser).reason);
        }

        public function get reasonString():String
        {
            switch (this.reason)
            {
                case var_1575:
                case var_1580:
                    return ("banned");
                case var_1576:
                    return ("concurrentlogin");
                default:
                    return ("logout");
            };
        }

    }
}