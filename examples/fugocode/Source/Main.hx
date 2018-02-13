package;

import spritesheet.behaviors.Behavior;
import spritesheet.animation.AnimatedSpritesheet;
import spritesheet.importers.BitmapImporter;
import spritesheet.animation.AnimatedTilesheet;
import spritesheet.sheets.Tilesheet;
import spritesheet.sheets.Spritesheet;
import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.events.Event;
import flash.display.BitmapData;
import openfl.Assets;
import flash.display.Sprite;

/**
 * Based on Fugo's Example
 * https://github.com/fugogugo/NMEspritesheetExample
 * @author Fugo
 */
class Main extends Sprite {
    var inited:Bool;
    var lastTime:Int = 0;

    var animated_spritesheet:AnimatedSpritesheet;
    var animated_tilesheet:AnimatedTilesheet;

    public function new() {
        super();

        this.stage.align = StageAlign.TOP_LEFT;
        this.stage.scaleMode = StageScaleMode.NO_SCALE;

        this.setupSpritsheet();
    }

    public function setupSpritsheet():Void {
        var bitmap:BitmapData = Assets.getBitmapData("assets/kit_from_firefox.png");

        var spritesheet:Spritesheet = BitmapImporter.createSpritesheet(bitmap, 3, 9, 56, 80);
        spritesheet.addBehavior(new Behavior("stand", [0, 1, 2], true, false, 6));
        spritesheet.addBehavior(new Behavior("down", [3, 4, 5], false, false, 10));
        spritesheet.addBehavior(new Behavior("jump", [6, 7, 8], false, false, 10));
        spritesheet.addBehavior(new Behavior("hit", [9, 10, 11], false, false, 10));
        spritesheet.addBehavior(new Behavior("punch", [12, 13, 14], false, false, 10));
        spritesheet.addBehavior(new Behavior("kick", [15, 16, 17], false, false, 10));
        spritesheet.addBehavior(new Behavior("flypunch", [18, 19, 20], false, false, 10));
        spritesheet.addBehavior(new Behavior("flykick", [21, 22, 23], false, false, 10));
        spritesheet.addBehavior(new Behavior("dizzy", [24, 25, 26], true, false, 6));

        var tilesheet:Tilesheet = BitmapImporter.createTilesheet(bitmap, 3, 9, 56, 80);
        tilesheet.addBehavior(new Behavior("stand", [0, 1, 2], true, false, 6));
        tilesheet.addBehavior(new Behavior("down", [3, 4, 5], false, false, 10));
        tilesheet.addBehavior(new Behavior("jump", [6, 7, 8], false, false, 10));
        tilesheet.addBehavior(new Behavior("hit", [9, 10, 11], false, false, 10));
        tilesheet.addBehavior(new Behavior("punch", [12, 13, 14], false, false, 10));
        tilesheet.addBehavior(new Behavior("kick", [15, 16, 17], false, false, 10));
        tilesheet.addBehavior(new Behavior("flypunch", [18, 19, 20], false, false, 10));
        tilesheet.addBehavior(new Behavior("flykick", [21, 22, 23], false, false, 10));
        tilesheet.addBehavior(new Behavior("dizzy", [24, 25, 26], true, false, 6));

        this.animated_spritesheet = new AnimatedSpritesheet(spritesheet, true);
        this.animated_spritesheet.showBehavior("stand");

        this.animated_tilesheet = new AnimatedTilesheet(tilesheet, true);
        this.animated_tilesheet.showBehavior("stand");

        this.addChild(this.animated_spritesheet);
        this.addChild(this.animated_tilesheet);

        this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        this.stage.addEventListener(Event.RESIZE, resize);
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        this.centerContent();

        trace("keys:1,2,3,4,5,6,7,8,9,0");
    }

    private function centerContent():Void {
        this.animated_spritesheet.x = (stage.stageWidth - this.animated_spritesheet.width) * 0.5 - this.animated_spritesheet.width;
        this.animated_spritesheet.y = (stage.stageHeight - this.animated_spritesheet.height) * 0.5;

        this.animated_tilesheet.x = (stage.stageWidth - this.animated_tilesheet.width) * 0.5 + this.animated_tilesheet.width;
        this.animated_tilesheet.y = (stage.stageHeight - this.animated_tilesheet.height) * 0.5;
    }

    private function onEnterFrame(e:Event):Void {
        var time = Lib.getTimer();
        var delta = time - this.lastTime;

        this.animated_spritesheet.update(delta);
        this.animated_tilesheet.update(delta);

        this.lastTime = time;
    }

    private function resize(e:Event) {
        this.centerContent();
    }

    private function onKeyUp(e:KeyboardEvent):Void {
        if (e.keyCode == Keyboard.NUMBER_1) {
            this.animated_spritesheet.showBehavior("stand");
            this.animated_tilesheet.showBehavior("stand");

            trace("idle");
        }
        if (e.keyCode == Keyboard.NUMBER_2) {
            this.animated_spritesheet.showBehavior("down");
            this.animated_tilesheet.showBehavior("down");

            trace("walk");
        }
        if (e.keyCode == Keyboard.NUMBER_3) {
            this.animated_spritesheet.showBehavior("jump");
            this.animated_tilesheet.showBehavior("jump");

            trace("jump");
        }
        if (e.keyCode == Keyboard.NUMBER_4) {
            this.animated_spritesheet.showBehavior("hit");
            this.animated_tilesheet.showBehavior("hit");

            trace("hit");
        }
        if (e.keyCode == Keyboard.NUMBER_5) {
            this.animated_spritesheet.showBehavior("punch");
            this.animated_tilesheet.showBehavior("punch");

            trace("punch");
        }
        if (e.keyCode == Keyboard.NUMBER_6) {
            this.animated_spritesheet.showBehavior("kick");
            this.animated_tilesheet.showBehavior("kick");

            trace("kick");
        }
        if (e.keyCode == Keyboard.NUMBER_7) {
            this.animated_spritesheet.showBehavior("flypunch");
            this.animated_tilesheet.showBehavior("flypunch");

            trace("flypunch");
        }
        if (e.keyCode == Keyboard.NUMBER_8) {
            this.animated_spritesheet.showBehavior("flykick");
            this.animated_tilesheet.showBehavior("flykick");

            trace("flykick");
        }
        if (e.keyCode == Keyboard.NUMBER_9) {
            this.animated_spritesheet.showBehavior("dizzy");
            this.animated_tilesheet.showBehavior("dizzy");

            trace("dizzy");
        }
        if (e.keyCode == Keyboard.NUMBER_0) {
            this.animated_spritesheet.showBehaviors(["down", "jump", "hit", "punch"]);
            this.animated_tilesheet.showBehaviors(["down", "jump", "hit", "punch"]);

            trace("walk,jump,hit,punch");
        }
    }
}