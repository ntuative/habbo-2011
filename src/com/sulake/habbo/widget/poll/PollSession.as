package com.sulake.habbo.widget.poll
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollSession implements IDisposable
    {

        private var _id: int = -1;
        private var _disposed: Boolean = false;
        private var var_3272: int = 0;
        private var var_3273: Array;
        private var var_4895: PollWidget;
        private var var_4896: IPollDialog;
        private var var_3271: String = "";

        public function PollSession(param1: int, param2: PollWidget)
        {
            this._id = param1;
            this.var_4895 = param2;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get numQuestions(): int
        {
            return this.var_3272;
        }

        public function set numQuestions(param1: int): void
        {
            this.var_3272 = param1;
        }

        public function get questionArray(): Array
        {
            return this.var_3273;
        }

        public function set questionArray(param1: Array): void
        {
            this.var_3273 = param1;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this.var_4896)
                {
                    this.var_4896.dispose();
                    this.var_4896 = null;
                }

                this.var_4895 = null;
                this._disposed = true;
            }

        }

        public function showOffer(param1: String): void
        {
            this.hideOffer();
            this.var_4896 = new PollOfferDialog(this._id, param1, this.var_4895);
        }

        public function hideOffer(): void
        {
            if (this.var_4896 is PollOfferDialog)
            {
                if (!this.var_4896.disposed)
                {
                    this.var_4896.dispose();
                }

                this.var_4896 = null;
            }

        }

        public function showContent(param1: String, param2: String, param3: Array): void
        {
            this.hideOffer();
            this.hideContent();
            this.var_3271 = param2;
            this.var_4896 = new PollContentDialog(this._id, param1, param3, this.var_4895);
        }

        public function hideContent(): void
        {
            if (this.var_4896 is PollContentDialog)
            {
                if (!this.var_4896.disposed)
                {
                    this.var_4896.dispose();
                }

                this.var_4896 = null;
            }

        }

        public function showThanks(): void
        {
            this.var_4895.windowManager.alert("${poll_thanks_title}", this.var_3271, 0, function (param1: IAlertDialog, param2: WindowEvent): void
            {
                param1.dispose();
            });
        }

    }
}
