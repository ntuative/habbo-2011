package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;

    public class EffectListProxy implements IThumbListDataProvider 
    {

        private var var_2446:EffectsModel;
        private var var_3544:int;

        public function EffectListProxy(param1:EffectsModel, param2:int)
        {
            this.var_2446 = param1;
            this.var_3544 = param2;
        }

        public function dispose():void
        {
            this.var_2446 = null;
        }

        public function getDrawableList():Array
        {
            return (this.var_2446.getEffects(this.var_3544));
        }

    }
}