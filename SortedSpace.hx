
class SortedSpace
{
  var xs:DLAABB;
  var id:Int;
  
  var cols:IntHash<Int>;
  
  public function new() {}
  
  public function add(x:DLAABB) {
    x.id = id++;
    
    if(xs != null) {
      xs.prev = x;
      x.next = xs;
    }
    xs = x;
  }
  
  public function update() {
    if(xs == null) return null;
    
    cols = new IntHash();
    
    sort();
    sweep();
    
    return cols;
  }
  
  function sort() {
    var a = xs.next;
    while(a != null) {
      var b = a.prev;
      
      if(b.left > a.left) {
        a.unlink();
        
        while(b.prev != null && a.left < b.left)
          b = b.prev;
        
        a.linkbefore(b);
        if(a.prev == null) xs = a;
      }
      
      a = a.next;
    }
  }
  
  function sweep() {
    var a = xs;
    while(a != null) {
      var b = a.next;
      
      while(b != null && b.left < a.right) {
        if(a.top < b.bottom && b.top < a.bottom) {
          cols.set(a.id, b.id);
          cols.set(b.id, a.id);
        }
        
        b = b.next;
      }
      
      a = a.next;
    }
  }
}

class DLAABB implements haxe.Public
{
  var next:DLAABB;
  var prev:DLAABB;
  
  var id:Int;
  
  var top   :Float;
  var bottom:Float;
  var right :Float;
  var left  :Float;
  
  function new() {}
  
  inline function unlink() {
    if(prev!=null) prev.next = next;
    if(next!=null) next.prev = prev;
  }
  
  inline function linkbefore(x:DLAABB) {
    if(x.prev != null) x.prev.next = this;
    prev = x.prev;
    x.prev = this; next = x;
  }
}
