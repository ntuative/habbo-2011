package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatlineData 
    {

        private var var_2956:int;
        private var var_2957:int;
        private var var_2958:int;
        private var var_2959:String;
        private var var_2960:String;

        public function ChatlineData(param1:IMessageDataWrapper)
        {
            this.var_2956 = param1.readInteger();
            this.var_2957 = param1.readInteger();
            this.var_2958 = param1.readInteger();
            this.var_2959 = param1.readString();
            this.var_2960 = param1.readString();
        }

        public function get hour():int
        {
            return (this.var_2956);
        }

        public function get minute():int
        {
            return (this.var_2957);
        }

        public function get chatterId():int
        {
            return (this.var_2958);
        }

        public function get chatterName():String
        {
            return (this.var_2959);
        }

        public function get msg():String
        {
            return (this.var_2960);
        }

    }
}