package spritesheet.sheets;

import spritesheet.frames.Frame;
import spritesheet.frames.SpritesheetFrame;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import spritesheet.behaviors.Behavior;

class Spritesheet extends Sheet {
    private var sourceImage:BitmapData;
    private var sourceImageAlpha:BitmapData;

    public function new(image:BitmapData = null, imageAlpha:BitmapData = null, frames:Array<Frame> = null, behaviors:Map <String, Behavior> = null) {
        super(frames, behaviors);

        this.sourceImage = image;
        this.sourceImageAlpha = imageAlpha;
    }

    public function generateBitmaps():Void {
        for (i in 0...this.totalFrames) {
            this.generateBitmap(i);
        }
    }

    public function generateBitmap(index:Int):Void {
        var frame:SpritesheetFrame = cast(this.frames[index], SpritesheetFrame);

        var bitmapData = new BitmapData (frame.width, frame.height, true);
        var sourceRectangle = new Rectangle (frame.x, frame.y, frame.width, frame.height);
        var targetPoint = new Point();

        bitmapData.copyPixels(this.sourceImage, sourceRectangle, targetPoint);

        if (null != this.sourceImageAlpha) {
            bitmapData.copyChannel(this.sourceImageAlpha, sourceRectangle, targetPoint, 2, 8);
        }

        frame.bitmapData = bitmapData;
    }

    override public function getFrame(index:Int, autoGenerate:Bool = true):Frame {
        var frame:SpritesheetFrame = cast(super.getFrame(index, autoGenerate), SpritesheetFrame);
        if (frame != null && frame.bitmapData == null && autoGenerate) {
            generateBitmap(index);
        }

        return frame;
    }

    public function getFrameByName(frameName:String, autoGenerate:Bool = true):SpritesheetFrame {
        var frameIndex:Int = 0;
        var frame:SpritesheetFrame = null;

        for (index in 0...totalFrames) {
            if (cast(frames[index], SpritesheetFrame).name == frameName) {
                frameIndex = index;
                frame = cast(frames[index], SpritesheetFrame);
                break;
            }
        }

        if (frame != null && frame.bitmapData == null && autoGenerate) {
            generateBitmap(frameIndex);
        }

        return frame;
    }

    public function updateImage(image:BitmapData, imageAlpha:BitmapData = null):Void {
        this.sourceImage = image;
        this.sourceImageAlpha = imageAlpha;

        for (frame in frames) {
            var frame:SpritesheetFrame = cast(frame, SpritesheetFrame);

            if (frame != null) {
                frame = null;
            }
        }
    }
}