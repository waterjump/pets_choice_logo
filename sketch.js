// Generated by CoffeeScript 2.2.3
(function() {
  var fft, mic, myp5, petsChoiceLogo, scale, terrain, terrainDepth, terrainWidth;

  petsChoiceLogo = void 0;

  scale = 40;

  terrainWidth = 21;

  terrainDepth = 40;

  terrain = [];

  fft = void 0;

  mic = void 0;

  myp5 = new p5(function(p) {
    var i, ref, y, yTerrain;
    yTerrain = function(y) {
      var arrayRow, i, ref, x, xTerrain;
      xTerrain = function(x) {
        arrayRow.push(-600);
      };
      arrayRow = [];
      for (x = i = 0, ref = terrainWidth; (0 <= ref ? i <= ref : i >= ref); x = 0 <= ref ? ++i : --i) {
        xTerrain(x);
      }
      terrain.push(arrayRow);
    };
    for (y = i = 0, ref = terrainDepth; (0 <= ref ? i <= ref : i >= ref); y = 0 <= ref ? ++i : --i) {
      yTerrain(y);
    }
    p.preload = function() {
      petsChoiceLogo = p.loadImage('pets_choice_berlin_logo_black_bg.png');
    };
    p.setup = function() {
      p.frameRate(30);
      p.createCanvas(1280, 720, p.WEBGL);
      mic = new p5.AudioIn();
      mic.start();
      fft = new p5.FFT(.6);
      fft.setInput(mic);
    };
    return p.draw = function() {
      var foo, j, k, lightColor, newRow, octaveBands, ref1, ref2, sets, singleTerrain, x, xoff, yoff;
      xoff = p.sin(p.frameCount * 0.005) * 50;
      yoff = p.cos(p.frameCount * 0.005) * 50 - 100;
      p.camera(0, -100, (p.height / 2.0) / p.tan(p.PI * 30.0 / 180.0), xoff + 50, yoff, 0, 0, 1, 0);
      fft.analyze();
      p.background(30);
      p.strokeWeight(5);
      p.orbitControl();
      octaveBands = fft.getOctaveBands(2);
      sets = fft.logAverages(octaveBands);
      terrain.pop();
      // calculate terrain from audio signal
      singleTerrain = function(x) {
        newRow.push(p.map(sets[x], 0, 250, -600, 600));
      };
      newRow = [];
      for (x = j = 0, ref1 = terrainWidth; (0 <= ref1 ? j <= ref1 : j >= ref1); x = 0 <= ref1 ? ++j : --j) {
        singleTerrain(x);
      }
      terrain.unshift(newRow);
      // Moving terrain
      p.push();
      p.fill(30);
      p.noFill();
      p.strokeWeight(2);
      foo = function(y) {
        p.beginShape(p.TRIANGLE_STRIP);
        p.stroke(p.map(y, 0, 40, 255, 30));
        x = 0;
        while (x < terrainWidth - 1) {
          p.vertex(x * scale, y * scale, terrain[y][x]);
          p.vertex(x * scale, (y + 1) * scale, terrain[y + 1][x]);
          x++;
        }
        p.endShape();
      };
      p.strokeWeight(6);
      p.translate(-p.width / 1.5, -p.height - 200, -500);
      p.rotateY(p.PI / 5);
      for (y = k = 0, ref2 = terrainDepth - 1; (0 <= ref2 ? k <= ref2 : k >= ref2); y = 0 <= ref2 ? ++k : --k) {
        foo(y);
      }
      p.pop();
      // Pets Choice Logo cube
      p.push();
      p.texture(petsChoiceLogo);
      p.noStroke();
      lightColor = p.map(fft.getEnergy(15, 200), 0, 180, 80, 255);
      p.directionalLight(lightColor, lightColor, lightColor, 1, 0, 0);
      p.directionalLight(lightColor, lightColor, lightColor, -1, 0, -1);
      p.directionalLight(50, 50, 100, -1, -1, -1);
      p.translate(400, -200, 0);
      p.rotateY(p.frameCount * 0.012);
      p.rotateZ(p.frameCount * 0.01);
      p.box(150);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(500, 300, -300);
      p.rotateY(p.frameCount * -0.014);
      p.rotateX(p.frameCount * -0.0058);
      p.rotateZ(60);
      p.ambientMaterial(100);
      p.box(100);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(1500, 0, -1000);
      p.rotateY(p.frameCount * -0.014);
      p.rotateX(p.frameCount * 0.04);
      p.ambientMaterial(100);
      p.box(100);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(0, 0, -1000);
      p.rotateY(p.frameCount * -0.014);
      p.rotateX(p.frameCount * 0.04);
      p.ambientMaterial(100);
      p.box(100);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(800, -800, -800);
      p.rotateY(p.frameCount * 0.024);
      p.rotateX(p.frameCount * 0.04);
      p.ambientMaterial(100);
      p.box(100);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(-300, 200, -200);
      p.rotateY(p.frameCount * 0.024);
      p.rotateX(p.frameCount * 0.04);
      p.ambientMaterial(100);
      p.box(100);
      p.pop();
      p.push();
      p.noStroke();
      p.translate(0, -500, -500);
      p.rotateY(p.frameCount * -0.024);
      p.rotateX(p.frameCount * -0.04);
      p.rotateZ(60);
      p.ambientMaterial(200);
      p.box(100);
      p.pop();
    };
  });

}).call(this);
