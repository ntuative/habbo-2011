package
{

    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.display.StageScaleMode;
    import flash.display.StageQuality;
    import flash.display.StageAlign;
    import flash.events.ProgressEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.Capabilities;
    import flash.system.System;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import flash.events.StatusEvent;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;
    import flash.display.Bitmap;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.display.Stage;

    public class Habbo extends MovieClip
    {
        protected static var PROCESSLOG_ENABLED: Boolean = false;

        private static var _crashed: Boolean = false;
        private static var _crashURL: String = "";

        public static const CLIENT_STARTING: String = "client.starting";
        public static const CLIENT_INIT_CORE_FAIL: String = "client.init.core.fail";
        public static const CLIENT_INIT_CORE_INIT: String = "client.init.core.init";
        public static const CLIENT_INIT_START: String = "client.init.start";
        public static const CLIENT_INIT_SWF_ERROR: String = "client.init.swf.error";
        public static const CLIENT_INIT_SWF_LOADED: String = "client.init.swf.loaded";

        public static const ERROR_CATEGORY_DOWNLOAD_FONT: int = 11;
        public static const ERROR_CATEGORY_FINALIZE_PRELOADING: int = 9;

        public static const ERROR_VARIABLE_AVG_UPDATE: String = "avg_update";
        public static const ERROR_VARIABLE_CAT: String = "error_cat";
        public static const ERROR_VARIABLE_CRASH_TIME: String = "crash_time";
        public static const ERROR_VARIABLE_CTX: String = "error_ctx";
        public static const ERROR_VARIABLE_DATA: String = "error_data";
        public static const ERROR_VARIABLE_DEBUG: String = "debug";
        public static const ERROR_VARIABLE_DESC: String = "error_desc";
        public static const ERROR_VARIABLE_FLASH_VERSION: String = "flash_version";

        public static const FILE_LOADING_BAR: String = "fileLoadingBar";
        public static const FILE_BAR_SPRITE: String = "fileBarSprite";
        public static const BYTE_LOADING_BAR: String = "byteLoadingBar";
        public static const BYTE_BAR_SPRITE: String = "byteBarSprite";
        public static const BACKGROUND: String = "background";
        public static const HABBO_LOGO: String = "habboLogo";
        public static const TEXT_FIELD: String = "textField";

        private var _disposed: Boolean = false;
        private var _hasFinishedPreloading: Boolean = false;
        private var _clientLoadingScreen: DisplayObjectContainer;
        private var _httpStatus: int = 0;
        private var _clientStarted: int;
        private var _clientStartingMessage: String;
        private var _clientLoadingTextField: TextField;
        private var _timer: Timer;
        private var _clientLoadingText: Array;
        private var _clientLoadingTextIndex: int = 0;

        private var HabboLogoClass: Class = Habbo_habboLogoClass;
        private const _loadingTexts: Array = [
            [".", "..", "...", ""],
            [" [*    ]", " [ *   ]", " [  *  ]", " [   * ]", " [    *]", " [   * ]", " [  *  ]", " [ *   ]"],
            [".", "..", "....", "...", "..", ".", ""]
        ];

        public function Habbo()
        {
            stop();

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.quality = StageQuality.LOW;
            stage.align = StageAlign.TOP_LEFT;

            Habbo.PROCESSLOG_ENABLED = stage.loaderInfo.parameters["processlog.enabled"] == "1";

            trackLoginStep(CLIENT_INIT_START);

            var url_prefix: String = stage.loaderInfo.parameters["url_prefix"];

            if (url_prefix != null)
            {
                _crashURL = url_prefix + "/flash_client_error";
            }


            this.root.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
            this.root.loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
            this.root.loaderInfo.addEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
            this.root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);

            this._clientLoadingText = this._loadingTexts[int(Math.random() * (this._loadingTexts.length - 1))];

            this._timer = new Timer(250, 0);
            this._timer.addEventListener(TimerEvent.TIMER, this.onVisualizationUpdate);

            this._clientLoadingScreen = this.createLoadingScreen();
            addChild(this._clientLoadingScreen);

            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);

            this._clientStarted = getTimer();

            this.checkPreLoadingStatus();
        }

        public static function trackLoginStep(message: String): void
        {
            if (Habbo.PROCESSLOG_ENABLED)
            {
                Logger.log("* HabboMain Login Step: " + message);

                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", message);
                }
                else
                {
                    Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
                }

            }

        }

        public static function reportCrash(description: String, category: int, error: Error): void
        {
            if (!Habbo._crashed)
            {
                Habbo._crashed = true;

                var url: String = Habbo._crashURL;
                var request: URLRequest = new URLRequest(url);
                var requestData: URLVariables = new URLVariables();
                var context: String = "";

                requestData[ERROR_VARIABLE_CRASH_TIME] = new Date().getTime().toString();
                requestData[ERROR_VARIABLE_CTX] = context;
                requestData[ERROR_VARIABLE_FLASH_VERSION] = Capabilities.version;
                requestData[ERROR_VARIABLE_AVG_UPDATE] = 0;
                requestData[ERROR_VARIABLE_DESC] = description;
                requestData[ERROR_VARIABLE_CAT] = String(category);
                requestData[ERROR_VARIABLE_DEBUG] = "Memory usage: " + Math.round(System.totalMemory / (0x0400 * 0x0400)) + " MB";

                if (error != null)
                {
                    requestData[ERROR_VARIABLE_DATA] = String(error.getStackTrace());
                }


                request.method = URLRequestMethod.POST;
                request.data = requestData;

                navigateToURL(request, "_self");
            }

        }

        private function dispose(): void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            removeEventListener(Event.RESIZE, this.onResize);

            if (!this._disposed)
            {
                this._disposed = true;

                if (this._clientLoadingTextField != null)
                {
                    this._clientLoadingTextField = null;
                }


                if (this._clientLoadingScreen != null)
                {
                    this.disposeLoadingScreen(this._clientLoadingScreen);
                    removeChild(this._clientLoadingScreen);
                    this._clientLoadingScreen = null;
                }


                if (parent != null)
                {
                    parent.removeChild(this);
                }

            }

        }

        private function onLocalConnectionStatus(status: StatusEvent): void
        {
        }

        public function testLocalConnection(identifier: int): void
        {
            try
            {
                if (identifier != this._clientStarted)
                {
                    this.dispose();
                }

            }
            catch (e: Error)
            {
            }

        }

        private function onPreLoadingProgress(event: Event): void
        {
            this.checkPreLoadingStatus();

            if (this._clientLoadingScreen != null)
            {
                this.updateLoadingBar(this._clientLoadingScreen, this.root.loaderInfo.bytesLoaded / this.root.loaderInfo.bytesTotal);
            }

        }

        private function onPreLoadingStatus(httpEvent: HTTPStatusEvent): void
        {
            this._httpStatus = httpEvent.status;
        }

        private function onPreLoadingCompleted(event: Event): void
        {
            try
            {
                this.checkPreLoadingStatus();
            }
            catch (error: Error)
            {
                trackLoginStep(CLIENT_INIT_SWF_ERROR);

                reportCrash("Failed to finalize main swf preloading: " + error.message, ERROR_CATEGORY_FINALIZE_PRELOADING, error);
            }

        }

        private function onPreLoadingFailed(errorEvent: IOErrorEvent): void
        {
            trackLoginStep(CLIENT_INIT_SWF_ERROR);

            reportCrash(
                    "Failed to finalize main swf preloading: " + errorEvent.text + " / HTTP status: " + this._httpStatus,
                    ERROR_CATEGORY_FINALIZE_PRELOADING,
                    null
            );
        }

        private function checkPreLoadingStatus(): void
        {
            if (!this._hasFinishedPreloading)
            {
                if (this.root.loaderInfo.bytesLoaded == this.root.loaderInfo.bytesTotal)
                {
                    this.finalizePreloading();
                }

            }

        }

        private function finalizePreloading(): void
        {
            if (!this._hasFinishedPreloading)
            {
                this._hasFinishedPreloading = true;

                trackLoginStep(CLIENT_INIT_SWF_LOADED);

                if (this._clientLoadingScreen != null)
                {
                    var byteLoadingBar: Sprite = this._clientLoadingScreen.getChildByName(BYTE_LOADING_BAR) as Sprite;
                    byteLoadingBar.visible = false;
                }


                this.root.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
                this.root.loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
                this.root.loaderInfo.removeEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
                this.root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);

                nextFrame();

                var HabboMainClass: Class = Class(getDefinitionByName("HabboMain"));

                if (HabboMainClass != null)
                {
                    var HabboMainInstance: HabboMain = new HabboMainClass(this._clientLoadingScreen) as HabboMain;

                    if (HabboMainInstance != null)
                    {
                        HabboMainInstance.addEventListener(Event.REMOVED, this.onMainRemoved);

                        addChild(HabboMainInstance);
                    }

                }

            }

        }

        private function onResize(event: Event): void
        {
            if (event.type == Event.RESIZE)
            {
                if (this._clientLoadingScreen != null)
                {
                    this.positionLoadingScreenDisplayElements(this._clientLoadingScreen);
                }

            }

        }

        private function onEnterFrame(event: Event): void
        {
            this.parent.setChildIndex(this, parent.numChildren - 1);
        }

        private function onAddedToStage(param1: Event): void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            stage.addEventListener(Event.RESIZE, this.onResize);
            this.positionLoadingScreenDisplayElements(this._clientLoadingScreen);
        }

        private function onMainRemoved(param1: Event): void
        {
            this.dispose();
        }

        private function onVisualizationUpdate(param1: Event): void
        {
            if (this._clientLoadingTextField)
            {
                if (this._clientLoadingTextIndex >= this._clientLoadingText.length)
                {
                    this._clientLoadingTextIndex = 0;
                }


                this._clientLoadingTextField.text = this._clientStartingMessage + "" + this._clientLoadingText[this._clientLoadingTextIndex];

                this._clientLoadingTextIndex++;
            }

        }

        private function updateLoadingBar(container: DisplayObjectContainer, percentageComplete: Number): void
        {
            var fileLoadingBar: Sprite = container.getChildByName(FILE_LOADING_BAR) as Sprite;
            var fileBarSprite: Sprite = fileLoadingBar.getChildByName(FILE_BAR_SPRITE) as Sprite;
            var byteLoadingBar: Sprite = container.getChildByName(BYTE_LOADING_BAR) as Sprite;
            var byteBarSprite: Sprite = byteLoadingBar.getChildByName(BYTE_BAR_SPRITE) as Sprite;

            var rectHeight: int;
            var rectWidth: int;

            var maxRectWidth: int = 200;
            var maxRectHeight: int = 20;

            var unknown1: int = 1;
            var unknown2: int = 1;

            fileBarSprite.x = unknown1 + unknown2;
            fileBarSprite.y = unknown1 + unknown2;
            fileBarSprite.graphics.clear();

            rectHeight = maxRectHeight - unknown1 * 2 - unknown2 * 2;
            rectWidth = 0;

            fileBarSprite.graphics.beginFill(12241619);
            fileBarSprite.graphics.drawRect(0, 0, rectWidth, rectHeight / 2);
            fileBarSprite.graphics.endFill();
            fileBarSprite.graphics.beginFill(9216429);
            fileBarSprite.graphics.drawRect(0, rectHeight / 2, rectWidth, rectHeight / 2 + 1);
            fileBarSprite.graphics.endFill();

            byteBarSprite.x = unknown1 + unknown2;
            byteBarSprite.y = unknown1 + unknown2;
            byteBarSprite.graphics.clear();

            rectHeight = maxRectHeight - unknown1 * 2 - unknown2 * 2;
            rectWidth = (maxRectWidth - unknown1 * 2 - unknown2 * 2) * percentageComplete;

            byteBarSprite.graphics.beginFill(8030867);
            byteBarSprite.graphics.drawRect(0, 0, rectWidth, rectHeight / 2);
            byteBarSprite.graphics.endFill();
            byteBarSprite.graphics.beginFill(8159645);
            byteBarSprite.graphics.drawRect(0, rectHeight / 2, rectWidth, rectHeight / 2 + 1);
            byteBarSprite.graphics.endFill();
        }

        public function createLoadingScreen(): DisplayObjectContainer
        {
            var container: Sprite = new Sprite();
            var fileBarSprite: Sprite;

            var loadingScreenBackground: Sprite = new Sprite();
            loadingScreenBackground.name = BACKGROUND;
            loadingScreenBackground.graphics.clear();
            loadingScreenBackground.graphics.beginFill(0xFF000000);
            loadingScreenBackground.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            container.addChild(loadingScreenBackground);

            var habboLogoBitmap: Bitmap = new this.HabboLogoClass() as Bitmap;
            habboLogoBitmap.name = HABBO_LOGO;
            container.addChild(habboLogoBitmap);

            this._clientLoadingTextField = new TextField();
            this._clientLoadingTextField.name = TEXT_FIELD;

            if (stage.loaderInfo.parameters[CLIENT_STARTING] != null)
            {
                this._clientStartingMessage = stage.loaderInfo.parameters[CLIENT_STARTING];
            }
            else
            {
                this._clientStartingMessage = CLIENT_STARTING;
            }


            var textFormat: TextFormat = new TextFormat();
            textFormat.font = "Verdana";
            textFormat.color = 0xFFFFFF;
            textFormat.size = 9;

            this._clientLoadingTextField.defaultTextFormat = textFormat;
            this._clientLoadingTextField.text = this._clientStartingMessage;
            this._clientLoadingTextField.autoSize = TextFieldAutoSize.LEFT;

            container.addChild(this._clientLoadingTextField);

            var fileLoadingBar: Sprite = new Sprite();
            fileLoadingBar.name = FILE_LOADING_BAR;
            fileLoadingBar.graphics.lineStyle(1, 0xFFFFFF);
            fileLoadingBar.graphics.beginFill(2500143);
            fileLoadingBar.graphics.drawRect(1, 0, 200 - 1, 0);
            fileLoadingBar.graphics.drawRect(200, 1, 0, 20 - 1);
            fileLoadingBar.graphics.drawRect(1, 20, 200 - 1, 0);
            fileLoadingBar.graphics.drawRect(0, 1, 0, 20 - 1);
            fileLoadingBar.graphics.endFill();
            container.addChild(fileLoadingBar);

            fileBarSprite = new Sprite();
            fileBarSprite.name = FILE_BAR_SPRITE;
            fileLoadingBar.addChild(fileBarSprite);
            fileLoadingBar = new Sprite();
            fileLoadingBar.name = BYTE_LOADING_BAR;
            fileLoadingBar.graphics.lineStyle(1, 0x888888);
            fileLoadingBar.graphics.beginFill(2500143);
            fileLoadingBar.graphics.drawRect(1, 0, 200 - 1, 0);
            fileLoadingBar.graphics.drawRect(200, 1, 0, 20 - 1);
            fileLoadingBar.graphics.drawRect(1, 20, 200 - 1, 0);
            fileLoadingBar.graphics.drawRect(0, 1, 0, 20 - 1);
            fileLoadingBar.graphics.endFill();
            container.addChild(fileLoadingBar);

            fileBarSprite = new Sprite();
            fileBarSprite.name = BYTE_BAR_SPRITE;
            fileLoadingBar.addChild(fileBarSprite);

            fileLoadingBar.visible = true;
            this.updateLoadingBar(container, 0);
            this.positionLoadingScreenDisplayElements(container);
            this._timer.start();
            return container;
        }

        public function disposeLoadingScreen(container: DisplayObjectContainer): void
        {
            var displayObject: DisplayObject = container.getChildByName(BACKGROUND);

            if (displayObject != null)
            {
                container.removeChild(displayObject);
            }


            if (this._clientLoadingTextField != null)
            {
                container.removeChild(this._clientLoadingTextField);
            }


            displayObject = container.getChildByName(HABBO_LOGO);

            if (displayObject != null)
            {
                container.removeChild(displayObject);
            }


            displayObject = container.getChildByName(FILE_LOADING_BAR);

            if (displayObject != null)
            {
                container.removeChild(displayObject);
            }


            displayObject = container.getChildByName(BYTE_LOADING_BAR);

            if (displayObject != null)
            {
                container.removeChild(displayObject);
            }


            if (this._timer)
            {
                this._timer.stop();
                this._timer = null;
            }

        }

        private function positionLoadingScreenDisplayElements(container: DisplayObjectContainer): void
        {
            var containerStage: Stage = container.stage;
            var background: Sprite = container.getChildByName(BACKGROUND) as Sprite;

            if (background != null)
            {
                background.x = 0;
                background.y = 0;
                background.graphics.clear();
                background.graphics.beginFill(0xFF000000);
                background.graphics.drawRect(0, 0, containerStage
                        ? containerStage.stageWidth
                        : container.width, containerStage ? containerStage.stageHeight : container.height);
            }


            var habboLogo: Bitmap = container.getChildByName(HABBO_LOGO) as Bitmap;

            if (habboLogo != null)
            {
                habboLogo.x = 117;
                habboLogo.y = 57;
            }


            var loadingText: TextField = container.getChildByName(TEXT_FIELD) as TextField;

            if (loadingText != null)
            {
                loadingText.x = 191 - loadingText.width / 2;

                if (habboLogo != null)
                {
                    loadingText.y = (habboLogo.y + habboLogo.height + 28) - 10;
                }

            }


            var fileLoadingBar: Sprite = container.getChildByName(FILE_LOADING_BAR) as Sprite;

            if (fileLoadingBar != null)
            {
                fileLoadingBar.x = 89;
                fileLoadingBar.y = 149;
            }


            var byteLoadingBar: Sprite = container.getChildByName(BYTE_LOADING_BAR) as Sprite;

            if (byteLoadingBar != null)
            {
                byteLoadingBar.x = 89;
                byteLoadingBar.y = 179;
            }

        }

    }
}
