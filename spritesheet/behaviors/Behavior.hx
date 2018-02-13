package spritesheet.behaviors;

class Behavior {
    private static var uniqueID:Int = 0;

    public var frameData:Array<Dynamic>;
    public var frameRate:Int;
    public var frames:Array<Int>;

    public var loop(default, default):Bool;
    public var persistent(default, default):Bool;

    public var name:String;
    public var originX:Float;
    public var originY:Float;

    public function new(name:String = null, frames:Array<Int> = null, loop:Bool = false, persistent:Bool = false, frameRate:Int = 30, originX:Float = 0.0, originY:Float = 0.0) {
        this.name = null != name ? name : this.generateId();
        this.frames = null != frames ? frames : new Array<Int>();
        this.loop = loop;
        this.persistent = persistent;
        this.frameRate = frameRate;
        this.originX = originX;
        this.originY = originY;

        this.frameData = new Array<Dynamic>();

        for (i in 0...this.frames.length) {
            frameData.push(null);
        }
    }

    public function clone(id:String = null):Behavior {
        return new Behavior (null != id ? id : this.generateId(), this.frames.copy(), this.loop, this.persistent, this.frameRate, this.originX, this.originY);
    }

    public function reverse(id:String = null):Behavior {
        var frames:Array<Int> = this.frames.copy();
        frames.reverse();

        return new Behavior (null != id ? id : this.generateId(), frames, this.loop, this.persistent, this.frameRate, this.originX, this.originY);
    }

    private function generateId():String {
        return 'behavior' + (uniqueID++);
    }
}