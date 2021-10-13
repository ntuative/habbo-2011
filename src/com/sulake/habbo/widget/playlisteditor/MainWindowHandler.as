package com.sulake.habbo.widget.playlisteditor
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.sound.ISongInfo;

    public class MainWindowHandler 
    {

        private static const var_4871:int = 6;
        private static const var_4872:int = 9;
        private static const var_4873:int = 5;

        private var _widget:PlayListEditorWidget;
        private var var_4478:IHabboMusicController;
        private var var_3431:IWindowContainer;
        private var var_4874:IBorderWindow;
        private var var_4875:IBorderWindow;
        private var var_4876:MusicInventoryGridView;
        private var var_4877:PlayListEditorItemListView;
        private var var_4878:MusicInventoryStatusView;
        private var var_4879:PlayListStatusView;
        private var var_4880:IScrollbarWindow;
        private var var_4881:IScrollbarWindow;

        public function MainWindowHandler(param1:PlayListEditorWidget, param2:IHabboMusicController)
        {
            var _loc4_:String;
            var _loc5_:BitmapData;
            super();
            this._widget = param1;
            this.var_4478 = param2;
            var _loc3_:Array = [PlayListEditorWidgetAssetsEnum.var_1798, PlayListEditorWidgetAssetsEnum.var_1799, PlayListEditorWidgetAssetsEnum.var_1800, PlayListEditorWidgetAssetsEnum.var_1801, PlayListEditorWidgetAssetsEnum.var_1802];
            for each (_loc4_ in _loc3_)
            {
                _loc5_ = this._widget.getImageGalleryAssetBitmap(_loc4_);
                if (_loc5_ != null)
                {
                    _loc5_.dispose();
                }
                else
                {
                    this._widget.retrieveWidgetImage(_loc4_);
                };
            };
            this.createWindow();
            this.var_4876 = new MusicInventoryGridView(param1, this.getMusicInventoryGrid(), param2);
            this.var_4877 = new PlayListEditorItemListView(param1, this.getPlayListEditorItemList());
            this.var_4878 = new MusicInventoryStatusView(param1, this.getMusicInventoryStatusContainer());
            this.var_4879 = new PlayListStatusView(param1, this.getPlayListStatusContainer());
            this.refreshLoadableAsset();
            this.var_4478.events.addEventListener(SongDiskInventoryReceivedEvent.var_938, this.onSongDiskInventoryReceivedEvent);
            this.var_4478.events.addEventListener(PlayListStatusEvent.PLAY_LIST_UPDATED, this.onPlayListUpdatedEvent);
            this.var_4478.events.addEventListener(PlayListStatusEvent.var_1705, this.onPlayListFullEvent);
            this.var_4478.events.addEventListener(NowPlayingEvent.var_1704, this.onNowPlayingChanged);
            this.var_4478.events.addEventListener(NowPlayingEvent.var_940, this.onNowPlayingChanged);
            this.var_4478.events.addEventListener(NowPlayingEvent.var_936, this.onNowPlayingChanged);
        }

        public function get window():IWindow
        {
            return (this.var_3431);
        }

        public function get musicInventoryView():MusicInventoryGridView
        {
            return (this.var_4876);
        }

        public function get playListEditorView():PlayListEditorItemListView
        {
            return (this.var_4877);
        }

        public function destroy():void
        {
            if (this.var_4478)
            {
                this.var_4478.stop(HabboMusicPrioritiesEnum.var_935);
                this.var_4478.events.removeEventListener(SongDiskInventoryReceivedEvent.var_938, this.onSongDiskInventoryReceivedEvent);
                this.var_4478.events.removeEventListener(PlayListStatusEvent.PLAY_LIST_UPDATED, this.onPlayListUpdatedEvent);
                this.var_4478.events.removeEventListener(PlayListStatusEvent.var_1705, this.onPlayListFullEvent);
                this.var_4478.events.removeEventListener(NowPlayingEvent.var_1704, this.onNowPlayingChanged);
                this.var_4478.events.removeEventListener(NowPlayingEvent.var_940, this.onNowPlayingChanged);
                this.var_4478.events.removeEventListener(NowPlayingEvent.var_936, this.onNowPlayingChanged);
                this.var_4478 = null;
            };
            if (this.var_4876)
            {
                this.var_4876.destroy();
                this.var_4876 = null;
            };
            if (this.var_4877)
            {
                this.var_4877.destroy();
                this.var_4877 = null;
            };
            if (this.var_4879)
            {
                this.var_4879.destroy();
                this.var_4879 = null;
            };
            if (this.var_4878)
            {
                this.var_4878.destroy();
                this.var_4878 = null;
            };
            this.var_3431.destroy();
            this.var_3431 = null;
        }

        public function hide():void
        {
            this.var_3431.visible = false;
            if (this._widget != null)
            {
                this._widget.stopUserSong();
            };
        }

        public function show():void
        {
            this.var_4478.requestUserSongDisks();
            var _loc1_:IPlayListController = this.var_4478.getRoomItemPlaylist();
            if (_loc1_ != null)
            {
                _loc1_.requestPlayList();
                this.selectPlayListStatusViewByFurniPlayListState();
            };
            this.var_3431.visible = true;
        }

        public function refreshLoadableAsset(param1:String=""):void
        {
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_1798)))
            {
                this.assignWindowBitmapByAsset(this.var_4874, "music_inventory_splash_image", PlayListEditorWidgetAssetsEnum.var_1798);
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_1799)))
            {
                this.assignWindowBitmapByAsset(this.var_4875, "playlist_editor_splash_image", PlayListEditorWidgetAssetsEnum.var_1799);
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_1800)))
            {
                this.var_4878.setPreviewPlayingBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_1800));
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_1801)))
            {
                this.var_4878.setGetMoreMusicBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_1801));
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_1802)))
            {
                this.var_4879.addSongsBackgroundImage = this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_1802);
            };
        }

        private function assignWindowBitmapByAsset(param1:IWindowContainer, param2:String, param3:String):void
        {
            var _loc5_:BitmapData;
            var _loc4_:IBitmapWrapperWindow = (param1.getChildByName(param2) as IBitmapWrapperWindow);
            if (_loc4_ != null)
            {
                _loc5_ = this._widget.getImageGalleryAssetBitmap(param3);
                if (_loc5_ != null)
                {
                    _loc4_.bitmap = _loc5_;
                    _loc4_.width = _loc5_.width;
                    _loc4_.height = _loc5_.height;
                };
            };
        }

        private function createWindow():void
        {
            if (this._widget == null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this._widget.assets.getAssetByName("playlisteditor_main_window") as XmlAsset);
            Logger.log(("Show window: " + _loc1_));
            this.var_3431 = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            if (this.var_3431 == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this.var_3431.position = new Point(80, 0);
            var _loc2_:IWindowContainer = (this.var_3431.getChildByName("content_area") as IWindowContainer);
            if (_loc2_ == null)
            {
                throw (new Error("Window is missing 'content_area' element"));
            };
            this.var_4874 = (_loc2_.getChildByName("my_music_border") as IBorderWindow);
            this.var_4875 = (_loc2_.getChildByName("playlist_border") as IBorderWindow);
            if (this.var_4874 == null)
            {
                throw (new Error("Window content area is missing 'my_music_border' window element"));
            };
            if (this.var_4875 == null)
            {
                throw (new Error("Window content area is missing 'playlist_border' window element"));
            };
            this.var_4880 = (this.var_4874.getChildByName("music_inventory_scrollbar") as IScrollbarWindow);
            this.var_4881 = (this.var_4875.getChildByName("playlist_scrollbar") as IScrollbarWindow);
            if (this.var_4880 == null)
            {
                throw (new Error("Window content area is missing 'music_inventory_scrollbar' window element"));
            };
            if (this.var_4881 == null)
            {
                throw (new Error("Window content area is missing 'playlist_scrollbar' window element"));
            };
            var _loc3_:IWindow = this.var_3431.findChildByTag("close");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
        }

        private function getMusicInventoryGrid():IItemGridWindow
        {
            return (this.var_4874.getChildByName("music_inventory_itemgrid") as IItemGridWindow);
        }

        private function getPlayListEditorItemList():IItemListWindow
        {
            return (this.var_4875.getChildByName("playlist_editor_itemlist") as IItemListWindow);
        }

        private function getMusicInventoryStatusContainer():IWindowContainer
        {
            return (this.var_4874.getChildByName("preview_play_container") as IWindowContainer);
        }

        private function getPlayListStatusContainer():IWindowContainer
        {
            return (this.var_4875.getChildByName("now_playing_container") as IWindowContainer);
        }

        private function selectPlayListStatusViewByFurniPlayListState():void
        {
            var _loc1_:IPlayListController = this.var_4478.getRoomItemPlaylist();
            if (_loc1_ == null)
            {
                return;
            };
            if (_loc1_.isPlaying)
            {
                this.var_4879.selectView(PlayListStatusView.var_1803);
            }
            else
            {
                if (_loc1_.length > 0)
                {
                    this.var_4879.selectView(PlayListStatusView.var_1804);
                }
                else
                {
                    this.var_4879.selectView(PlayListStatusView.var_1805);
                };
            };
        }

        private function selectMusicStatusViewByMusicState():void
        {
            if (this.isPreviewPlaying())
            {
                this.var_4878.show();
                this.var_4878.selectView(MusicInventoryStatusView.var_1806);
            }
            else
            {
                if (this.var_4478.getSongDiskInventorySize() <= var_4871)
                {
                    this.var_4878.show();
                    this.var_4878.selectView(MusicInventoryStatusView.var_1807);
                }
                else
                {
                    this.var_4878.hide();
                };
            };
        }

        private function updatePlaylistEditorView():void
        {
            var _loc4_:int;
            var _loc5_:ISongInfo;
            var _loc1_:IPlayListController = this.var_4478.getRoomItemPlaylist();
            var _loc2_:Array = [];
            var _loc3_:int = -1;
            if (_loc1_ != null)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc1_.length)
                {
                    _loc5_ = _loc1_.getEntry(_loc4_);
                    if (_loc5_ != null)
                    {
                        _loc2_.push(_loc5_);
                    };
                    _loc4_++;
                };
                _loc3_ = _loc1_.playPosition;
            };
            this.var_4877.refresh(_loc2_, _loc3_);
        }

        private function onPlayListUpdatedEvent(param1:PlayListStatusEvent):void
        {
            var _loc4_:ISongInfo;
            this.updatePlaylistEditorView();
            this.selectPlayListStatusViewByFurniPlayListState();
            var _loc2_:IPlayListController = this.var_4478.getRoomItemPlaylist();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = _loc2_.nowPlayingSongId;
            if (_loc3_ != -1)
            {
                _loc4_ = this.var_4478.getSongInfo(_loc3_);
                this.var_4879.nowPlayingTrackName = _loc4_.name;
                this.var_4879.nowPlayingAuthorName = _loc4_.creator;
            };
            this.var_4881.visible = (_loc2_.length > var_4873);
        }

        private function onPlayListFullEvent(param1:PlayListStatusEvent):void
        {
            this._widget.alertPlayListFull();
        }

        private function onSongDiskInventoryReceivedEvent(param1:SongDiskInventoryReceivedEvent):void
        {
            this.var_4876.refresh();
            this.selectMusicStatusViewByMusicState();
            this.var_4880.visible = (this.var_4876.itemCount > var_4872);
        }

        private function onNowPlayingChanged(param1:NowPlayingEvent):void
        {
            var _loc2_:ISongInfo;
            var _loc3_:ISongInfo;
            switch (param1.type)
            {
                case NowPlayingEvent.var_1704:
                    this.selectPlayListStatusViewByFurniPlayListState();
                    this.var_4877.setItemIndexPlaying(param1.position);
                    if (param1.id != -1)
                    {
                        _loc3_ = this.var_4478.getSongInfo(param1.id);
                        if (_loc3_ != null)
                        {
                            this.var_4879.nowPlayingTrackName = _loc3_.name;
                            this.var_4879.nowPlayingAuthorName = _loc3_.creator;
                        }
                        else
                        {
                            this.var_4879.nowPlayingTrackName = "";
                            this.var_4879.nowPlayingAuthorName = "";
                        };
                    };
                    return;
                case NowPlayingEvent.var_940:
                    this.var_4876.setPreviewIconToPause();
                    _loc2_ = this.var_4478.getSongInfo(param1.id);
                    if (_loc2_ != null)
                    {
                        this.var_4878.songName = _loc2_.name;
                        this.var_4878.authorName = _loc2_.creator;
                    }
                    else
                    {
                        this.var_4878.songName = "";
                        this.var_4878.authorName = "";
                    };
                    this.selectMusicStatusViewByMusicState();
                    return;
                case NowPlayingEvent.var_936:
                    this.var_4876.setPreviewIconToPlay();
                    this.selectMusicStatusViewByMusicState();
                    return;
            };
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this.hide();
        }

        private function isPreviewPlaying():Boolean
        {
            return (!(this.var_4478.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum.var_935) == -1));
        }

    }
}