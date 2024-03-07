##### SETUP
shared_lib_path = Gem::Specification.find_by_name('raylib-bindings').full_gem_path + '/lib/'

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  Raylib.load_lib(shared_lib_path + 'libraylib.dll', raygui_libpath: shared_lib_path + 'raygui.dll', physac_libpath: shared_lib_path + 'physac.dll')
when /darwin/
  arch = RUBY_PLATFORM.split('-')[0]
  Raylib.load_lib(shared_lib_path + "libraylib.#{arch}.dylib", raygui_libpath: shared_lib_path + "raygui.#{arch}.dylib", physac_libpath: shared_lib_path + "physac.#{arch}.dylib")
when /linux/
  arch = RUBY_PLATFORM.split('-')[0]
  Raylib.load_lib(shared_lib_path + "libraylib.#{arch}.so", raygui_libpath: shared_lib_path + "raygui.#{arch}.so", physac_libpath: shared_lib_path + "physac.#{arch}.so")
else
  raise RuntimeError, "Unknown OS: #{RUBY_PLATFORM}"
end

##### Testing raylib
require 'raylib'

screen_width = 800
screen_height = 600
Raylib.InitWindow(screen_width, screen_height, "Hello Raylib")

until Raylib.WindowShouldClose
  Raylib.BeginDrawing()

  Raylib.ClearBackground(Raylib::RAYWHITE)

  Raylib.DrawText("Hello World", 10, 10, 20, Raylib::BLACK)

  Raylib.EndDrawing()
end

Raylib.CloseWindow()
