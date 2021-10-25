package com.sulake.habbo.widget.infostand
{

    import flash.display.BitmapData;

    import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;

    public class InfoStandPetData
    {

        private var var_2924: int;
        private var var_4424: int;
        private var var_3324: int;
        private var var_4425: int;
        private var _energy: int;
        private var var_4426: int;
        private var _nutrition: int;
        private var var_4427: int;
        private var _petRespect: int;
        private var _name: String = "";
        private var var_3097: int = -1;
        private var _type: int;
        private var var_3944: int;
        private var var_988: BitmapData;
        private var var_4711: Boolean;
        private var var_2975: int;
        private var _ownerName: String;
        private var _canOwnerBeKicked: Boolean;
        private var var_4657: int;
        private var var_3329: int;

        public function get name(): String
        {
            return this._name;
        }

        public function get id(): int
        {
            return this.var_3097;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get race(): int
        {
            return this.var_3944;
        }

        public function get image(): BitmapData
        {
            return this.var_988;
        }

        public function get isOwnPet(): Boolean
        {
            return this.var_4711;
        }

        public function get ownerId(): int
        {
            return this.var_2975;
        }

        public function get ownerName(): String
        {
            return this._ownerName;
        }

        public function get canOwnerBeKicked(): Boolean
        {
            return this._canOwnerBeKicked;
        }

        public function get age(): int
        {
            return this.var_3329;
        }

        public function get level(): int
        {
            return this.var_2924;
        }

        public function get levelMax(): int
        {
            return this.var_4424;
        }

        public function get experience(): int
        {
            return this.var_3324;
        }

        public function get experienceMax(): int
        {
            return this.var_4425;
        }

        public function get energy(): int
        {
            return this._energy;
        }

        public function get energyMax(): int
        {
            return this.var_4426;
        }

        public function get nutrition(): int
        {
            return this._nutrition;
        }

        public function get nutritionMax(): int
        {
            return this.var_4427;
        }

        public function get petRespect(): int
        {
            return this._petRespect;
        }

        public function get roomIndex(): int
        {
            return this.var_4657;
        }

        public function setData(param1: RoomWidgetPetInfoUpdateEvent): void
        {
            this._name = param1.name;
            this.var_3097 = param1.id;
            this._type = param1.petType;
            this.var_3944 = param1.petRace;
            this.var_988 = param1.image;
            this.var_4711 = param1.isOwnPet;
            this.var_2975 = param1.ownerId;
            this._ownerName = param1.ownerName;
            this._canOwnerBeKicked = param1.canOwnerBeKicked;
            this.var_2924 = param1.level;
            this.var_4424 = param1.levelMax;
            this.var_3324 = param1.experience;
            this.var_4425 = param1.experienceMax;
            this._energy = param1.energy;
            this.var_4426 = param1.energyMax;
            this._nutrition = param1.nutrition;
            this.var_4427 = param1.nutritionMax;
            this._petRespect = param1.petRespect;
            this.var_4657 = param1.roomIndex;
            this.var_3329 = param1.age;
        }

    }
}
