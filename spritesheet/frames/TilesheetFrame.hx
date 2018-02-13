package spritesheet.frames;

import openfl.geom.Rectangle;
class TilesheetFrame extends Frame {
    public var id(default, default):Int;
    public var rect(default, default):Rectangle;

    public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, offsetX:Int = 0, offsetY:Int = 0) {
        super(x, y, width, height, offsetX, offsetY);
    }
}