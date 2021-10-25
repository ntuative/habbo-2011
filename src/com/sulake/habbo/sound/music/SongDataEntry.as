package com.sulake.habbo.sound.music
{

    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.IHabboSound;

    public class SongDataEntry extends PlayListEntry implements ISongInfo
    {

        private var var_4482: IHabboSound = null;
        private var var_3068: String;
        private var var_4483: int = -1;

        public function SongDataEntry(param1: int, param2: int, param3: String, param4: String, param5: IHabboSound)
        {
            this.var_4482 = param5;
            this.var_3068 = "";
            super(param1, param2, param3, param4);
        }

        override public function get id(): int
        {
            return _id;
        }

        override public function get length(): int
        {
            return _length;
        }

        override public function get name(): String
        {
            return _songName;
        }

        override public function get creator(): String
        {
            return _songCreator;
        }

        public function get loaded(): Boolean
        {
            return this.var_4482 == null ? false : this.var_4482.ready;
        }

        public function get soundObject(): IHabboSound
        {
            return this.var_4482;
        }

        public function get songData(): String
        {
            return this.var_3068;
        }

        public function get diskId(): int
        {
            return this.var_4483;
        }

        public function set soundObject(param1: IHabboSound): void
        {
            this.var_4482 = param1;
        }

        public function set songData(param1: String): void
        {
            this.var_3068 = param1;
        }

        public function set diskId(param1: int): void
        {
            this.var_4483 = param1;
        }

    }
}
