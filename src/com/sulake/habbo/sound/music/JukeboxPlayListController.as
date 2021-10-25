package com.sulake.habbo.sound.music
{

    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.IHabboMusicController;

    import flash.events.IEventDispatcher;

    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;

    public class JukeboxPlayListController implements IPlayListController
    {

        private var _disposed: Boolean = false;
        private var var_3335: Boolean = false;
        private var var_3000: Array = [];
        private var var_4478: IHabboMusicController;
        private var _events: IEventDispatcher;
        private var _connection: IConnection;
        private var _soundManager: HabboSoundManagerFlash10;
        private var var_4479: int = -1;
        private var var_4480: Array = [];
        private var var_4465: Array;
        private var var_4481: int = -1;

        public function JukeboxPlayListController(param1: HabboSoundManagerFlash10, param2: HabboMusicController, param3: IEventDispatcher, param4: IConnection)
        {
            var _loc5_: IMessageEvent;
            super();
            this._soundManager = param1;
            this.var_4478 = param2;
            this._events = param3;
            this._connection = param4;
            this.var_4465 = [];
            this.var_4465.push(new NowPlayingMessageEvent(this.onNowPlayingMessage));
            this.var_4465.push(new JukeboxSongDisksMessageEvent(this.onJukeboxSongDisksMessage));
            this.var_4465.push(new JukeboxPlayListFullMessageEvent(this.onJukeboxPlayListFullMessage));
            for each (_loc5_ in this.var_4465)
            {
                this._connection.addMessageEvent(_loc5_);
            }

            this._events.addEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
            this.var_4478.events.addEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
        }

        public function get priority(): int
        {
            return HabboMusicPrioritiesEnum.var_930;
        }

        public function get nowPlayingSongId(): int
        {
            return this.var_4479;
        }

        public function get playPosition(): int
        {
            return this.var_4481;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get isPlaying(): Boolean
        {
            return this.var_3335;
        }

        public function get length(): int
        {
            if (this.var_3000 == null)
            {
                return 0;
            }

            return this.var_3000.length;
        }

        public function dispose(): void
        {
            var _loc1_: IMessageEvent;
            if (!this._disposed)
            {
                this.stopPlaying();
                if (this.var_4478.events)
                {
                    this.var_4478.events.removeEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
                }

                this.var_4478 = null;
                this._soundManager = null;
                if (this._connection)
                {
                    for each (_loc1_ in this.var_4465)
                    {
                        this._connection.removeMessageEvent(_loc1_);
                        _loc1_.dispose();
                    }

                    this.var_4465 = null;
                    this._connection = null;
                }

                if (this._events)
                {
                    this._events.removeEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
                    this._events = null;
                }

                this._disposed = true;
            }

        }

        public function stopPlaying(): void
        {
            this.var_4478.stop(this.priority);
            this.var_4479 = -1;
            this.var_4481 = -1;
            this.var_3335 = false;
        }

        public function requestPlayList(): void
        {
            if (this._connection == null)
            {
                return;
            }

            this._connection.send(new GetJukeboxPlayListMessageComposer());
        }

        public function getEntry(param1: int): ISongInfo
        {
            if (param1 < 0 || param1 >= this.var_3000.length)
            {
                return null;
            }

            return this.var_3000[param1];
        }

        protected function onSongFinishedPlayingEvent(param1: SoundCompleteEvent): void
        {
        }

        private function onNowPlayingMessage(param1: IMessageEvent): void
        {
            var _loc2_: NowPlayingMessageEvent = param1 as NowPlayingMessageEvent;
            var _loc3_: NowPlayingMessageParser = _loc2_.getParser() as NowPlayingMessageParser;
            Logger.log("Received Now Playing message with: " + _loc3_.currentSongId + ", " + _loc3_.nextSongId + ", " + _loc3_.syncCount);
            this.var_3335 = _loc3_.currentSongId != -1;
            if (_loc3_.currentSongId >= 0)
            {
                this.var_4478.playSong(_loc3_.currentSongId, HabboMusicPrioritiesEnum.var_930, _loc3_.syncCount / 1000, 0, 1, 1);
                this.var_4479 = _loc3_.currentSongId;
            }
            else
            {
                this.stopPlaying();
            }

            if (_loc3_.nextSongId >= 0)
            {
                this.var_4478.addSongInfoRequest(_loc3_.nextSongId);
            }

            this.var_4481 = _loc3_.currentPosition;
            this._soundManager.events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.var_1704, HabboMusicPrioritiesEnum.var_930, _loc3_.currentSongId, _loc3_.currentPosition));
        }

        private function onJukeboxSongDisksMessage(param1: IMessageEvent): void
        {
            var _loc5_: int;
            var _loc6_: int;
            var _loc7_: SongDataEntry;
            var _loc2_: JukeboxSongDisksMessageEvent = param1 as JukeboxSongDisksMessageEvent;
            var _loc3_: JukeboxSongDisksMessageParser = _loc2_.getParser() as JukeboxSongDisksMessageParser;
            Logger.log("Received Jukebox song disks (=playlist) message, length of playlist: " + _loc3_.songDisks.length);
            this.var_3000 = [];
            var _loc4_: int;
            while (_loc4_ < _loc3_.songDisks.length)
            {
                _loc5_ = _loc3_.songDisks.getWithIndex(_loc4_);
                _loc6_ = _loc3_.songDisks.getKey(_loc4_);
                _loc7_ = (this.var_4478.getSongInfo(_loc5_) as SongDataEntry);
                if (_loc7_ == null)
                {
                    _loc7_ = new SongDataEntry(_loc5_, -1, null, null, null);
                    if (this.var_4480.indexOf(_loc5_) < 0)
                    {
                        this.var_4480.push(_loc5_);
                        this.var_4478.requestSongInfoWithoutSamples(_loc5_);
                    }

                }

                _loc7_.diskId = _loc6_;
                this.var_3000.push(_loc7_);
                _loc4_++;
            }

            if (this.var_4480.length == 0)
            {
                this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.PLAY_LIST_UPDATED));
            }

        }

        private function onJukeboxPlayListFullMessage(param1: IMessageEvent): void
        {
            Logger.log("Received jukebox playlist full message.");
            this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.var_1705));
        }

        private function onSongInfoReceivedEvent(param1: SongInfoReceivedEvent): void
        {
            var _loc4_: ISongInfo;
            var _loc5_: int;
            var _loc6_: SongDataEntry;
            var _loc2_: int;
            while (_loc2_ < this.length)
            {
                _loc4_ = this.var_3000[_loc2_];
                if (_loc4_.id == param1.id)
                {
                    _loc5_ = _loc4_.diskId;
                    _loc6_ = (this.var_4478.getSongInfo(param1.id) as SongDataEntry);
                    if (_loc6_ != null)
                    {
                        _loc6_.diskId = _loc5_;
                        this.var_3000[_loc2_] = _loc6_;
                    }

                    break;
                }

                _loc2_++;
            }

            var _loc3_: int = this.var_4480.indexOf(param1.id);
            if (_loc3_ >= 0)
            {
                this.var_4480.splice(_loc3_, 1);
            }

            if (this.var_4480.length == 0)
            {
                this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.PLAY_LIST_UPDATED));
            }

        }

    }
}
