package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;

    public class IssueManager 
    {

        public static const var_1526:String = "issue_bundle_open";
        public static const var_1527:String = "issue_bundle_my";
        public static const var_1528:String = "issue_bundle_picked";
        public static const var_1529:int = 15000;

        private var var_3663:ModerationManager;
        private var var_3667:IssueBrowser;
        private var _issues:Map;
        private var var_3673:Map;
        private var var_3674:Map;
        private var var_3675:Array;
        private var var_3676:Array;
        private var var_3677:Map;
        private var var_3678:int = 1;
        private var var_3679:int;
        private var var_3672:Timer;

        public function IssueManager(param1:ModerationManager)
        {
            this.var_3663 = param1;
            this._issues = new Map();
            this.var_3673 = new Map();
            this.var_3674 = new Map();
            this.var_3667 = new IssueBrowser(this, this.var_3663.windowManager, this.var_3663.assets);
            this.var_3675 = [];
            this.var_3676 = [];
            this.var_3677 = new Map();
            this.var_3679 = parseInt(this.var_3663.configuration.getKey("chf.score.updatefactor", "60"));
            this.var_3672 = new Timer(var_1529, 0);
            this.var_3672.addEventListener(TimerEvent.TIMER, this.updatePriorities);
            this.var_3672.start();
        }

        public function init():void
        {
            this.var_3667.show();
        }

        public function pickBundle(param1:int, param2:Boolean=false, param3:int=0):void
        {
            var _loc4_:IssueBundle = (this.var_3673.getValue(param1) as IssueBundle);
            if (_loc4_ == null)
            {
                return;
            };
            this.sendPick(_loc4_.getIssueIds(), param2, param3);
            this.var_3675 = this.var_3675.concat(_loc4_.getIssueIds());
        }

        public function autoPick(param1:Boolean=false, param2:int=0):void
        {
            var _loc4_:IssueBundle;
            var _loc5_:IssueBundle;
            var _loc3_:Array = this.var_3673.getValues();
            for each (_loc5_ in _loc3_)
            {
                if (((_loc5_.state == IssueMessageData.var_1530) && ((_loc4_ == null) || (_loc5_.prioritySum > _loc4_.prioritySum))))
                {
                    _loc4_ = _loc5_;
                };
            };
            if (_loc4_ == null)
            {
                return;
            };
            this.pickBundle(_loc4_.id, param1, param2);
        }

        public function releaseAll():void
        {
            var _loc3_:IssueBundle;
            if (this.var_3673 == null)
            {
                return;
            };
            var _loc1_:int = this.var_3663.sessionDataManager.userId;
            var _loc2_:Array = [];
            for each (_loc3_ in this.var_3673)
            {
                if (((_loc3_.state == IssueMessageData.var_1531) && (_loc3_.pickerUserId == _loc1_)))
                {
                    _loc2_ = _loc2_.concat(_loc3_.getIssueIds());
                };
            };
            this.sendRelease(_loc2_);
        }

        public function releaseBundle(param1:int):void
        {
            if (this.var_3673 == null)
            {
                return;
            };
            var _loc2_:IssueBundle = (this.var_3673.getValue(param1) as IssueBundle);
            if (_loc2_ == null)
            {
                return;
            };
            this.sendRelease(_loc2_.getIssueIds());
        }

        private function sendRelease(param1:Array):void
        {
            if (((((param1 == null) || (param1.length == 0)) || (this.var_3663 == null)) || (this.var_3663.connection == null)))
            {
                return;
            };
            this.var_3663.connection.send(new ReleaseIssuesMessageComposer(param1));
            this.var_3676 = this.var_3676.concat(param1);
        }

        public function playSound(param1:IssueMessageData):void
        {
            if (this._issues[param1.issueId] != null)
            {
                return;
            };
            if (((this.var_3667 == null) || (!(this.var_3667.isOpen()))))
            {
                this.var_3663.soundManager.playSound(HabboSoundTypesEnum.var_170);
            };
        }

        public function updateIssue(param1:IssueMessageData):void
        {
            var _loc3_:IssueBundle;
            var _loc4_:IssueBundle;
            var _loc5_:int;
            var _loc6_:Array;
            var _loc7_:Boolean;
            var _loc8_:IssueBundle;
            var _loc9_:int;
            if (param1 == null)
            {
                return;
            };
            this._issues.remove(param1.issueId);
            this._issues.add(param1.issueId, param1);
            var _loc2_:int = int(this.var_3674.getValue(param1.issueId));
            if (_loc2_ != 0)
            {
                _loc3_ = (this.var_3673.getValue(_loc2_) as IssueBundle);
                if (_loc3_ != null)
                {
                    if (this.validateBundle(_loc3_, param1))
                    {
                        _loc3_.updateIssue(param1);
                    }
                    else
                    {
                        _loc3_.removeIssue(param1.issueId);
                        if (_loc3_.getIssueCount() == 0)
                        {
                            this.var_3673.remove(_loc3_.id);
                            this.removeHandler(_loc3_.id);
                        };
                        this.var_3674.remove(param1.issueId);
                        _loc3_ = null;
                    };
                };
            };
            if (param1.state == IssueMessageData.var_1532)
            {
                this._issues.remove(param1.issueId);
                return;
            };
            if (_loc3_ == null)
            {
                for each (_loc4_ in this.var_3673)
                {
                    if (this.validateBundle(_loc4_, param1))
                    {
                        _loc3_ = _loc4_;
                        _loc3_.updateIssue(param1);
                        this.var_3674.add(param1.issueId, _loc3_.id);
                        break;
                    };
                };
            };
            if (_loc3_ == null)
            {
                _loc2_ = this.var_3678++;
                _loc3_ = new IssueBundle(_loc2_, param1);
                this.var_3674.add(param1.issueId, _loc2_);
                this.var_3673.add(_loc2_, _loc3_);
            };
            if (_loc3_ == null)
            {
                return;
            };
            if (this.var_3675.indexOf(param1.issueId) != -1)
            {
                this.handleBundle(_loc3_.id);
                _loc5_ = this.var_3663.sessionDataManager.userId;
                if (_loc5_ != param1.pickerUserId)
                {
                    if (param1.state == IssueMessageData.var_1531)
                    {
                        this.unhandleBundle(_loc3_.id);
                    };
                };
            };
            if (param1.state == IssueMessageData.var_1530)
            {
                _loc6_ = this.getBundles(var_1527);
                _loc7_ = false;
                for each (_loc8_ in _loc6_)
                {
                    if (this.validateBundle(_loc8_, param1, true))
                    {
                        _loc7_ = true;
                        break;
                    };
                };
                _loc9_ = this.var_3676.indexOf(param1.issueId);
                if (((_loc9_ == -1) && (_loc7_)))
                {
                    this.sendPick([param1.issueId]);
                }
                else
                {
                    this.var_3676.splice(_loc9_, 1);
                };
            };
            this.updateHandler(_loc3_.id);
            this.var_3667.update();
        }

        public function updatePriorities(param1:Event=null):void
        {
            var _loc3_:Number;
            var _loc4_:IssueMessageData;
            if (((this.var_3663 == null) || (this.var_3663.configuration == null)))
            {
                return;
            };
            var _loc2_:int = getTimer();
            for each (_loc4_ in this._issues)
            {
                if (_loc4_ != null)
                {
                    _loc3_ = ((_loc2_ - _loc4_.timeStamp) / 1000);
                    _loc4_.temporalPriority = int((_loc3_ / this.var_3679));
                };
            };
            if (this.var_3667 != null)
            {
                this.var_3667.update();
            };
        }

        private function updateHandler(param1:int):void
        {
            var _loc2_:IssueHandler = (this.var_3677.getValue(param1) as IssueHandler);
            if (_loc2_ != null)
            {
                _loc2_.update();
            };
        }

        public function removeHandler(param1:int):void
        {
            var _loc2_:IssueHandler = (this.var_3677.remove(param1) as IssueHandler);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
                _loc2_ = null;
            };
        }

        public function removeIssue(param1:int):void
        {
            var _loc3_:IssueBundle;
            if (this._issues == null)
            {
                return;
            };
            var _loc2_:int = this.var_3674.getValue(param1);
            if (_loc2_ != 0)
            {
                _loc3_ = (this.var_3673.getValue(_loc2_) as IssueBundle);
                if (_loc3_ != null)
                {
                    _loc3_.removeIssue(param1);
                    if (_loc3_.getIssueCount() == 0)
                    {
                        this.var_3673.remove(_loc3_.id);
                    };
                };
            };
            this._issues.remove(param1);
            this.var_3667.update();
        }

        public function getBundles(param1:String):Array
        {
            var _loc4_:IssueBundle;
            if (this.var_3673 == null)
            {
                return ([]);
            };
            var _loc2_:Array = [];
            var _loc3_:int = this.var_3663.sessionDataManager.userId;
            for each (_loc4_ in this.var_3673)
            {
                switch (param1)
                {
                    case var_1526:
                        if (_loc4_.state == IssueMessageData.var_1530)
                        {
                            _loc2_.push(_loc4_);
                        };
                        break;
                    case var_1527:
                        if (((_loc4_.state == IssueMessageData.var_1531) && (_loc4_.pickerUserId == _loc3_)))
                        {
                            _loc2_.push(_loc4_);
                        };
                        break;
                    case var_1528:
                        if (((_loc4_.state == IssueMessageData.var_1531) && (!(_loc4_.pickerUserId == _loc3_))))
                        {
                            _loc2_.push(_loc4_);
                        };
                        break;
                };
            };
            return (_loc2_);
        }

        public function handleBundle(param1:int):void
        {
            var _loc2_:IssueBundle = (this.var_3673.getValue(param1) as IssueBundle);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IssueHandler = new IssueHandler(this.var_3663, _loc2_);
            this.removeHandler(param1);
            this.var_3677.add(param1, _loc3_);
            this.var_3663.windowTracker.show(_loc3_, null, false, false, false);
            this.var_3675 = [];
        }

        public function unhandleBundle(param1:int):void
        {
            var _loc2_:IssueBundle = (this.var_3673.getValue(param1) as IssueBundle);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IssueHandler = this.var_3677.remove(param1);
            if (_loc3_ != null)
            {
                _loc3_.dispose();
            };
        }

        public function closeBundle(param1:int, param2:int):void
        {
            var _loc3_:IssueBundle = (this.var_3673.getValue(param1) as IssueBundle);
            if (_loc3_ == null)
            {
                return;
            };
            this.sendClose(_loc3_.getIssueIds(), param2);
        }

        public function closeIssue(param1:int, param2:int):void
        {
            this.sendClose([param1], param2);
        }

        private function sendClose(param1:Array, param2:int):void
        {
            if ((((param1 == null) || (this.var_3663 == null)) || (this.var_3663.connection == null)))
            {
                return;
            };
            this.var_3663.connection.send(new CloseIssuesMessageComposer(param1, param2));
        }

        private function sendPick(param1:Array, param2:Boolean=false, param3:int=0):void
        {
            if ((((param1 == null) || (this.var_3663 == null)) || (this.var_3663.connection == null)))
            {
                return;
            };
            this.var_3663.connection.send(new PickIssuesMessageComposer(param1, param2, param3));
        }

        private function validateBundle(param1:IssueBundle, param2:IssueMessageData, param3:Boolean=false):Boolean
        {
            if (param2.reportedUserId == 0)
            {
                return (false);
            };
            if (param1.reportedUserId != param2.reportedUserId)
            {
                return (false);
            };
            if (!param3)
            {
                if (param1.state != param2.state)
                {
                    return (false);
                };
                if (param1.pickerUserId != param2.pickerUserId)
                {
                    return (false);
                };
            };
            return (true);
        }

        public function autoHandle(param1:int):void
        {
            var _loc3_:IssueBundle;
            var _loc5_:IssueBundle;
            var _loc2_:Array = this.var_3673.getValues();
            var _loc4_:int = this.var_3663.sessionDataManager.userId;
            for each (_loc5_ in _loc2_)
            {
                if (((((_loc5_.state == IssueMessageData.var_1531) && (_loc5_.pickerUserId == _loc4_)) && (!(_loc5_.id == param1))) && ((_loc3_ == null) || (_loc5_.prioritySum > _loc3_.prioritySum))))
                {
                    _loc3_ = _loc5_;
                };
            };
            if (_loc3_ == null)
            {
                this.autoPick();
                return;
            };
            this.handleBundle(_loc3_.id);
        }

        public function issuePickFailed(param1:Array):Boolean
        {
            var _loc4_:IssueMessageData;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:int;
            var _loc8_:IssueBundle;
            var _loc9_:IssueBundle;
            var _loc10_:Array;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:IssueHandler;
            if (!param1)
            {
                return (false);
            };
            var _loc2_:Boolean;
            var _loc3_:int = this.var_3663.sessionDataManager.userId;
            for each (_loc4_ in param1)
            {
                _loc5_ = _loc4_.issueId;
                _loc6_ = _loc4_.pickerUserName;
                _loc7_ = _loc4_.pickerUserId;
                if (((!(_loc7_ == -1)) && (!(_loc7_ == _loc3_))))
                {
                    _loc2_ = true;
                };
                _loc8_ = null;
                for each (_loc9_ in this.var_3673)
                {
                    _loc10_ = _loc9_.getIssueIds();
                    if (_loc10_ != null)
                    {
                        for each (_loc11_ in _loc10_)
                        {
                            if (_loc5_ == _loc11_)
                            {
                                _loc8_ = _loc9_;
                                break;
                            };
                        };
                    };
                };
                if (_loc8_ != null)
                {
                    _loc12_ = _loc8_.id;
                    _loc13_ = (this.var_3677.getValue(_loc12_) as IssueHandler);
                    if (_loc13_ != null)
                    {
                        _loc13_.dispose();
                    };
                    this.releaseBundle(_loc12_);
                };
            };
            return (_loc2_);
        }

    }
}