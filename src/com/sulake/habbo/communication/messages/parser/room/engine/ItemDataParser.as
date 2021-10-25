package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataParser
    {

        public static function parseItemData(param1: IMessageDataWrapper): ItemMessageData
        {
            var _loc11_: String;
            var _loc12_: String;
            var _loc13_: int;
            var _loc14_: int;
            var _loc15_: int;
            var _loc16_: int;
            var _loc17_: String;
            var _loc18_: Array;
            var _loc19_: Number;
            var _loc20_: Number;
            var _loc21_: Number;
            var _loc2_: int = int(param1.readString());
            var _loc3_: int = param1.readInteger();
            var _loc4_: String = param1.readString();
            var _loc5_: String = param1.readString();
            var _loc6_: int;
            var _loc7_: Number = parseFloat(_loc5_);
            if (!isNaN(_loc7_))
            {
                _loc6_ = int(_loc5_);
            }

            Logger.log("\n\n PARSING WALL ITEM: ");
            Logger.log("wallItemId: " + _loc2_);
            Logger.log("wallItemTypeId: " + _loc3_);
            Logger.log("location: " + _loc4_);
            Logger.log("dataStr: " + _loc5_);
            Logger.log("state: " + _loc6_);
            var _loc8_: ItemMessageData;
            var _loc9_: Array;
            var _loc10_: String;
            if (_loc4_.indexOf(":") == 0)
            {
                _loc8_ = new ItemMessageData(_loc2_, _loc3_, false);
                _loc9_ = _loc4_.split(" ");
                if (_loc9_.length >= 3)
                {
                    _loc11_ = String(_loc9_[0]);
                    _loc12_ = String(_loc9_[1]);
                    _loc10_ = String(_loc9_[2]);
                    if (_loc11_.length > 3 && _loc12_.length > 2)
                    {
                        _loc11_ = _loc11_.substr(3);
                        _loc12_ = _loc12_.substr(2);
                        _loc9_ = _loc11_.split(",");
                        if (_loc9_.length >= 2)
                        {
                            _loc13_ = int(_loc9_[0]);
                            _loc14_ = int(_loc9_[1]);
                            _loc9_ = _loc12_.split(",");
                            if (_loc9_.length >= 2)
                            {
                                _loc15_ = int(_loc9_[0]);
                                _loc16_ = int(_loc9_[1]);
                                _loc8_.wallX = _loc13_;
                                _loc8_.wallY = _loc14_;
                                _loc8_.localX = _loc15_;
                                _loc8_.localY = _loc16_;
                                _loc8_.dir = _loc10_;
                                _loc8_.data = _loc5_;
                                _loc8_.state = _loc6_;
                            }

                        }

                    }

                }

            }
            else
            {
                _loc8_ = new ItemMessageData(_loc2_, _loc3_, true);
                _loc9_ = _loc4_.split(" ");
                if (_loc9_.length >= 2)
                {
                    _loc10_ = String(_loc9_[0]);
                    if (_loc10_ == "rightwall" || _loc10_ == "frontwall")
                    {
                        _loc10_ = "r";
                    }
                    else
                    {
                        _loc10_ = "l";
                    }

                    _loc17_ = String(_loc9_[1]);
                    _loc18_ = _loc17_.split(",");
                    if (_loc18_.length >= 3)
                    {
                        _loc19_ = 0;
                        _loc20_ = parseFloat(_loc18_[0]);
                        _loc21_ = parseFloat(_loc18_[1]);
                        _loc8_.y = _loc20_;
                        _loc8_.z = _loc21_;
                        _loc8_.dir = _loc10_;
                        _loc8_.data = _loc5_;
                        _loc8_.state = _loc6_;
                    }

                }

            }

            return _loc8_;
        }

    }
}
