/*file pulled out of FLA to show code.  not working */
/*frame 1 script*/

#include "tweenlite.as"
import flash.filters.DropShadowFilter;
_lockroot = true;
/*
this.createTextField ("timer_txt", 365461321351, 0, 0, 100, 22);
function updateTimer ()
{
	timer_txt.text = getTimer ();
}
var intervalID:Number = setInterval (updateTimer, 100);
*/
MovieClip.prototype.timer = function (sec) {
	//create time mc and loop
	this.createEmptyMovieClip ("time", 400000);
	this.time.t0 = getTimer ();
	this.time.t2 = sec * 1000;
	this.stop ();
	this.time.onEnterFrame = function () {
		this.t1 = getTimer () - this.t0;
		if (this.t1 > this.t2) {
			//trace("done")
			this._parent.play ();
			delete this.onEnterFrame;
		}
	};
};
MovieClip.prototype.alphaIn = function (tempo, del) {
	this._alpha = 0;
	this.tween (['_alpha'], [100], tempo, 'easeInOutQuad', del);
};
MovieClip.prototype.alphaOut = function (tempo, del) {
	this.tween (['_alpha'], [0], tempo, 'easeInOutQuad', del);
};
// for the bullets at the end
MovieClip.prototype.bulletPop = function (del) {
	this.tween (['_xscale', '_yscale', '_alpha'], [160, 160, 100], .15, 'easeOutQuad', del, function () {
		this.tween (['_xscale', '_yscale'], [100, 100], .2, 'easeOutQuad', 0);
	});
	this._xscale = this._yscale = this._alpha = 0;
};
// animation styles - add more if necessary
// zooms while fading in
MovieClip.prototype.zoomFade = function (del) {
	//var 
	trace (this._y);
	this.tween (['_xscale', '_yscale'], [100, 100], .25, 'easeOutQuad', del);
	this.tween (['_y', '_x', '_alpha'], [this._y, this._x, 100], .25, 'easeOutQuad', del);
	this._alpha = 0;
	this._y -= ((this._height * 2.5) - this._height) / 2;
	this._x -= ((this._width * 2.5) - this._width) / 2;
	this._xscale = 250;
	this._yscale = 250;
	trace (this._y);
};
// this is same effect for clips that arent dynamically created
MovieClip.prototype.zoomFadeMC = function (del) {
	//var 
	trace (this._y);
	this.tween (['_xscale', '_yscale'], [100, 100], .3, 'easeOutQuad', del);
	this.tween (['_y', '_alpha'], [this._y, 100], .2, 'easeOutQuad', del);
	this._alpha = 0;
	this._xscale = 250;
	this._yscale = 250;
	trace (this._y);
};
// slides in from bottom
MovieClip.prototype.slideUpFade = function (del) {
	this.tween (['_y', '_alpha'], [this._y, 100], .2, 'easeOutQuad', del);
	this._y += 10;
	this._alpha = 0;
};
// slide it out to the left
MovieClip.prototype.slideLeftFade = function (del) {
	trace ("slideOut");
	this.tween (['_x', '_alpha'], [this._x - 5, 0], .15, 'easeOutQuad', del);
	//	this._y += 10;
	//	this._alpha = 0;
};
// used globally for depth
var depthindex = 1000;
/*
this.createTextField ("timer_txt", 365461321351, 0, 0, 100, 22);
function updateTimer ()
{
timer_txt.text = getTimer ();
}
var intervalID:Number = setInterval (updateTimer, 100);
*/
// type of animation in, delay before start, animation out , delay 
// before out [not added to initial delay], add extra spaces if needed, boolean for shadow
TextField.prototype.textAnimation = function (in_animstyle, in_delay, out_animstyle, out_delay, spacing, isshadow) {
	// is extra kerning necessary?
	if (!spacing) {
		spacing = 0;
	}
	// get style of existing textfield to apply to duplicated one  
	var styles = this.getTextFormat ();
	// create a clip to hold the words
	var animholder = this._parent.createEmptyMovieClip (this._name + "_mc", _root.depthindex + 1);
	// add drop shadow if necessary
	if (isshadow == true) {
		var dropShadow = new DropShadowFilter (2, 135, 0x000000, 0.5, 2, 2, 2, 3);
		animholder.filters = [dropShadow];
	}
	// split into array of words  
	animholder.words = this.text.split (" ");
	// create array to hold the word movieclips
	animholder.wordholder = new Array ();
	// place at location of current textfield
	animholder._x = this._x;
	animholder._y = this._y;
	// iterate through words and attach movie clips at right locations
	for (i = 0; i < animholder.words.length; i++) {
		animholder.wordholder[i] = animholder.attachMovie ("t_s1", this._name + i, 1000 + i);
		animholder.wordholder[i]._x = animholder.wordholder[i - 1]._x + animholder.wordholder[i - 1]._width;
		animholder.wordholder[i].copyarea.text = animholder.words[i];
		animholder.wordholder[i].copyarea.setTextFormat (styles);
		animholder.wordholder[i].copyarea.autoSize = "left";
	}
	// apply animation
	for (i = 0; i < animholder.wordholder.length; i++) {
		// this should prob be done using apply() but I dont have time please fix if you know how 
		if (in_animstyle == "zoomFade") {
			trace ("zoom up");
			animholder.wordholder[i].zoomFade (in_delay + (i * .1));
		}
		if (in_animstyle == "slideUpFade") {
			trace ("slide up");
			animholder.wordholder[i].slideUpFade (in_delay + (i * .05));
		}
		if (out_delay != null) {
			switch (out_animstyle) {
			case ("slideLeftFade") :
				animholder.wordholder[i].slideLeftFade (out_delay + (i * .05));
			}
		}
	}
	// make orig textfield invisible
	this._visible = false;
	// iterate global depth index
	_root.depthindex++;
};
//the INTRO layer animation moves to next frame when it completes
stop ();









