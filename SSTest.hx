// haxe -swf ss.swf -swf-version 10 -swf-header 500:500:50 -main SSTest.hx

import SortedSpace;

class SSTest
{
  static function main() {
    var root = flash.Lib.current;
    
    var s = new SortedSpace();
    var arr = [];
    
    for(i in 0 ... 2000) {
      var p = new P();
      
      p.x = Math.random()*500;
      p.y = Math.random()*500;
      p.vx = (Math.random()-.5)*3;
      p.vy = (Math.random()-.5)*3;
      
      root.addChild(p);
      s.add(p.b);
      
      arr.push(p);
    }
    
    root.addEventListener('enterFrame', function(_) {
      for(p in arr) {
        p.x += p.vx;
        p.y += p.vy;
        p.vx += (250-p.x)*.0001;
        p.vy += (250-p.y)*.0001;
        p.bounds();
      }
      
      var c = s.update();
      
      for(p in arr) {
        p.alpha = c.get(p.b.id) == null ? 1 : .5;
      }
    });
  }
}

class P extends flash.display.Shape, implements haxe.Public
{
  static var size = 3;
  
  var b:DLAABB;
  
  var vx:Float;
  var vy:Float;
  
  function new() {
    super();
    
    graphics.beginFill(0);
    graphics.drawCircle(0,0, size);
    cacheAsBitmap = true;
    
    b = new DLAABB();
  }
  
  function bounds() {
    b.top    = y-size;
    b.bottom = y+size;
    b.left   = x-size;
    b.right  = x+size;
  }
}

