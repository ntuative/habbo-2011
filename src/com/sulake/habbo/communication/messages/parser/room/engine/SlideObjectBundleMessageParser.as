package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SlideObjectBundleMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _id: int;
        private var var_3307: Number;
        private var var_3308: String;
        private var _objectList: Array;
        private var _avatar: SlideObjectMessageData = null;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get avatar(): SlideObjectMessageData
        {
            return this._avatar;
        }

        public function get objectList(): Array
        {
            return this._objectList;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._id = -1;
            this._avatar = null;
            this._objectList = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var id: int;
            var slideObject: SlideObjectMessageData;
            var start: Vector3d;
            var target: Vector3d;
            var startZ: Number;
            var targetZ: Number;

            if (data == null)
            {
                return false;
            }

            var startX: Number = data.readInteger();
            var startY: Number = data.readInteger();
            var targetX: Number = data.readInteger();
            var targetY: Number = data.readInteger();
            
            this._objectList = [];
            
            var objectCount: int = data.readInteger();
            var i: int;
            
            while (i < objectCount)
            {
                id = data.readInteger();
                startZ = Number(data.readString());
                targetZ = Number(data.readString());
                start = new Vector3d(startX, startY, startZ);
                target = new Vector3d(targetX, targetY, targetZ);

                slideObject = new SlideObjectMessageData(id, start, target);
                
                this._objectList.push(slideObject);
                i++;
            }

            this._id = data.readInteger();
            
            var moveType: int = data.readInteger();
            
            switch (moveType)
            {
                case 0:
                    break;
                    
                case 1:
                    id = data.readInteger();
                    startZ = Number(data.readString());
                    targetZ = Number(data.readString());
                    start = new Vector3d(startX, startY, startZ);
                    target = new Vector3d(targetX, targetY, targetZ);
                    
                    this._avatar = new SlideObjectMessageData(id, start, target, SlideObjectMessageData.MV);
                    break;

                case 2:
                    id = data.readInteger();
                    startZ = Number(data.readString());
                    targetZ = Number(data.readString());
                    start = new Vector3d(startX, startY, startZ);
                    target = new Vector3d(targetX, targetY, targetZ);
                    
                    this._avatar = new SlideObjectMessageData(id, start, target, SlideObjectMessageData.SLD);
                    break;
                
                default:
                    Logger.log("** Incompatible character movetype!");
            }

            return true;
        }

    }
}
