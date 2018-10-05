import nimnuklear/nuklear except true, false, char, int, PI
import opengl, sdl2, sdl2/net, sdl2/mixer, sdl2/ttf

import nuklear_sdl_gl3, roboto_regular
import asyncnet, asyncdispatch, strutils, nativesockets, threadpool, math

var running = true

if sdl2.init(INIT_EVERYTHING) != SdlSuccess:
  echo("Couldn't initialize SDL")
defer: sdl2.quit()

proc listen() = 
  var clients : seq[AsyncSocket]

  var channel : cint
  var audio_rate : cint
  var audio_format : uint16
  var audio_buffers : cint = 4096
  var audio_channels : cint = 2
  
  channel = mixer.openAudio(audio_rate, audio_format, audio_channels, audio_buffers) 
  if channel != 0:
    echo("Couldn't open audio device. " & $sdl2.getError())
  var sound = loadWAV("ios.wav")
  defer: freeChunk sound; mixer.closeAudio()
  if sound == nil :
    echo "nil chunk"
  proc processClient(client: AsyncSocket) {.async.} =
    while true:
      let line = await client.recv(256)
      if line != "": 
        zeroMem(buffercs, buffercs.len)
        copyMem(addr buffers[0], line.cstring, line.len)
        if playChannel(-1, sound, 0) == -1:
          echo $sdl2.getError()


  proc serve() {.async.} =
    var server = newAsyncSocket(domain = AF_INET6)
    server.setSockOpt(OptReuseAddr, true)
    server.bindAddr(Port(1234))
    server.listen()

    while true:
      let client = await server.accept()
      clients.add client
      asyncCheck processClient(client)

  asyncCheck serve()
  runForever()
spawn listen()

proc GUI() = 
  defer: nk_sdl_shutdown(); quit(QuitSuccess)
  const
    WINDOW_WIDTH = 1200
    WINDOW_HEIGHT = 800
    MAX_VERTEX_MEMORY = 512 * 1024
    MAX_ELEMENT_MEMORY = 128 * 1024

  proc `or`(a, b :panel_flags): panel_flags =
    return panel_flags(a.cint or b.cint)

  ##  Platform
  var win: sdl2.WindowPtr
  var glContext: sdl2.GlContextPtr
  var
    win_width: cint
    win_height: cint
  ##  GUI
  var ctx: ptr context
  var bg: colorf
  ##  SDL setup
  discard sdl2.setHint("SDL_VIDEO_HIGHDPI_DISABLED", "0")
  when not defined(vcc):
    discard sdl2.setHint("SDL_WINDOWS_DISABLE_THREAD_NAMING", "1")
  discard sdl2.glSetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG)
  discard sdl2.glSetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE)
  discard sdl2.glSetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
  discard sdl2.glSetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)
  discard sdl2.glSetAttribute(SDL_GL_DOUBLEBUFFER, 1)
  win = sdl2.createWindow("守护者", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                          WINDOW_WIDTH, WINDOW_HEIGHT, SDL_WINDOW_OPENGL or SDL_WINDOW_SHOWN or SDL_WINDOW_ALLOW_HIGHDPI)
  glContext = sdl2.glCreateContext(win)
  win.getSize(win_width, win_height)

  ##  OpenGL setup
  opengl.loadExtensions()
  glViewport(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
  ctx = nk_sdl_init(win)
  
  var atlas: ptr font_atlas
  nk_sdl_font_stash_begin(addr(atlas))
  var cfg = nk_font_config(16.0)
  cfg.oversample_v = 1.cuchar
  cfg.oversample_h = 1.cuchar
  cfg.range = font_chinese_glyph_ranges()
  var font = font_atlas_add_from_file(atlas, "Deng.ttf".cstring, 16.0, addr cfg)
  nk_sdl_font_stash_end()
  style_set_font(ctx, addr font[].handle)

  bg.r = 0.1
  bg.g = 0.18
  bg.b = 0.24
  bg.a = 1.0
  proc render() = 
    while running :
      var evt: Event
      input_begin(ctx)
      while pollEvent(evt):
        if evt.kind == QuitEvent:
          quit(QuitFailure)
        discard nk_sdl_handle_event(addr(evt))
      input_end(ctx)

      ##  GUI
      if begin(ctx, "守护者".cstring,
               rect(x:50, y:50, w:800, h:600),
               flags(WINDOW_BORDER or WINDOW_MOVABLE or WINDOW_SCALABLE or WINDOW_MINIMIZABLE or WINDOW_TITLE or WINDOW_CLOSABLE)) == 1:


        layout_row_dynamic(ctx, 200, 1)
        length = current.len.cint
        copyMem(buffercs, current, length)
        buffers[length + 1] = '\0'
        discard edit_string(ctx, EDIT_BOX.flags, buffercs, addr(length), 255, filter_default)
        buffers[length] = '\0'
        copyMem(current, buffercs, buffercs.len)

        layout_row_dynamic(ctx, 20, 1)
        label(ctx, "background:", TEXT_LEFT.flags)
        layout_row_dynamic(ctx, 25, 1)
        if combo_begin_color(ctx, rgb_cf(bg),vec2(x: widget_width(ctx), y: 400)) == 1:
          layout_row_dynamic(ctx, 120, 1)
          bg = color_picker(ctx, bg, RGBA)
          layout_row_dynamic(ctx, 25, 1)
          bg.r = propertyf(ctx, "#R:", 0, bg.r, 1.0, 0.01, 0.005)
          bg.g = propertyf(ctx, "#G:", 0, bg.g, 1.0, 0.01, 0.005)
          bg.b = propertyf(ctx, "#B:", 0, bg.b, 1.0, 0.01, 0.005)
          bg.a = propertyf(ctx, "#A:", 0, bg.a, 1.0, 0.01, 0.005)
          combo_end(ctx)
      nuklear.end(ctx)
      win.getSize(win_width, win_height)
      glViewport(0, 0, win_width, win_height)
      glClear(GL_COLOR_BUFFER_BIT)
      glClearColor(bg.r, bg.g, bg.b, bg.a)
    
      nk_sdl_render(ANTI_ALIASING_ON, MAX_VERTEX_MEMORY, MAX_ELEMENT_MEMORY)
      sdl2.glSwapWindow(win)
  render()
GUI()

