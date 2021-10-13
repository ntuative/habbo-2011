package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IPlayListController;
    import flash.utils.Timer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.IHabboSound;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
    import com.sulake.habbo.sound.*;

    public class HabboMusicController implements IHabboMusicController, IDisposable 
    {

        public static const var_929:int = -1;
        private static const var_939:int = HabboMusicPrioritiesEnum.var_930;//0

        private var _soundManager:HabboSoundManagerFlash10;
        private var _connection:IConnection;
        private var _events:IEventDispatcher;
        private var var_4378:IEventDispatcher;
        private var var_4469:Map = new Map();
        private var var_4470:Map = new Map();
        private var var_4471:Array = new Array();
        private var var_4472:IPlayListController = null;
        private var _disposed:Boolean = false;
        private var var_4467:Array = [];
        private var var_4468:Array = [];
        private var _priorityPlaying:int = -1;
        private var var_4473:int = -1;
        private var var_4474:int = -1;
        private var var_4466:Timer;
        private var var_3348:Map = new Map();
        private var var_4475:Array = new Array();
        private var var_4465:Array = [];
        private var var_4476:int = -1;
        private var var_4477:int = -1;

        public function HabboMusicController(param1:HabboSoundManagerFlash10, param2:IEventDispatcher, param3:IEventDispatcher, param4:IConnection)
        {
            var _loc5_:IMessageEvent;
            var _loc6_:int;
            super();
            this._soundManager = param1;
            this._events = param2;
            this.var_4378 = param3;
            this._connection = param4;
            this.var_4465.push(new TraxSongInfoMessageEvent(this.onSongInfoMessage));
            this.var_4465.push(new UserSongDisksInventoryMessageEvent(this.onSongDiskInventoryMessage));
            for each (_loc5_ in this.var_4465)
            {
                this._connection.addMessageEvent(_loc5_);
            };
            this.var_4378.addEventListener(RoomEngineSoundMachineEvent.var_931, this.onJukeboxInit);
            this.var_4378.addEventListener(RoomEngineSoundMachineEvent.var_420, this.onJukeboxDispose);
            this.var_4378.addEventListener(RoomEngineSoundMachineEvent.var_932, this.onSoundMachineInit);
            this.var_4378.addEventListener(RoomEngineSoundMachineEvent.var_933, this.onSoundMachineDispose);
            this.var_4466 = new Timer(1000);
            this.var_4466.start();
            this.var_4466.addEventListener(TimerEvent.TIMER, this.sendNextSongRequestMessage);
            this._events.addEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
            _loc6_ = 0;
            while (_loc6_ < HabboMusicPrioritiesEnum.var_934)
            {
                this.var_4467[_loc6_] = null;
                this.var_4468[_loc6_] = 0;
                _loc6_++;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get events():IEventDispatcher
        {
            return (this._events);
        }

        protected function onSongFinishedPlayingEvent(param1:SoundCompleteEvent):void
        {
            var _loc2_:int;
            Logger.log((("Song " + param1.id) + " finished playing"));
            if (this.getSongIdPlayingAtPriority(this._priorityPlaying) == param1.id)
            {
                if (((this.getTopRequestPriority() == this._priorityPlaying) && (this.getSongRequestCountAtPriority(this._priorityPlaying) == this.var_4474)))
                {
                    this.resetSongStartRequest(this._priorityPlaying);
                };
                _loc2_ = this._priorityPlaying;
                this.playSongWithHighestPriority();
                if (_loc2_ >= HabboMusicPrioritiesEnum.var_935)
                {
                    this._events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.var_936, _loc2_, param1.id, -1));
                };
            };
        }

        public function dispose():void
        {
            var _loc1_:IMessageEvent;
            var _loc2_:int;
            var _loc3_:SongDataEntry;
            var _loc4_:IHabboSound;
            if (!this._disposed)
            {
                this._soundManager = null;
                this.var_4471 = null;
                if (this._connection)
                {
                    for each (_loc1_ in this.var_4465)
                    {
                        this._connection.removeMessageEvent(_loc1_);
                        _loc1_.dispose();
                    };
                    this.var_4465 = null;
                    this._connection = null;
                };
                if (this.var_4472)
                {
                    this.var_4472.dispose();
                    this.var_4472 = null;
                };
                if (this.var_4469)
                {
                    _loc2_ = 0;
                    while (_loc2_ < this.var_4469.length)
                    {
                        _loc3_ = (this.var_4469.getWithIndex(_loc2_) as SongDataEntry);
                        _loc4_ = (_loc3_.soundObject as IHabboSound);
                        if (_loc4_ != null)
                        {
                            _loc4_.stop();
                        };
                        _loc3_.soundObject = null;
                        _loc2_++;
                    };
                    this.var_4469.dispose();
                    this.var_4469 = null;
                };
                if (this.var_4470 != null)
                {
                    this.var_4470.dispose();
                    this.var_4470 = null;
                };
                this.var_4466.stop();
                this.var_4466 = null;
                if (this.var_4378)
                {
                    this.var_4378.removeEventListener(RoomEngineSoundMachineEvent.var_931, this.onJukeboxInit);
                    this.var_4378.removeEventListener(RoomEngineSoundMachineEvent.var_420, this.onJukeboxDispose);
                    this.var_4378.removeEventListener(RoomEngineSoundMachineEvent.var_932, this.onSoundMachineInit);
                    this.var_4378.removeEventListener(RoomEngineSoundMachineEvent.var_933, this.onSoundMachineDispose);
                };
                if (this.var_3348 != null)
                {
                    this.var_3348.dispose();
                    this.var_3348 = null;
                };
                this._disposed = true;
            };
        }

        public function getRoomItemPlaylist(param1:int=-1):IPlayListController
        {
            return (this.var_4472);
        }

        private function addSongStartRequest(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number):Boolean
        {
            if (((param1 < 0) || (param1 >= HabboMusicPrioritiesEnum.var_934)))
            {
                return (false);
            };
            var _loc7_:SongStartRequestData = new SongStartRequestData(param2, param3, param4, param5, param6);
            this.var_4467[param1] = _loc7_;
            this.var_4468[param1] = (this.var_4468[param1] + 1);
            return (true);
        }

        private function getSongStartRequest(param1:int):SongStartRequestData
        {
            return (this.var_4467[param1]);
        }

        private function getSongIdRequestedAtPriority(param1:int):int
        {
            if (((param1 < 0) || (param1 >= HabboMusicPrioritiesEnum.var_934)))
            {
                return (-1);
            };
            if (this.var_4467[param1] == null)
            {
                return (-1);
            };
            var _loc2_:SongStartRequestData = this.var_4467[param1];
            return (_loc2_.songId);
        }

        private function getSongRequestCountAtPriority(param1:int):int
        {
            if (((param1 < 0) || (param1 >= HabboMusicPrioritiesEnum.var_934)))
            {
                return (-1);
            };
            return (this.var_4468[param1]);
        }

        private function getTopRequestPriority():int
        {
            var _loc1_:int = (this.var_4467.length - 1);
            while (_loc1_ >= 0)
            {
                if (this.var_4467[_loc1_] != null)
                {
                    return (_loc1_);
                };
                _loc1_--;
            };
            return (-1);
        }

        private function resetSongStartRequest(param1:int):void
        {
            if (((param1 >= 0) && (param1 < HabboMusicPrioritiesEnum.var_934)))
            {
                this.var_4467[param1] = null;
            };
        }

        private function reRequestSongAtPriority(param1:int):void
        {
            this.var_4468[param1] = (this.var_4468[param1] + 1);
        }

        private function processSongEntryForPlaying(param1:int, param2:Boolean=true):Boolean
        {
            var _loc3_:SongDataEntry = this.getSongDataEntry(param1);
            if (_loc3_ == null)
            {
                this.addSongInfoRequest(param1);
                return (false);
            };
            if (_loc3_.soundObject == null)
            {
                _loc3_.soundObject = this._soundManager.loadTraxSong(_loc3_.id, _loc3_.songData);
            };
            var _loc4_:IHabboSound = _loc3_.soundObject;
            if (!_loc4_.ready)
            {
                return (false);
            };
            return (true);
        }

        public function playSong(param1:int, param2:int, param3:Number=0, param4:Number=0, param5:Number=0.5, param6:Number=0.5):Boolean
        {
            Logger.log((("Requesting " + param1) + " for playing"));
            if (!this.addSongStartRequest(param2, param1, param3, param4, param5, param6))
            {
                return (false);
            };
            if (!this.processSongEntryForPlaying(param1))
            {
                return (false);
            };
            if (param2 >= this._priorityPlaying)
            {
                this.playSongObject(param2, param1);
            }
            else
            {
                Logger.log(((("Higher priority song blocked playing. Stored song " + param1) + " for priority ") + param2));
            };
            return (true);
        }

        private function playSongWithHighestPriority():void
        {
            var _loc3_:int;
            this._priorityPlaying = -1;
            this.var_4473 = -1;
            this.var_4474 = -1;
            var _loc1_:int = this.getTopRequestPriority();
            var _loc2_:int = _loc1_;
            while (_loc2_ >= 0)
            {
                _loc3_ = this.getSongIdRequestedAtPriority(_loc2_);
                if (((_loc3_ >= 0) && (this.playSongObject(_loc2_, _loc3_))))
                {
                    return;
                };
                _loc2_--;
            };
        }

        public function stop(param1:int):void
        {
            var _loc2_:* = (param1 == this._priorityPlaying);
            var _loc3_:* = (this.getTopRequestPriority() == param1);
            if (_loc2_)
            {
                this.stopSongAtPriority(param1);
            }
            else
            {
                this.resetSongStartRequest(param1);
                if (((!(_loc2_)) && (_loc3_)))
                {
                    this.reRequestSongAtPriority(this._priorityPlaying);
                };
            };
        }

        private function stopSongAtPriority(param1:int):Boolean
        {
            var _loc2_:int;
            var _loc3_:SongDataEntry;
            if (((param1 == this._priorityPlaying) && (this._priorityPlaying >= 0)))
            {
                _loc2_ = this.getSongIdPlayingAtPriority(param1);
                if (_loc2_ >= 0)
                {
                    _loc3_ = this.getSongDataEntry(_loc2_);
                    this.stopSongDataEntry(_loc3_);
                    return (true);
                };
            };
            return (false);
        }

        private function stopSongDataEntry(param1:SongDataEntry):void
        {
            var _loc2_:IHabboSound;
            if (param1 != null)
            {
                Logger.log(("Stopping current song " + param1.id));
                _loc2_ = param1.soundObject;
                if (_loc2_ != null)
                {
                    _loc2_.stop();
                };
            };
        }

        private function getSongDataEntry(param1:int):SongDataEntry
        {
            var _loc2_:SongDataEntry;
            if (this.var_4469 != null)
            {
                _loc2_ = (this.var_4469.getValue(param1) as SongDataEntry);
            };
            return (_loc2_);
        }

        public function updateVolume(param1:Number):void
        {
            var _loc3_:int;
            var _loc4_:SongDataEntry;
            var _loc2_:int;
            while (_loc2_ < HabboMusicPrioritiesEnum.var_934)
            {
                _loc3_ = this.getSongIdPlayingAtPriority(_loc2_);
                if (_loc3_ >= 0)
                {
                    _loc4_ = (this.getSongDataEntry(_loc3_) as SongDataEntry);
                    if (_loc4_ != null)
                    {
                        _loc4_.soundObject.volume = param1;
                    };
                };
                _loc2_++;
            };
        }

        public function onSongLoaded(param1:int):void
        {
            var _loc3_:int;
            Logger.log(("Song loaded : " + param1));
            var _loc2_:int = this.getTopRequestPriority();
            if (_loc2_ >= 0)
            {
                _loc3_ = this.getSongIdRequestedAtPriority(_loc2_);
                if (param1 == _loc3_)
                {
                    this.playSongObject(_loc2_, param1);
                };
            };
        }

        public function addSongInfoRequest(param1:int):void
        {
            this.requestSong(param1, true);
        }

        public function requestSongInfoWithoutSamples(param1:int):void
        {
            this.requestSong(param1, false);
        }

        private function requestSong(param1:int, param2:Boolean):void
        {
            if (this.var_4470.getValue(param1) == null)
            {
                this.var_4470.add(param1, param2);
                this.var_4471.push(param1);
            };
        }

        public function getSongInfo(param1:int):ISongInfo
        {
            var _loc2_:SongDataEntry = this.getSongDataEntry(param1);
            if (_loc2_ == null)
            {
                this.requestSongInfoWithoutSamples(param1);
            };
            return (_loc2_);
        }

        public function requestUserSongDisks():void
        {
            if (this._connection == null)
            {
                return;
            };
            this._connection.send(new GetUserSongDisksMessageComposer());
        }

        public function getSongDiskInventorySize():int
        {
            return (this.var_3348.length);
        }

        public function getSongDiskInventoryDiskId(param1:int):int
        {
            if (((param1 >= 0) && (param1 < this.var_3348.length)))
            {
                return (this.var_3348.getKey(param1));
            };
            return (-1);
        }

        public function getSongDiskInventorySongId(param1:int):int
        {
            if (((param1 >= 0) && (param1 < this.var_3348.length)))
            {
                return (this.var_3348.getWithIndex(param1));
            };
            return (-1);
        }

        public function getSongIdPlayingAtPriority(param1:int):int
        {
            if (param1 != this._priorityPlaying)
            {
                return (-1);
            };
            return (this.var_4473);
        }

        private function sendNextSongRequestMessage(param1:TimerEvent):void
        {
            if (this.var_4471.length < 1)
            {
                return;
            };
            if (this._connection == null)
            {
                return;
            };
            this._connection.send(new GetSongInfoMessageComposer(this.var_4471));
            Logger.log(("Requested song info's : " + this.var_4471));
            this.var_4471 = new Array();
        }

        private function onSongInfoMessage(param1:IMessageEvent):void
        {
            var _loc6_:SongInfoEntry;
            var _loc7_:Boolean;
            var _loc8_:Boolean;
            var _loc9_:IHabboSound;
            var _loc10_:SongDataEntry;
            var _loc11_:int;
            var _loc12_:int;
            var _loc2_:TraxSongInfoMessageEvent = (param1 as TraxSongInfoMessageEvent);
            var _loc3_:TraxSongInfoMessageParser = (_loc2_.getParser() as TraxSongInfoMessageParser);
            var _loc4_:Array = _loc3_.songs;
            var _loc5_:int;
            while (_loc5_ < _loc4_.length)
            {
                _loc6_ = _loc4_[_loc5_];
                _loc7_ = (this.getSongDataEntry(_loc6_.id) == null);
                _loc8_ = this.areSamplesRequested(_loc6_.id);
                if (_loc7_)
                {
                    _loc9_ = null;
                    if (_loc8_)
                    {
                        _loc9_ = this._soundManager.loadTraxSong(_loc6_.id, _loc6_.data);
                    };
                    _loc10_ = new SongDataEntry(_loc6_.id, _loc6_.length, _loc6_.name, _loc6_.creator, _loc9_);
                    _loc10_.songData = _loc6_.data;
                    this.var_4469.add(_loc6_.id, _loc10_);
                    _loc11_ = this.getTopRequestPriority();
                    _loc12_ = this.getSongIdRequestedAtPriority(_loc11_);
                    if ((((!(_loc9_ == null)) && (_loc9_.ready)) && (_loc6_.id == _loc12_)))
                    {
                        this.playSongObject(_loc11_, _loc12_);
                    };
                    this._events.dispatchEvent(new SongInfoReceivedEvent(SongInfoReceivedEvent.var_937, _loc6_.id));
                    while (this.var_4475.indexOf(_loc6_.id) != -1)
                    {
                        this.var_4475.splice(this.var_4475.indexOf(_loc6_.id), 1);
                        if (this.var_4475.length == 0)
                        {
                            this._events.dispatchEvent(new SongDiskInventoryReceivedEvent(SongDiskInventoryReceivedEvent.var_938));
                        };
                    };
                    Logger.log(("Received song info : " + _loc6_.id));
                };
                _loc5_++;
            };
        }

        private function playSongObject(param1:int, param2:int):Boolean
        {
            if ((((param2 == -1) || (param1 < 0)) || (param1 >= HabboMusicPrioritiesEnum.var_934)))
            {
                return (false);
            };
            var _loc3_:Boolean;
            if (this.stopSongAtPriority(this._priorityPlaying))
            {
                _loc3_ = true;
            };
            var _loc4_:SongDataEntry = this.getSongDataEntry(param2);
            if (_loc4_ == null)
            {
                Logger.log((("WARNING: Unable to find song entry id " + param2) + " that was supposed to be loaded."));
                return (false);
            };
            var _loc5_:IHabboSound = _loc4_.soundObject;
            if (((_loc5_ == null) || (!(_loc5_.ready))))
            {
                return (false);
            };
            if (_loc3_)
            {
                Logger.log(("Waiting previous song to stop before playing song " + param2));
                return (true);
            };
            _loc5_.volume = this._soundManager.volume;
            var _loc6_:Number = var_929;
            var _loc7_:Number = 0;
            var _loc8_:Number = 2;
            var _loc9_:Number = 1;
            var _loc10_:SongStartRequestData = this.getSongStartRequest(param1);
            if (_loc10_ != null)
            {
                _loc6_ = _loc10_.startPos;
                _loc7_ = _loc10_.playLength;
                _loc8_ = _loc10_.fadeInSeconds;
                _loc9_ = _loc10_.fadeOutSeconds;
            };
            if (_loc6_ >= (_loc4_.length / 1000))
            {
                return (false);
            };
            if (_loc6_ == var_929)
            {
                _loc6_ = 0;
            };
            _loc5_.fadeInSeconds = _loc8_;
            _loc5_.fadeOutSeconds = _loc9_;
            _loc5_.position = _loc6_;
            _loc5_.play(_loc7_);
            this._priorityPlaying = param1;
            this.var_4474 = this.getSongRequestCountAtPriority(param1);
            this.var_4473 = param2;
            if (this._priorityPlaying <= var_939)
            {
                this.notifySongPlaying(_loc4_);
            };
            if (param1 > HabboMusicPrioritiesEnum.var_930)
            {
                this._events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.var_940, param1, _loc4_.id, -1));
            };
            Logger.log(((((((((("Started playing song " + param2) + " at position ") + _loc6_) + " for ") + _loc7_) + " seconds (length ") + (_loc4_.length / 1000)) + ") with priority ") + param1));
            return (true);
        }

        private function notifySongPlaying(param1:SongDataEntry):void
        {
            var _loc2_:* = 8000;
            var _loc3_:int = getTimer();
            if (((param1.length >= _loc2_) && ((!(this.var_4476 == param1.id)) || (_loc3_ > (this.var_4477 + _loc2_)))))
            {
                this._soundManager.notifyPlayedSong(param1.name, param1.creator);
                this.var_4476 = param1.id;
                this.var_4477 = _loc3_;
            };
        }

        private function areSamplesRequested(param1:int):Boolean
        {
            if (this.var_4470.getValue(param1) == null)
            {
                return (false);
            };
            return (this.var_4470.getValue(param1));
        }

        private function onSongDiskInventoryMessage(param1:IMessageEvent):void
        {
            var _loc5_:int;
            var _loc6_:int;
            var _loc2_:UserSongDisksInventoryMessageEvent = (param1 as UserSongDisksInventoryMessageEvent);
            var _loc3_:UserSongDisksInventoryMessageParser = (_loc2_.getParser() as UserSongDisksInventoryMessageParser);
            this.var_3348.reset();
            var _loc4_:int;
            while (_loc4_ < _loc3_.songDiskCount)
            {
                _loc5_ = _loc3_.getDiskId(_loc4_);
                _loc6_ = _loc3_.getSongId(_loc4_);
                this.var_3348.add(_loc5_, _loc6_);
                if (this.var_4469.getValue(_loc6_) == null)
                {
                    this.var_4475.push(_loc6_);
                    this.requestSongInfoWithoutSamples(_loc6_);
                };
                _loc4_++;
            };
            if (this.var_4475.length == 0)
            {
                this._events.dispatchEvent(new SongDiskInventoryReceivedEvent(SongDiskInventoryReceivedEvent.var_938));
            };
        }

        private function onSoundMachineInit(param1:Event):void
        {
            this.disposeRoomPlaylist();
            this.var_4472 = (new SoundMachinePlayListController(this._soundManager, this, this._events, this.var_4378, this._connection) as IPlayListController);
        }

        private function onSoundMachineDispose(param1:Event):void
        {
            this.disposeRoomPlaylist();
        }

        private function onJukeboxInit(param1:Event):void
        {
            this.disposeRoomPlaylist();
            this.var_4472 = (new JukeboxPlayListController(this._soundManager, this, this._events, this._connection) as IPlayListController);
            this._connection.send(new GetNowPlayingMessageComposer());
        }

        private function onJukeboxDispose(param1:Event):void
        {
            this.disposeRoomPlaylist();
        }

        private function disposeRoomPlaylist():void
        {
            if (this.var_4472 != null)
            {
                this.var_4472.dispose();
                this.var_4472 = null;
            };
        }

    }
}