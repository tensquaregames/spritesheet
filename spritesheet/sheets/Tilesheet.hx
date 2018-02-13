package spritesheet.sheets;

import openfl.display.Tileset;
import spritesheet.frames.Frame;
import spritesheet.behaviors.Behavior;

class Tilesheet extends Sheet {
    public var tileset(default, null):Tileset;

    public function new(tileset:Tileset = null, frames:Array<Frame> = null, behaviors:Map <String, Behavior> = null) {
        super(frames, behaviors);

        this.tileset = tileset;
    }
}