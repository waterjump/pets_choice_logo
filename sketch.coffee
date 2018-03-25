petsChoiceLogo = undefined
scale = 40
terrainWidth = 21
terrainDepth = 40
terrain = []
fft = undefined
mic = undefined
myp5 = new p5 (p) ->

  yTerrain = (y) ->
    xTerrain = (x) ->
      arrayRow.push -600
      return

    arrayRow = []
    xTerrain x for x in [0 .. terrainWidth]
    terrain.push arrayRow
    return
  yTerrain y for y in [0 .. terrainDepth]


  p.preload = ->
    petsChoiceLogo = p.loadImage('pets_choice_berlin_logo_black_bg.png')
    return

  p.setup = ->
    p.frameRate(30)
    p.createCanvas 1280, 720, p.WEBGL
    mic = new p5.AudioIn()
    mic.start()
    fft = new p5.FFT(.6)
    fft.setInput(mic)
    return

  p.draw = ->
    xoff = p.sin(p.frameCount * 0.005) * 50
    yoff = p.cos(p.frameCount * 0.005) * 50 - 100
    p.camera(0, -100, (p.height/2.0) / p.tan(p.PI*30.0 / 180.0), xoff, yoff, 0, 0, 1, 0)
    fft.analyze()
    p.background(30)
    p.strokeWeight(5)
    p.orbitControl()

    octaveBands = fft.getOctaveBands(2)
    sets = fft.logAverages(octaveBands)
    terrain.pop()

    # calculate terrain from audio signal
    singleTerrain = (x) ->
      newRow.push(p.map(sets[x], 0, 250, -600, 600))
      return

    newRow = []
    singleTerrain x for x in [0 .. terrainWidth]
    terrain.unshift newRow

    # Moving terrain
    p.push()
    p.fill(30)
    p.noFill()
    p.strokeWeight(2)
    foo = (y) ->
      p.beginShape(p.TRIANGLE_STRIP)
      p.stroke(p.map(y, 0, 40, 255, 30))
      x = 0
      while x < terrainWidth - 1
        p.vertex(x * scale, y * scale, terrain[y][x])
        p.vertex(x * scale, (y + 1) * scale, terrain[y + 1][x])
        x++
      p.endShape()
      return

    p.strokeWeight(6)
    p.translate(-p.width / 1.5, -p.height - 200, -500)
    p.rotateY(p.PI / 5)
    foo y for y in [0 .. (terrainDepth - 1)]
    p.pop()

    # Pets Choice Logo cube
    p.push()
    p.texture(petsChoiceLogo)
    p.noStroke()
    lightColor = p.map(fft.getEnergy(15, 200), 0, 180, 80, 255)
    p.directionalLight(lightColor, lightColor, lightColor, 1, 0, 0)
    p.directionalLight(lightColor, lightColor, lightColor, -1, 0, -1)
    p.directionalLight(50, 50, 100, -1, -1, -1)
    p.translate(400,-200, 0)
    p.rotateY(p.frameCount * 0.012)
    p.rotateZ(p.frameCount * 0.01)
    p.box(150)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(500, 300,-300)
    p.rotateY(p.frameCount * -0.014)
    p.rotateX(p.frameCount * -0.0058)
    p.rotateZ(60)
    p.ambientMaterial(100)
    p.box(100)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(1500,0,-1000)
    p.rotateY(p.frameCount * -0.014)
    p.rotateX(p.frameCount * 0.04)
    p.ambientMaterial(100)
    p.box(100)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(0,0,-1000)
    p.rotateY(p.frameCount * -0.014)
    p.rotateX(p.frameCount * 0.04)
    p.ambientMaterial(100)
    p.box(100)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(800,-800,-800)
    p.rotateY(p.frameCount * 0.024)
    p.rotateX(p.frameCount * 0.04)
    p.ambientMaterial(100)
    p.box(100)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(-300,200,-200)
    p.rotateY(p.frameCount * 0.024)
    p.rotateX(p.frameCount * 0.04)
    p.ambientMaterial(100)
    p.box(100)
    p.pop()

    p.push()
    p.noStroke()
    p.translate(0,-500,-500)
    p.rotateY(p.frameCount * -0.024)
    p.rotateX(p.frameCount * -0.04)
    p.rotateZ(60)
    p.ambientMaterial(200)
    p.box(100)
    p.pop()
    return

