package spritesheet.sheets;

import spritesheet.frames.Frame;
import spritesheet.behaviors.Behavior;

class Sheet {
    public var behaviors(default, null):Map<String, Behavior>;
    public var name(default, null):String;

    public var frames(default, null):Array<Frame>;
    public var totalFrames(default, null):Int;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public function new(frames:Array<Frame> = null, behaviors:Map<String, Behavior> = null) {
        this.behaviors = behaviors;

        if (null == frames) {
            this.frames = new Array<Frame>();
            this.totalFrames = 0;

            this.width = 0;
            this.height = 0;
        } else {
            this.frames = frames;
            this.totalFrames = frames.length;

            for (frame in this.frames) {
                if (null == this.width || frame.width > this.width) {
                    this.width = frame.width;
                }

                if (null == this.height || frame.height > this.height) {
                    this.height = frame.height;
                }
            }
        }

        if (null == behaviors) {
            this.behaviors = new Map<String, Behavior>();
        } else {
            this.behaviors = behaviors;
        }
    }

    public function addBehavior(behavior:Behavior):Void {
        this.behaviors.set(behavior.name, behavior);
    }

    public function addFrame(frame:Frame):Void {
        this.frames.push(frame);
        this.totalFrames ++;

        if (frame.width > this.width) {
            this.width = frame.width;
        }

        if (frame.height > this.height) {
            this.height = frame.height;
        }
    }

    public function getFrames():Array <Frame> {
        return this.frames.copy();
    }

    public function getFrame(index:Int, autoGenerate:Bool = true):Frame {
        return this.frames[index];
    }
}
