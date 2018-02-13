package spritesheet.importers;

import spritesheet.frames.Frame;
import openfl.display.Tileset;
import spritesheet.frames.TilesheetFrame;
import spritesheet.sheets.Tilesheet;
import spritesheet.sheets.Spritesheet;
import spritesheet.frames.SpritesheetFrame;
import flash.display.BitmapData;
import flash.geom.Rectangle;

class BitmapImporter {
    public static function createSpritesheet(bitmapData:BitmapData, columns:Int, rows:Int, tileWidth:Int, tileHeight:Int, adjustLength:Int = 0):Spritesheet {
        var frames:Array<Frame> = [];
        var totalLength = rows * columns + adjustLength;

        for (row in 0...rows) {
            for (column in 0...columns) {
                if (frames.length < totalLength) {

                    var x = tileWidth * column;
                    var y = tileHeight * row;
                    var frame = new SpritesheetFrame (x, y, tileWidth, tileHeight, 0, 0);

                    frames.push(frame);
                }
            }
        }

        while (frames.length < totalLength) {
            frames.push(new SpritesheetFrame ());
        }

        return new Spritesheet (bitmapData, null, frames);
    }

    public static function createTilesheet(bitmapData:BitmapData, columns:Int, rows:Int, tileWidth:Int, tileHeight:Int, adjustLength:Int = 0):Tilesheet {
        var allFrames:Array<Frame> = [];
        var allRects = new Array<Rectangle>();

        var totalLength = rows * columns + adjustLength;

        for (row in 0...rows) {
            for (column in 0...columns) {
                if (allFrames.length < totalLength) {
                    var x = tileWidth * column;
                    var y = tileHeight * row;

                    var frame = new TilesheetFrame (x, y, tileWidth, tileHeight, 0, 0);
                    frame.rect = new Rectangle(x, y, tileWidth, tileHeight);
                    frame.id = column + row;

                    allFrames.push(frame);
                    allRects.push(frame.rect);
                }
            }
        }

        while (allFrames.length < totalLength) {
            allFrames.push(new SpritesheetFrame ());
        }

        return new Tilesheet (new Tileset(bitmapData, allRects), allFrames);
    }
}