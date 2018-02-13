package spritesheet.frames;

class Frame {
    public var x(default, default):Int;
    public var y(default, default):Int;
    public var width(default, default):Int;
    public var height(default, default):Int;

    public var offsetX(default, default):Int;
    public var offsetY(default, default):Int;

    public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, offsetX:Int = 0, offsetY:Int = 0) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.offsetX = offsetX;
        this.offsetY = offsetY;
    }
}
