package spritesheet.frames;

import flash.display.BitmapData;

class SpritesheetFrame extends Frame {
    public var name(default, default):String;
    public var bitmapData(default, default):BitmapData;

    public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, offsetX:Int = 0, offsetY:Int = 0) {
        super(x, y, width, height, offsetX, offsetY);
    }
}