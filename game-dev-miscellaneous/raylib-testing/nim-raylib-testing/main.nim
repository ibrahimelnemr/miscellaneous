import raylib

const
  screenWidth = 800
  screenHeight = 450

proc main =

  initWindow(800, 450, "Hello World")
  setTargetFPS(60)

  while not windowShouldClose():
    beginDrawing()
    clearBackground(RAYWHITE)
  
    drawText("Hello World!", 190, 200, 20, BLACK)
    endDrawing()

  closeWindow()

main()