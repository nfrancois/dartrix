#import('dart:html');

// Original code from : https://github.com/hendo13/HTML5-Matrix-Code-Rain

void main() {
  new Dartrix().run();
}

final num _STRIPCOUNT = 90;

class Dartrix {
  
  List<String> _colors;
  List<String>  _letters;

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  num _height;
  num _width;
  // TODO objet Strip
  List<num> _stripFontSize;
  List<num> _stripX;
  List<num> _stripY;
  List<num> _dY;
  
  Dartrix(){
    _colors =  ['#cefbe4', '#81ec72', '#5cd646', '#54d13c', '#4ccc32', '#43c728'];
    _letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
    _stripFontSize = new List<num>(_STRIPCOUNT);
    _stripX = new List<num>(_STRIPCOUNT);
    _stripY = new List<num>(_STRIPCOUNT);
    _dY = new List<num>(_STRIPCOUNT);
    for (var i = 0; i < _STRIPCOUNT; i++) {
      _stripX[i] = Math.random()*1265;
      _stripY[i] = -100;
      _dY[i] = (Math.random()*7)+3;
      _stripFontSize[i] =  (Math.random()*24)+12; 
    }
  }
  
  bool draw(int time){
    clear();
    for(var i=0; i<_STRIPCOUNT; i++){
      _ctx.font = '$_stripFontSize[j]px MatrixCode';
      _ctx.textBaseline = 'top';
      _ctx.textAlign = 'center';
      
      if (_stripY[i] > 1358) {
        _stripX[i] = Math.random()*_canvas.width;
        _stripY[i] = -100;
        _dY[i] = (Math.random()*7)+3;
        _stripFontSize[i] = (Math.random()*24)+12;
        drawStrip(_stripX[i], _stripY[i]);
      } else {
        drawStrip(_stripX[i], _stripY[i]);
      }
      _stripY[i] += _dY[i];      
    }
    window.requestAnimationFrame(draw);
    return true;
  }
  
  clear(){
    // clear the canvas and set the properties
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    _ctx.shadowOffsetX = _ctx.shadowOffsetY = 0;
    _ctx.shadowBlur = 8;
    _ctx.shadowColor = '#94f475';
  }
  
  drawStrip(x, y) {
    for (var k = 0; k <= 20; k++) {
      var randChar = _letters[(Math.random()*_letters.length).toInt()];
      //if (_ctx.fillText) {
          switch (k) {
          case 0:
            _ctx.fillStyle = _colors[0]; break;
          case 1:
            _ctx.fillStyle = _colors[1]; break;
          case 3:
            _ctx.fillStyle = _colors[2]; break;
          case 7:
            _ctx.fillStyle = _colors[3]; break;
          case 13:
            _ctx.fillStyle = _colors[4]; break;
          case 17:
            _ctx.fillStyle = _colors[5]; break;
          }
          _ctx.fillText(randChar, x, y);
      //}
      y -= _stripFontSize[k];
     }
  }
  
  run(){
    _canvas = document.query("#canvas");
    _ctx = _canvas.context2d;
    window.requestAnimationFrame(draw);
  }
  
}

