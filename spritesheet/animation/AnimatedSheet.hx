package spritesheet.animation;

import spritesheet.frames.Frame;
import openfl.events.Event;
import spritesheet.behaviors.Behavior;
import spritesheet.sheets.Sheet;
import openfl.display.Sprite;

class AnimatedSheet extends Sprite {
    public var sheet(default, default):Sheet;

    public var currentBehavior(default, default):Behavior;
    public var currentFrameIndex(default, default):Int;

    private var behaviorComplete(null, null):Bool;
    private var behaviorQueue(null, null):Array<Behavior>;
    private var behavior(null, null):Behavior;

    private var loopTime(null, null):Int;
    private var timeElapsed(null, null):Int;

    public function new(sheet:Sheet) {
        super();

        this.sheet = sheet;
        this.behaviorQueue = new Array<Behavior>();
    }

    public function getFrameData(index:Int):Dynamic {
        if (null != this.currentBehavior && this.currentBehavior.frameData.length > index) {
            return this.currentBehavior.frameData[index];
        }

        return null;
    }

    public function queueBehavior(behavior:Dynamic):Void {
        var behaviorData = this.resolveBehavior(behavior);

        if (null == this.currentBehavior) {
            this.updateBehavior(behaviorData);
        } else {
            this.behaviorQueue.push(behaviorData);
        }
    }

    private function resolveBehavior(behavior:Dynamic):Behavior {
        if (Std.is(behavior, Behavior)) {
            return cast (behavior, Behavior);
        } else if (Std.is(behavior, String)) {
            if (null != this.sheet) {
                return this.sheet.behaviors.get(cast behavior);
            }
        }

        return null;
    }

    public function showBehavior(behavior:Dynamic, restart:Bool = true):Void {
        this.updateBehavior(this.resolveBehavior(behavior), restart);
    }

    public function showBehaviors(behaviors:Array<Dynamic>):Void {
        for (behavior in behaviors) {
            this.behaviorQueue.push(this.resolveBehavior(behavior));
        }

        if (0 < this.behaviorQueue.length) {
            this.updateBehavior(this.behaviorQueue.shift());
        }
    }

    public function update(delta:Int, reverse:Bool = false):Void {
        if (!this.behaviorComplete) {
            if (reverse) {
                delta = delta * -1;
            }

            this.timeElapsed = 0 > this.timeElapsed + delta ? 0 : this.timeElapsed + delta;

            var ratio:Float = this.timeElapsed / this.loopTime;
            if (1 <= ratio) {
                if (this.currentBehavior.loop) {
                    ratio -= Math.floor(ratio);
                } else if (this.currentBehavior.persistent) {
                    this.timeElapsed = this.loopTime;
                } else {
                    this.behaviorComplete = true;
                }
            }

            var frameCount = this.currentBehavior.frames.length;
            var frameDuration:Int = Math.round(this.loopTime / frameCount);

            var timeInAnimation:Int = this.timeElapsed;
            var rawFrameIndex:Int = Math.round(timeInAnimation / frameDuration);

            this.set(rawFrameIndex % frameCount);
        }
    }

    public function set(frame:Int):Void {
        if (!this.behaviorComplete) {
            this.updateFrame(
                this.sheet.getFrame(
                    this.currentBehavior.frames[this.currentFrameIndex = frame]
                )
            );

            if (this.behaviorComplete) {
                if (0 < this.behaviorQueue.length) {
                    this.updateBehavior(this.behaviorQueue.shift());
                } else if (this.hasEventListener(Event.COMPLETE)) {
                    this.dispatchEvent(new Event (Event.COMPLETE));
                }
            }
        }
    }

    private function updateFrame(frame:Frame):Void {
        // nothing by default ...
    }

    private function updateBehavior(behavior:Behavior, restart:Bool = true):Void {

        if (behavior != null) {
            if (restart || behavior != this.currentBehavior) {
                this.currentBehavior = behavior;
                this.timeElapsed = 0;
                this.behaviorComplete = false;

                this.loopTime = Std.int((behavior.frames.length / behavior.frameRate) * 1000);
            }
        } else {
            this.currentBehavior = null;
            this.currentFrameIndex = -1;
            this.behaviorComplete = true;
        }
    }
}
