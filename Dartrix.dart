#import('dart:html');

// Original code from : https://github.com/hendo13/HTML5-Matrix-Code-Rain

void main() {
  new Dartrix().run();
}

final num _STRIP_NUMBER = 90;
final String MESSAGE = "Welcome to the Dartrix";
final num MESSAGE_DELAY = 5000;
final List<String> _COLORS = const ['#cefbe4', '#81ec72', '#5cd646', '#54d13c', '#4ccc32', '#43c728'];
final List<String> _SYMBOLS = const ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', //
                                     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ];

class Dartrix {
  
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  num _height;
  num _width;
  // TODO objet Strip
  List<num> _stripFontSize;
  List<num> _stripX;
  List<num> _stripY;
  List<num> _dY;
  
  int _startTime;
  
  initStrips(){
    _stripFontSize = new List<num>(_STRIP_NUMBER);
    _stripX = new List<num>(_STRIP_NUMBER);
    _stripY = new List<num>(_STRIP_NUMBER);
    _dY = new List<num>(_STRIP_NUMBER);
    for (var i = 0; i < _STRIP_NUMBER; i++) {
      initStrip(i);
    }
  }
  
  initStrip(num i){
    _stripX[i] = (Math.random()*_width);
    _stripY[i] = -100;
    _dY[i] = (Math.random()*7)+3;
    _stripFontSize[i] =  ((Math.random()*24)+12).toInt();   
  }
  
  bool draw(int time){
    clear();
    if(_startTime == null){
      _startTime = time;
    } else if((time - _startTime)<MESSAGE_DELAY){
      var remainingTime = MESSAGE_DELAY - (time - _startTime);
      var alpha = remainingTime/MESSAGE_DELAY;
      showMessage(alpha);
    }
    for(var i=0; i<_STRIP_NUMBER; i++){
      var size = _stripFontSize[i];
      _ctx.font = '${size}px MatrixCode';
      _ctx.textBaseline = 'top';
      _ctx.textAlign = 'center';
      if (_stripY[i] > _height) {
        initStrip(i);
      } else {
        drawStrip(_stripX[i], _stripY[i]);
      }
      _stripY[i] += _dY[i];      
    }
    window.requestAnimationFrame(draw);
    return true;
  }
  
  clear(){
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    _ctx.shadowOffsetX = _ctx.shadowOffsetY = 0;
    _ctx.shadowBlur = 8;
    _ctx.shadowColor = '#94f475';
  }
  
  drawStrip(x, y) {
    for (var k = 0; k <= 20; k++) {
      var randChar = _SYMBOLS[(Math.random()*_SYMBOLS.length).toInt()];
      switch (k) {
      case 0:
        _ctx.fillStyle = _COLORS[0]; break;
      case 1:
        _ctx.fillStyle = _COLORS[1]; break;
      case 3:
        _ctx.fillStyle = _COLORS[2]; break;
      case 7:
        _ctx.fillStyle = _COLORS[3]; break;
      case 13:
        _ctx.fillStyle = _COLORS[4]; break;
      case 17:
        _ctx.fillStyle = _COLORS[5]; break;
      }
      _ctx.fillText(randChar, x, y);
      y -= _stripFontSize[k];
     }
  }
  
  showMessage(double alpha){
    _ctx.font = 'bold 75px Verdana';
    _ctx.fillStyle = 'rgba(67,199,40, ${alpha})';
    _ctx.fillText(MESSAGE , _width/2, _height/2-100);
  }

  onResize() {
    _canvas.height = _height = window.innerHeight;
    _canvas.width = _width = _canvas.width = window.innerWidth;
  }  
  
  run(){
    _canvas = document.query("#canvas");
    _ctx = _canvas.context2d;
    onResize();
    initStrips();
    window.on.resize.add((event) => onResize(), true);
    window.requestAnimationFrame(draw);
  }
  
}

