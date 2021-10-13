package com.sulake.habbo.sound.trax
{
    import com.sulake.habbo.sound.IHabboSound;
    import __AS3__.vec.Vector;
    import flash.events.IEventDispatcher;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.media.SoundTransform;
    import flash.events.SampleDataEvent;
    import flash.events.TimerEvent;
    import flash.utils.ByteArray;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import __AS3__.vec.*;

    public class TraxSequencer implements IHabboSound 
    {

        private static const var_924:Number = 44100;
        private static const var_923:uint = 0x2000;
        private static const var_926:uint = 88000;
        private static const var_925:uint = 88000;
        private static const var_927:Vector.<Number> = new Vector.<Number>(var_923, true);

        private var _events:IEventDispatcher;
        private var var_3346:Number;
        private var var_4493:Sound;
        private var var_4489:SoundChannel;
        private var var_4494:TraxData;
        private var var_4495:Map;
        private var var_2000:Boolean;
        private var var_2941:int;
        private var var_4496:int = 0;
        private var var_4497:uint;
        private var var_4498:Array;
        private var var_4499:Boolean;
        private var var_4500:Boolean = true;
        private var var_4501:uint;
        private var var_4502:uint = uint(30);
        private var var_4503:Boolean;
        private var var_4504:Boolean;
        private var var_4505:int;
        private var var_4506:int;
        private var var_4507:int;
        private var var_4508:int;
        private var var_4509:Timer;
        private var var_4510:Timer;
        private var var_4511:int = 0;
        private var var_4512:int = 0;

        public function TraxSequencer(param1:int, param2:TraxData, param3:Map, param4:IEventDispatcher)
        {
            this._events = param4;
            this.var_2941 = param1;
            this.var_3346 = 1;
            this.var_4493 = new Sound();
            this.var_4489 = null;
            this.var_4495 = param3;
            this.var_4494 = param2;
            this.var_4495 = param3;
            this.var_2000 = true;
            this.var_4497 = 0;
            this.var_4498 = [];
            this.var_4499 = false;
            this.var_4501 = 0;
            this.var_4500 = false;
            this.var_4503 = false;
            this.var_4504 = false;
            this.var_4505 = 0;
            this.var_4506 = 0;
            this.var_4507 = 0;
            this.var_4508 = 0;
        }

        public function set position(param1:Number):void
        {
            this.var_4497 = uint((param1 * var_924));
        }

        public function get volume():Number
        {
            return (this.var_3346);
        }

        public function get position():Number
        {
            return (this.var_4497 / var_924);
        }

        public function get ready():Boolean
        {
            return (this.var_2000);
        }

        public function set ready(param1:Boolean):void
        {
            this.var_2000 = param1;
        }

        public function get finished():Boolean
        {
            return (this.var_4500);
        }

        public function get fadeOutSeconds():Number
        {
            return (this.var_4506 / var_924);
        }

        public function set fadeOutSeconds(param1:Number):void
        {
            this.var_4506 = int((param1 * var_924));
        }

        public function get fadeInSeconds():Number
        {
            return (this.var_4505 / var_924);
        }

        public function set fadeInSeconds(param1:Number):void
        {
            this.var_4505 = int((param1 * var_924));
        }

        public function get traxData():TraxData
        {
            return (this.var_4494);
        }

        public function set volume(param1:Number):void
        {
            this.var_3346 = param1;
            if (this.var_4489 != null)
            {
                this.var_4489.soundTransform = new SoundTransform(this.var_3346);
            };
        }

        public function get length():Number
        {
            return (this.var_4501 / var_924);
        }

        public function prepare():Boolean
        {
            if (!this.var_2000)
            {
                Logger.log("Cannot start trax playback until samples ready!");
                return (false);
            };
            if (!this.var_4499)
            {
                if (!this.prepareSequence())
                {
                    Logger.log("Cannot start playback, prepare sequence failed!");
                    return (false);
                };
            };
            return (true);
        }

        private function prepareSequence():Boolean
        {
            var _loc2_:Map;
            var _loc3_:TraxChannel;
            var _loc4_:uint;
            var _loc5_:uint;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:TraxSample;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc1_:int;
            while (_loc1_ < this.var_4494.channels.length)
            {
                _loc2_ = new Map();
                _loc3_ = (this.var_4494.channels[_loc1_] as TraxChannel);
                _loc4_ = 0;
                _loc5_ = 0;
                _loc6_ = 0;
                while (_loc6_ < _loc3_.itemCount)
                {
                    _loc7_ = _loc3_.getItem(_loc6_).id;
                    _loc8_ = (this.var_4495.getValue(_loc7_) as TraxSample);
                    if (_loc8_ != null)
                    {
                        _loc9_ = this.getSampleBars(_loc8_.length);
                        _loc10_ = int((_loc3_.getItem(_loc6_).length / _loc9_));
                        _loc11_ = 0;
                        while (_loc11_ < _loc10_)
                        {
                            if (_loc7_ != 0)
                            {
                                _loc2_.add(_loc4_, _loc8_);
                            };
                            _loc5_ = (_loc5_ + _loc9_);
                            _loc4_ = (_loc5_ * var_925);
                            _loc11_++;
                        };
                    }
                    else
                    {
                        Logger.log("Error in prepareSequence(), sample was null!");
                        return (false);
                    };
                    if (this.var_4501 < _loc4_)
                    {
                        this.var_4501 = _loc4_;
                    };
                    _loc6_++;
                };
                this.var_4498.push(_loc2_);
                _loc1_++;
            };
            this.var_4499 = true;
            return (true);
        }

        public function play(param1:Number=0):Boolean
        {
            if (!this.prepare())
            {
                return (false);
            };
            this.removeFadeoutStopTimer();
            if (this.var_4489 != null)
            {
                this.stopImmediately();
            };
            if (this.var_4505 > 0)
            {
                this.var_4503 = true;
                this.var_4507 = 0;
            };
            this.var_4504 = false;
            this.var_4508 = 0;
            this.var_4500 = false;
            this.var_4493.addEventListener(SampleDataEvent.SAMPLE_DATA, this.onSampleData);
            this.var_4496 = (param1 * var_924);
            this.var_4511 = 0;
            this.var_4512 = 0;
            this.var_4489 = this.var_4493.play();
            return (true);
        }

        public function render(param1:SampleDataEvent):Boolean
        {
            if (!this.prepare())
            {
                return (false);
            };
            while ((!(this.var_4500)))
            {
                this.onSampleData(param1);
            };
            return (true);
        }

        public function stop():Boolean
        {
            if (((this.var_4506 > 0) && (!(this.var_4500))))
            {
                this.stopWithFadeout();
            }
            else
            {
                this.playingComplete();
            };
            return (true);
        }

        private function stopImmediately():void
        {
            this.removeStopTimer();
            if (this.var_4489 != null)
            {
                this.var_4489.stop();
                this.var_4489 = null;
            };
            this.var_4493.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.onSampleData);
        }

        private function stopWithFadeout():void
        {
            if (this.var_4509 == null)
            {
                this.var_4504 = true;
                this.var_4508 = 0;
                this.var_4509 = new Timer((this.var_4502 + (this.var_4506 / (var_924 / 1000))), 1);
                this.var_4509.start();
                this.var_4509.addEventListener(TimerEvent.TIMER_COMPLETE, this.onFadeOutComplete);
            };
        }

        private function getSampleBars(param1:uint):int
        {
            return (Math.ceil((param1 / var_926)));
        }

        private function getChannelSequenceOffsets():Array
        {
            var _loc4_:Map;
            var _loc5_:int;
            var _loc1_:Array = [];
            var _loc2_:int = this.var_4498.length;
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = this.var_4498[_loc3_];
                _loc5_ = 0;
                while (((_loc5_ < _loc4_.length) && (_loc4_.getKey(_loc5_) < this.var_4497)))
                {
                    _loc5_++;
                };
                _loc1_.push((_loc5_ - 1));
                _loc3_++;
            };
            return (_loc1_);
        }

        private function mixChannelsIntoBuffer():void
        {
            var _loc5_:Map;
            var _loc6_:int;
            var _loc7_:TraxSample;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            var _loc1_:Array = this.getChannelSequenceOffsets();
            var _loc2_:int = this.var_4498.length;
            var _loc3_:TraxChannelSample;
            var _loc4_:int = (_loc2_ - 1);
            while (_loc4_ >= 0)
            {
                _loc5_ = this.var_4498[_loc4_];
                _loc6_ = _loc1_[_loc4_];
                _loc7_ = _loc5_.getWithIndex(_loc6_);
                if (_loc7_ == null)
                {
                    _loc3_ = null;
                }
                else
                {
                    _loc10_ = _loc5_.getKey(_loc6_);
                    _loc11_ = (this.var_4497 - _loc10_);
                    if (((_loc7_.id == 0) || (_loc11_ < 0)))
                    {
                        _loc3_ = null;
                    }
                    else
                    {
                        _loc3_ = new TraxChannelSample(_loc7_, _loc11_);
                    };
                };
                _loc8_ = var_923;
                if ((this.var_4501 - this.var_4497) < _loc8_)
                {
                    _loc8_ = (this.var_4501 - this.var_4497);
                };
                _loc9_ = 0;
                while (_loc9_ < _loc8_)
                {
                    _loc12_ = _loc8_;
                    if (_loc6_ < (_loc5_.length - 1))
                    {
                        _loc13_ = _loc5_.getKey((_loc6_ + 1));
                        if ((_loc8_ + this.var_4497) >= _loc13_)
                        {
                            _loc12_ = (_loc13_ - this.var_4497);
                        };
                    };
                    if (_loc12_ > (_loc8_ - _loc9_))
                    {
                        _loc12_ = (_loc8_ - _loc9_);
                    };
                    if (_loc4_ == (_loc2_ - 1))
                    {
                        if (_loc3_ != null)
                        {
                            _loc3_.setSample(var_927, _loc9_, _loc12_);
                            _loc9_ = (_loc9_ + _loc12_);
                        }
                        else
                        {
                            _loc14_ = 0;
                            while (_loc14_ < _loc12_)
                            {
                                var _loc15_:* = _loc9_++;
                                var_927[_loc15_] = 0;
                                _loc14_++;
                            };
                        };
                    }
                    else
                    {
                        if (_loc3_ != null)
                        {
                            _loc3_.addSample(var_927, _loc9_, _loc12_);
                        };
                        _loc9_ = (_loc9_ + _loc12_);
                    };
                    if (_loc9_ < _loc8_)
                    {
                        _loc7_ = _loc5_.getWithIndex(++_loc6_);
                        if (((_loc7_ == null) || (_loc7_.id == 0)))
                        {
                            _loc3_ = null;
                        }
                        else
                        {
                            _loc3_ = new TraxChannelSample(_loc7_, 0);
                        };
                    };
                };
                _loc4_--;
            };
        }

        private function checkSongFinishing():void
        {
            var _loc1_:int = ((this.var_4501 < this.var_4496) ? this.var_4501 : ((this.var_4496 > 0) ? this.var_4496 : this.var_4501));
            if (((this.var_4497 > (_loc1_ + (this.var_4502 * (var_924 / 1000)))) && (!(this.var_4500))))
            {
                this.var_4500 = true;
                if (this.var_4510 != null)
                {
                    this.var_4510.reset();
                    this.var_4510.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
                };
                this.var_4510 = new Timer(2, 1);
                this.var_4510.start();
                this.var_4510.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
            }
            else
            {
                if (((this.var_4497 > (_loc1_ - this.var_4506)) && (!(this.var_4504))))
                {
                    this.var_4503 = false;
                    this.var_4504 = true;
                    this.var_4508 = 0;
                };
            };
        }

        private function onSampleData(param1:SampleDataEvent):void
        {
            if (param1.position > this.var_4511)
            {
                this.var_4512++;
                Logger.log("Audio buffer under run...");
                this.var_4511 = param1.position;
            };
            if (this.volume > 0)
            {
                this.mixChannelsIntoBuffer();
            };
            var _loc2_:int = var_923;
            if ((this.var_4501 - this.var_4497) < _loc2_)
            {
                _loc2_ = (this.var_4501 - this.var_4497);
                if (_loc2_ < 0)
                {
                    _loc2_ = 0;
                };
            };
            if (this.volume <= 0)
            {
                _loc2_ = 0;
            };
            this.writeAudioToOutputStream(param1.data, _loc2_);
            this.var_4497 = (this.var_4497 + var_923);
            this.var_4511 = (this.var_4511 + var_923);
            if (this.var_4489 != null)
            {
                this.var_4502 = (((param1.position / var_924) * 1000) - this.var_4489.position);
            };
            this.checkSongFinishing();
        }

        private function writeAudioToOutputStream(param1:ByteArray, param2:int):void
        {
            var _loc5_:Number;
            var _loc6_:Number;
            if (param2 > 0)
            {
                if (((!(this.var_4503)) && (!(this.var_4504))))
                {
                    this.writeMixingBufferToOutputStream(param1, param2);
                }
                else
                {
                    if (this.var_4503)
                    {
                        _loc5_ = (1 / this.var_4505);
                        _loc6_ = (this.var_4507 / Number(this.var_4505));
                        this.var_4507 = (this.var_4507 + var_923);
                        if (this.var_4507 > this.var_4505)
                        {
                            this.var_4503 = false;
                        };
                    }
                    else
                    {
                        if (this.var_4504)
                        {
                            _loc5_ = (-1 / this.var_4506);
                            _loc6_ = (1 - (this.var_4508 / Number(this.var_4506)));
                            this.var_4508 = (this.var_4508 + var_923);
                            if (this.var_4508 > this.var_4506)
                            {
                                this.var_4508 = this.var_4506;
                            };
                        };
                    };
                    this.writeMixingBufferToOutputStreamWithFade(param1, param2, _loc6_, _loc5_);
                };
            };
            var _loc3_:Number = 0;
            var _loc4_:int = param2;
            while (_loc4_ < var_923)
            {
                param1.writeFloat(_loc3_);
                param1.writeFloat(_loc3_);
                _loc4_++;
            };
        }

        private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int):void
        {
            var _loc3_:Number = 0;
            var _loc4_:int;
            while (_loc4_ < param2)
            {
                _loc3_ = (var_927[_loc4_] * this.volume);
                param1.writeFloat(_loc3_);
                param1.writeFloat(_loc3_);
                _loc4_++;
            };
        }

        private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number):void
        {
            var _loc5_:Number = 0;
            var _loc6_:int;
            _loc6_ = 0;
            while (_loc6_ < param2)
            {
                if (((param3 < 0) || (param3 > 1))) break;
                _loc5_ = ((var_927[_loc6_] * this.volume) * param3);
                param3 = (param3 + param4);
                param1.writeFloat(_loc5_);
                param1.writeFloat(_loc5_);
                _loc6_++;
            };
            if (param3 < 0)
            {
                while (_loc6_ < param2)
                {
                    param1.writeFloat(0);
                    param1.writeFloat(0);
                    _loc6_++;
                };
            }
            else
            {
                if (param3 > 1)
                {
                    while (_loc6_ < param2)
                    {
                        _loc5_ = (var_927[_loc6_] * this.volume);
                        param3 = (param3 + param4);
                        param1.writeFloat(_loc5_);
                        param1.writeFloat(_loc5_);
                        _loc6_++;
                    };
                };
            };
        }

        private function onPlayingComplete(param1:TimerEvent):void
        {
            if (this.var_4500)
            {
                this.playingComplete();
            };
        }

        private function onFadeOutComplete(param1:TimerEvent):void
        {
            this.removeFadeoutStopTimer();
            this.playingComplete();
        }

        private function playingComplete():void
        {
            this.stopImmediately();
            this._events.dispatchEvent(new SoundCompleteEvent(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.var_2941));
        }

        private function removeFadeoutStopTimer():void
        {
            if (this.var_4509 != null)
            {
                this.var_4509.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onFadeOutComplete);
                this.var_4509.reset();
                this.var_4509 = null;
            };
        }

        private function removeStopTimer():void
        {
            if (this.var_4510 != null)
            {
                this.var_4510.reset();
                this.var_4510.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
                this.var_4510 = null;
            };
        }

    }
}