/*frame 2 script*/
stop ();
crush.crush1.play();
crush.crush2.play();
parts._visible=false; 
/*tintro.t1.textAnimation ("zoomFade", 0, "slideRightFade", null);
//tintro.t2.textAnimation ("zoomFade", .5, "slideRightFade", null);
tintro.t3.textAnimation ("slideUpFade", 1, "slideRightFade", null);
animation.animask.tween (['_xscale'], [100], .5, 'easeOutQuad', 3);
animation.animask._xscale = 2;
animation.alphaIn (.1, 3);
animation.timer (3.5);
animation.chart.timer (3.5);
tintro.alphaOut (.3, 2.7);*/











/*frame 3 script*/
stop ();
crush.alphaOut(.5,0)
linev.alphaIn (.3, .6);
t1.textAnimation ("zoomFade", .6, "slideRightFade", null, -.5);
t2.textAnimation ("zoomFade", .9, "slideRightFade", null, -.5);
bodycopy.t3.textAnimation ("slideUpFade", 1.5, "slideRightFade", null, -.5);
bodycopy.t4.textAnimation ("slideUpFade", 2, "slideRightFade", null, -.5);
logo.tween (['_y', '_alpha'], [logo._y, 100], .5, 'easeOutQuad');
logo._y += 15;
logo._alpha = 0;
barrons.tween (['_y', '_alpha'], [barrons._y, 100], .5, 'easeOutQuad');
barrons._y += 15;
barrons._alpha = 0;
ending.timer (2.5);
t10.textAnimation ("slideUpFade", 3, "slideRightFade", null, -.5, true);
t11.textAnimation ("slideUpFade", 3.1, "slideRightFade", null, -.5, true);
t12.textAnimation ("slideUpFade", 3.3, "slideRightFade", null, -.5, true);
t6a.alphaIn (.3, 3.6);