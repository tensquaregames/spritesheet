package spritesheet.importers;

import flash.geom.Rectangle;
import openfl.display.Tileset;
import spritesheet.frames.TilesheetFrame;
import spritesheet.sheets.Tilesheet;
import spritesheet.frames.Frame;
import spritesheet.frames.SpritesheetFrame;
import spritesheet.sheets.Spritesheet;
import spritesheet.behaviors.Behavior;
import haxe.ds.StringMap;
import flash.display.BitmapData;
import haxe.Json;

class TexturePackerImporter {
    public var frameRate:Int = 30;

    public function new(frameRate:Int = 30) {
        this.frameRate = frameRate;
    }

    public function parseToSpritesheet(path:String, bitmapData:BitmapData, behavior_exp:EReg = null):Spritesheet {
        return this.generateSpriteSheetForBehaviors(bitmapData, this.buildBehaviorMap(this.parseJsonFrames(Json.parse(path)), behavior_exp));
    }

    public function parseToTilesheet(path:String, bitmapData:BitmapData, behavior_exp:EReg = null):Tilesheet {
        return this.generateTileSheetForBehaviors(bitmapData, this.buildBehaviorMap(this.parseJsonFrames(Json.parse(path)), behavior_exp));
    }

    public function parseJsonFrames(json:Dynamic):Array<TPFrame> {
        var tpFrames:Array<TPFrame> = new Array<TPFrame>();

        for (frame in cast (json.frames, Array<Dynamic>)) {
            tpFrames.push(this.parseJsonFrame(frame));
        }

        return tpFrames;
    }

    public function parseJsonFrame(json:Dynamic):TPFrame {
        var frame:TPFrame = new TPFrame();
        frame.filename = json.filename;
        frame.rotated = json.rotated;
        frame.trimmed = json.trimmed;
        frame.frame = this.parseJsonRect(json.frame);
        frame.spriteSourceSize = this.parseJsonRect(json.spriteSourceSize);
        frame.sourceSize = this.parseJsonSize(json.sourceSize);

        return frame;
    }

    private function parseJsonRect(json:Dynamic):TPRect {
        var rect:TPRect = new TPRect();
        rect.x = json.x;
        rect.y = json.y;
        rect.w = json.w;
        rect.h = json.h;

        return rect;
    }

    private function parseJsonSize(json:Dynamic):TPSize {
        var size:TPSize = new TPSize();
        size.w = json.w;
        size.h = json.h;

        return size;
    }

    private function buildBehaviorMap(frames:Array<TPFrame>, exp:EReg = null):StringMap<Array<TPFrame>> {
        exp = (exp == null) ? ~// : exp;
        var names = new StringMap<Array<TPFrame>>();

        for (frame in frames) {
            exp.match(frame.filename);

            var behaviorName:String = exp.matched(0);

            if (!names.exists(behaviorName)) {
                names.set(behaviorName, new Array<TPFrame>());
            }

            var behaviors:Array<TPFrame> = names.get(behaviorName);
            behaviors.push(frame);
        }

        return names;
    }

    private function generateSpriteSheetForBehaviors(bitmapData:BitmapData, behaviorNames:StringMap<Array<TPFrame>>):Spritesheet {
        var allFrames = new Array<Frame>();
        var allBehaviors = new Map <String, Behavior>();

        for (key in behaviorNames.keys()) {
            var indexes = new Array<Int>();
            var frames = behaviorNames.get(key);

            for (i in 0...frames.length) {
                var tpFrame:TPFrame = frames[i];
                var sFrame = new SpritesheetFrame ( tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h );

                if (tpFrame.trimmed) {
                    sFrame.offsetX = tpFrame.spriteSourceSize.x;
                    sFrame.offsetY = tpFrame.spriteSourceSize.y;
                }

                indexes.push(allFrames.length);
                allFrames.push(sFrame);
            }

            if (this.isIgnoredBehavior(key)) {
                continue;
            }

            allBehaviors.set(key, new Behavior(key, indexes, false, false, this.frameRate));
        }

        return new Spritesheet(bitmapData, null, allFrames, allBehaviors);
    }

    private function generateTileSheetForBehaviors(bitmapData:BitmapData, behaviorNames:StringMap<Array<TPFrame>>):Tilesheet {
        var allFrames = new Array<Frame>();
        var allBehaviors = new Map <String, Behavior>();
        var allRects = new Array<Rectangle>();

        for (key in behaviorNames.keys()) {
            var indexes = new Array<Int>();
            var frames = behaviorNames.get(key);

            for (i in 0...frames.length) {
                var tpFrame:TPFrame = frames[i];

                var sFrame = new TilesheetFrame (tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h);
                sFrame.rect = new Rectangle(tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h);

                if (tpFrame.trimmed) {
                    sFrame.offsetX = tpFrame.spriteSourceSize.x;
                    sFrame.offsetY = tpFrame.spriteSourceSize.y;
                }

                indexes.push(allFrames.length);
                allFrames.push(sFrame);
                allRects.push(sFrame.rect);
            }

            if (this.isIgnoredBehavior(key)) {
                continue;
            }

            allBehaviors.set(key, new Behavior(key, indexes, false, false, this.frameRate));
        }

        return new Tilesheet(new Tileset(bitmapData, allRects), allFrames, allBehaviors);
    }

    private function isIgnoredBehavior(key:String):Bool {
        return key == '';
    }
}

class TPFrame {
    public function new():Void {}

    public var filename:String;
    public var frame:TPRect;
    public var rotated:Bool;
    public var trimmed:Bool;
    public var spriteSourceSize:TPRect;
    public var sourceSize:TPSize;
}

class TPRect {
    public function new():Void {}

    public var x:Int;
    public var y:Int;
    public var w:Int;
    public var h:Int;
}

class TPSize {
    public function new():Void {}

    public var w:Int;
    public var h:Int;
}