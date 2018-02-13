package spritesheet.animation;

import spritesheet.frames.TilesheetFrame;
import spritesheet.frames.Frame;
import spritesheet.sheets.Tilesheet;
import openfl.display.Tile;
import openfl.display.Tilemap;
import spritesheet.behaviors.Behavior;

class AnimatedTilesheet extends AnimatedSheet {
    public var tilemap(default, null):Tilemap;
    public var tile(default, null):Tile;

    public function new(sheet:Tilesheet, smoothing:Bool = false) {

        super(sheet);

        this.tilemap = new Tilemap(sheet.width, sheet.height, sheet.tileset, smoothing);
        this.tilemap.addTile(this.tile = new Tile());

        this.addChild(this.tilemap);
    }

    override private function updateFrame(frame:Frame):Void {
        super.updateFrame(frame);

        this.tile.id = cast(frame, TilesheetFrame).id;
        this.tile.rect = cast(frame, TilesheetFrame).rect;
        this.tile.x = frame.offsetX - currentBehavior.originX;
        this.tile.y = frame.offsetY - currentBehavior.originY;
    }

    override private function updateBehavior(behavior:Behavior, restart:Bool = true):Void {
        super.updateBehavior(behavior, restart);

        if (behavior != null) {
            if ((restart || behavior != this.currentBehavior) && this.tile == null) {
                this.update(0);
            }
        }
    }
}