petsChoiceLogo = undefined
scale = 40
terrainWidth = 80
terrainDepth = 29
xoff = 0.0
yoff = 0.0
terrain = []
myp5 = new p5 (p) ->

  # calculate terrain from Perlin noise
  yTerrain = (y) ->
    xTerrain = (x) ->
      arrayRow.push p.map(p.noise(xoff, yoff), 0, 1, -400, 300)
      xoff += .05
      return

    arrayRow = []
    xoff = 0.0
    xTerrain x for x in [0 .. terrainWidth]
    xoff = 0.0
    terrain.push arrayRow
    yoff += .05
    return
  yTerrain y for y in [0 .. terrainDepth]


  p.preload = ->
    petsChoiceLogo = p.loadImage('pets_choice_berlin_logo_black_bg.png')
    return

  p.setup = ->
    p.frameRate(30)
    p.createCanvas 1280, 720, p.WEBGL

  p.draw = ->
    p.background(30)

    terrain.pop()

    # calculate terrain from Perlin noise
    singleTerrain = (x) ->
      newRow.push(p.map(p.noise(xoff, yoff), 0, 1, -400, 300))
      xoff += .05
      return

    newRow = []
    xoff = 0.0
    singleTerrain x for x in [0 .. terrainWidth]
    xoff = 0.0
    terrain.unshift newRow

    p.push()
    foo = (y) ->
      baz = (x) ->
        # p.beginShape()
        p.vertex(x * scale, y * scale, terrain[y][x])
        p.vertex(x * scale, (y + 1) * scale, terrain[y + 1][x])
        # p.vertex((x + 1) * scale, y * scale, terrain[y][x + 1])
        # p.endShape(p.CLOSE)
        return
      p.beginShape(p.TRIANGLE_STRIP)
      x = 0
      while x < terrainWidth - 1
        p.vertex(x * scale, y * scale, terrain[y][x])
        p.vertex(x * scale, (y + 1) * scale, terrain[y + 1][x])
        x++
      # baz x for x in [0 .. terrainWidth]
      p.endShape()
      return

    p.stroke(255)
    # p.noFill() # (0, 0, 0)
    p.strokeWeight(1)
    p.translate(-1500, 0, -1000)
    p.rotateX(p.PI / 2.5)
    foo y for y in [0 .. (terrainDepth - 1)]
    p.pop()
    yoff += 0.05

    p.push()
    # p.texture(petsChoiceLogo)
    p.stroke(255)
    p.directionalLight(255, 255, 255, -1, 1, -1)
    p.directionalLight(0, 0, 40, 1, -1, -1)
    p.translate(200,0)
    # p.rotateY(p.frameCount * 0.012)
    p.rotateZ(p.frameCount * 0.01)
    p.box(200)
    p.pop()
    return

