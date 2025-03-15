package objects;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.math.FlxRect;

class HealthBar extends FlxSpriteGroup {
    public var leftSide:FlxSprite;
    public var rightSide:FlxSprite;
    public var procent:Float = 0;
    // public var percent(default, set):Float = 0;

    public function new(x:Float, y:Float, boundX:Float = 0, boundY:Float = 1) {
        super(x, y);

        // this.valueFunction = valueFunction;
		// setBounds(boundX, boundY);

        rightSide = new FlxSprite(Paths.image('blyhealthbar'));
        rightSide.antialiasing = ClientPrefs.data.antialiasing;
        rightSide.scale.set(0.6, 0.6);
        rightSide.updateHitbox();
        add(rightSide);

        leftSide = new FlxSprite(Paths.image('blyhealthbar'));
        leftSide.antialiasing = ClientPrefs.data.antialiasing;
        leftSide.scale.set(0.6, 0.6);
        leftSide.updateHitbox();
        add(leftSide);

        this.flipX = true;
        
    }

    // private function set_percent(value:Float)
    //     {
    //         var doUpdate:Bool = false;
    //         if(value != percent) doUpdate = true;
    //         percent = value;
    
    //         if(doUpdate) updateBar();
    //         return value;
    //     }

    // override function update(elapsed:Float) {
	// 	// if(!enabled)
	// 	// {
	// 		// super.update(elapsed);
	// 	// 	return;
	// 	// }

	// 	// if(valueFunction != null)
	// 	// {
	// 	// 	var value:Null<Float> = FlxMath.remapToRange(FlxMath.bound(valueFunction(), bounds.min, bounds.max), bounds.min, bounds.max, 0, 100);
	// 	// 	percent = (value != null ? value : 0);
	// 	// }
	// 	// else percent = 0;
	// 	super.update(elapsed);
	// }

    public function setColors(left:FlxColor = null, right:FlxColor = null)
        {
            if(right != null)
                leftSide.color = right;
            else if(right == null)
                leftSide.color = 0xFF00FF00;
            if(left != null)
                rightSide.color = left;
            else if(left == null)
                rightSide.color = 0xFF00FF00;
        }

    public function updateHealthBar(healthPercent:Float):Void {
        leftSide.clipRect = new FlxRect(0, 0, leftSide.frameWidth * healthPercent, leftSide.width);
        procent = rightSide.width * healthPercent;
        // leftSide.dirty = true;
    }
}