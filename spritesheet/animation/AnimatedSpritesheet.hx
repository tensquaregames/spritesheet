package spritesheet.animation;

import spritesheet.frames.SpritesheetFrame;
import spritesheet.frames.Frame;
import flash.display.Bitmap;

import spritesheet.sheets.Spritesheet;
import spritesheet.behaviors.Behavior;

class AnimatedSpritesheet extends AnimatedSheet {
    public var bitmap(default, null):Bitmap;
    public var smoothing(default, null):Bool;

    public function new(sheet:Spritesheet, smoothing:Bool = false) {
        super(sheet);

        this.smoothing = smoothing;
        this.bitmap = new Bitmap();

        this.addChild(this.bitmap);
    }

    override public function updateFrame(frame:Frame):Void {
        super.updateFrame(frame);

        this.bitmap.bitmapData = cast(frame, SpritesheetFrame).bitmapData;
        this.bitmap.smoothing = this.smoothing;
        this.bitmap.x = frame.offsetX - this.currentBehavior.originX;
        this.bitmap.y = frame.offsetY - this.currentBehavior.originY;
    }

    override private function updateBehavior(behavior:Behavior, restart:Bool = true):Void {
        super.updateBehavior(behavior, restart);

        if (behavior != null) {
            if ((restart || behavior != this.currentBehavior) && this.bitmap.bitmapData == null) {
                this.update(0);
            }
        } else {
            this.bitmap.bitmapData = null;
        }
    }


}