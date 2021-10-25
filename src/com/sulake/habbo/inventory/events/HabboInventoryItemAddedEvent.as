package com.sulake.habbo.inventory.events
{

    import flash.events.Event;

    public class HabboInventoryItemAddedEvent extends Event
    {

        public static const HABBO_INVENTORY_ITEM_ADDED: String = "HABBO_INVENTORY_ITEM_ADDED";

        private var _classId: int;
        private var _stripId: int;
        private var _category: int;

        public function HabboInventoryItemAddedEvent(classId: int, stripId: int, category: int, param4: Boolean = false, param5: Boolean = false)
        {
            super(HABBO_INVENTORY_ITEM_ADDED, param4, param5);
            
            this._classId = classId;
            this._stripId = stripId;
            this._category = category;
        }

        public function get classId(): int
        {
            return this._classId;
        }

        public function get stripId(): int
        {
            return this._stripId;
        }

        public function get category(): int
        {
            return this._category;
        }

    }
}
