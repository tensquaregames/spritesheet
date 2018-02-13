# Spritesheet

Upgraded version of original Spritesheet library (https://github.com/skylarkstudio/spritesheet). It contains both versions
for sprite sheets animation based on Bitmaps (Spritesheet) as well as on Tilemap/Tileset (Tilesheet).

## Installation

This version of library has not been yet integrated with haxelib installation process so to install build from repository sources:
	
	haxelib git spritesheet https://github.com/lmodlinski/spritesheet

To include Spritesheet in an OpenFL project, add `<haxelib name="spritesheet" />` to your project.xml.

## Usage

It's simple to get started with animations. Both Spritesheet and Tilesheet requires a Bitmap to start with:
```haxe
var bitmapData = Assets.getBitmapData('some_sprite_sheet.png');
```

In comparision to original Spritesheet library importers were cut down to two main ones:
```haxe
var spritesheet:Spritesheet = BitmapImporter.createSpritesheet(bitmapData, 3, 9, 56, 80);
var tilesheet:Tilesheet = BitmapImporter.createTilesheet(bitmapData, 3, 9, 56, 80);
```

Add a behavior given by its name, all the frames it consists of and extra parameters as 'loop' or 'persistent':
```haxe
spritesheet.addBehavior(new Behavior('idle', [3, 4, 5], false, false, 15));
tilesheet.addBehavior(new Behavior('idle', [3, 4, 5], false, false, 15));
```

Create an animated Spritesheet with following lines:
```haxe
var animated_spritesheet:AnimatedSpritesheet = new AnimatedSpritesheet(spritesheet, true)
animated_spritesheet(animated);

var animated_tilesheet:AnimatedTilesheet = new AnimatedTilesheet(tilesheet, true)
addChild(animated_tilesheet);
```

And select a behavior to show on screen:
```haxe
animated_spritesheet.showBehavior('idle');
animated_tilesheet.showBehavior('idle');
```

Finally, tell the sprite when to animate and the delta since the last update, in this case we'll be updating via Event.ENTER_FRAME.
```haxe
private function onEnterFrame(e:Event):Void
{
    var time = Lib.getTimer();
    var delta = time - lastTime;
    
    animated_spritesheet.update(delta);
    animated_tilesheet.update(delta);
    
    lastTime = time;
}
```