## 
##  Nuklear - 1.32.0 - public domain
##  no warrenty implied; use at your own risk.
##  authored from 2015-2016 by Micha Mettke
##  converted to Nim in 2018 by Alex Mayfield
## 
## 
##  ==============================================================
## 
##                               API
## 
##  ===============================================================
## 

import opengl, sdl2

import nimnuklear/nuklear except true, false, char
import net, packedjson, strutils
## 
##  ==============================================================
## 
##                           IMPLEMENTATION
## 
##  ===============================================================
## 

type
  Sdl_device* {.bycopy.} = object
    cmds*: buffer
    null*: draw_null_texture
    vbo*: GLuint
    vao*: GLuint
    ebo*: GLuint
    prog*: GLuint
    vert_shdr*: GLuint
    frag_shdr*: GLuint
    attrib_pos*: GLint
    attrib_uv*: GLint
    attrib_col*: GLint
    uniform_tex*: GLint
    uniform_proj*: GLint
    font_tex*: GLuint

type
  Sdl_vertex* {.bycopy.} = object
    position*: array[2, cfloat]
    uv*: array[2, cfloat]
    col*: array[4, nuklear.byte]

type
  Sdl* {.bycopy.} = object
    win*: WindowPtr
    ogl*: Sdl_device
    ctx*: context
    atlas*: font_atlas

var sdl*: Sdl
proc nk_sdl_device_create*() =
  var status: GLint

  const vertex_shader = staticRead("vert.glsl")
  const fragment_shader = staticRead("frag.glsl")
  # Needed in order to pass shaders to opengl
  var vertex_shader_a: array[1, string] = [vertex_shader]
  var vertex_shader_z = allocCStringArray(vertex_shader_a)
  defer: deallocCStringArray(vertex_shader_z)
  var fragment_shader_a: array[1, string] = [fragment_shader]
  var fragment_shader_z = allocCStringArray(fragment_shader_a)
  defer: deallocCStringArray(fragment_shader_z)

  var dev: ptr Sdl_device = addr(sdl.ogl)
  buffer_init_default(addr(dev.cmds))
  dev.prog = glCreateProgram()
  dev.vert_shdr = glCreateShader(GL_VERTEX_SHADER)
  dev.frag_shdr = glCreateShader(GL_FRAGMENT_SHADER)
  glShaderSource(dev.vert_shdr, 1, vertex_shader_z, nil)
  glShaderSource(dev.frag_shdr, 1, fragment_shader_z, nil)
  glCompileShader(dev.vert_shdr)
  glCompileShader(dev.frag_shdr)
  glGetShaderiv(dev.vert_shdr, GL_COMPILE_STATUS, addr(status))
  assert(status.GLboolean == GL_TRUE)
  glGetShaderiv(dev.frag_shdr, GL_COMPILE_STATUS, addr(status))
  assert(status.GLboolean == GL_TRUE)
  glAttachShader(dev.prog, dev.vert_shdr)
  glAttachShader(dev.prog, dev.frag_shdr)
  glLinkProgram(dev.prog)
  glGetProgramiv(dev.prog, GL_LINK_STATUS, addr(status))
  assert(status.GLboolean == GL_TRUE)

  dev.uniform_tex = glGetUniformLocation(dev.prog, "Texture")
  dev.uniform_proj = glGetUniformLocation(dev.prog, "ProjMtx")
  dev.attrib_pos = glGetAttribLocation(dev.prog, "Position")
  dev.attrib_uv = glGetAttribLocation(dev.prog, "TexCoord")
  dev.attrib_col = glGetAttribLocation(dev.prog, "Color")

  ##  buffer setup
  var vs: GLsizei = sizeof(Sdl_vertex).GLsizei
  ## FIXME: Nim doesn't have offsetof.  The struct happens to be tightly
  ##        packed on my architecture, but this could easily blow up.
  var vp: csize = 0
  var vt: csize = vp + sizeof(Sdl_vertex.position)
  var vc: csize = vt + sizeof(SDL_vertex.uv)
  glGenBuffers(1, addr(dev.vbo))
  glGenBuffers(1, addr(dev.ebo))
  glGenVertexArrays(1, addr(dev.vao))
  glBindVertexArray(dev.vao)
  glBindBuffer(GL_ARRAY_BUFFER, dev.vbo)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, dev.ebo)
  glEnableVertexAttribArray(dev.attrib_pos.GLuint)
  glEnableVertexAttribArray(dev.attrib_uv.GLuint)
  glEnableVertexAttribArray(dev.attrib_col.GLuint)
  glVertexAttribPointer(dev.attrib_pos.GLuint, 2, cGL_FLOAT, GL_FALSE, vs,
                        cast[pointer](vp))
  glVertexAttribPointer(dev.attrib_uv.GLuint, 2, cGL_FLOAT, GL_FALSE, vs,
                        cast[pointer](vt))
  glVertexAttribPointer(dev.attrib_col.GLuint, 4, GL_UNSIGNED_BYTE,
                        GL_TRUE, vs, cast[pointer](vc))

  glBindTexture(GL_TEXTURE_2D, 0)
  glBindBuffer(GL_ARRAY_BUFFER, 0)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
  glBindVertexArray(0)

proc nk_sdl_device_upload_atlas*(image: pointer; width: cint; height: cint) =
  var dev: ptr Sdl_device = addr(sdl.ogl)
  glGenTextures(1, addr(dev.font_tex))
  glBindTexture(GL_TEXTURE_2D, dev.font_tex)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA.GLint, width.GLsizei,
               height.GLsizei, 0, GL_RGBA, GL_UNSIGNED_BYTE, image)

proc nk_sdl_device_destroy*() =
  var dev: ptr Sdl_device = addr(sdl.ogl)
  glDetachShader(dev.prog, dev.vert_shdr)
  glDetachShader(dev.prog, dev.frag_shdr)
  glDeleteShader(dev.vert_shdr)
  glDeleteShader(dev.frag_shdr)
  glDeleteProgram(dev.prog)
  glDeleteTextures(1, addr(dev.font_tex))
  glDeleteBuffers(1, addr(dev.vbo))
  glDeleteBuffers(1, addr(dev.ebo))
  buffer_free(addr(dev.cmds))

#define nk_draw_foreach(cmd,ctx, b) for((cmd)=nk__draw_begin(ctx, b); (cmd)!=0; (cmd)=nk__draw_next(cmd, b, ctx))
## FIXME: Put this in the nuklear implementation itself
iterator draw_foreach(ctx: ptr context, b: ptr buffer): ptr draw_command =
  var cmd = draw_begin(ctx, b)
  while not cmd.isNil:
    yield cmd
    cmd = draw_next(cmd, b, ctx)

proc nk_sdl_render*(AA: anti_aliasing; max_vertex_buffer: cint;
                   max_element_buffer: cint) =
  var dev: ptr Sdl_device = addr(sdl.ogl)
  var
    width: cint
    height: cint
  var
    display_width: cint
    display_height: cint
  var scale: vec2
  var ortho: array[4, array[4, GLfloat]] = [
    [2.0'f32, 0.0'f32, 0.0'f32, 0.0'f32],
    [0.0'f32, -2.0'f32, 0.0'f32, 0.0'f32],
    [0.0'f32, 0.0'f32, -1.0'f32, 0.0'f32],
    [-1.0'f32, 1.0'f32, 0.0'f32, 1.0'f32]
  ]
  sdl.win.getSize(width, height)
  sdl.win.glGetDrawableSize(display_width, display_height)

  ortho[0][0] = ortho[0][0] / width.GLfloat
  ortho[1][1] = ortho[1][1] / height.GLfloat

  scale.x = display_width.cfloat / width.cfloat
  scale.y = display_height.cfloat / height.cfloat

  ##  setup global state
  glViewport(0, 0, display_width, display_height)
  glEnable(GL_BLEND)
  glBlendEquation(GL_FUNC_ADD)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  glDisable(GL_CULL_FACE)
  glDisable(GL_DEPTH_TEST)
  glEnable(GL_SCISSOR_TEST)
  glActiveTexture(GL_TEXTURE0)

  ##  setup program
  glUseProgram(dev.prog)
  glUniform1i(dev.uniform_tex, 0)
  glUniformMatrix4fv(dev.uniform_proj, 1, GL_FALSE, addr(ortho[0][0]))

  ##  convert from command queue into draw list and draw to screen
  var
    cmd: ptr draw_command
    vertices: pointer
    elements: pointer
    offset: system.uint = 0
    vbuf: buffer
    ebuf: buffer

  ##  allocate vertex and element buffer
  glBindVertexArray(dev.vao)
  glBindBuffer(GL_ARRAY_BUFFER, dev.vbo)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, dev.ebo)

  glBufferData(GL_ARRAY_BUFFER, max_vertex_buffer, nil, GL_STREAM_DRAW)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, max_element_buffer, nil, GL_STREAM_DRAW)

  ##  load vertices/elements directly into vertex/element buffer
  vertices = glMapBuffer(GL_ARRAY_BUFFER, GL_WRITE_ONLY)
  elements = glMapBuffer(GL_ELEMENT_ARRAY_BUFFER, GL_WRITE_ONLY)

  ##  fill convert configuration
  var config: convert_config
  var vertex_layout {.global.}: array[4, draw_vertex_layout_element] = [
    draw_vertex_layout_element(
      attribute: VERTEX_POSITION,
      format: FORMAT_FLOAT,
      offset: cast[ptr nuklear.uint](0)
    ),
    draw_vertex_layout_element(
      attribute: VERTEX_TEXCOORD,
      format: FORMAT_FLOAT,
      offset: cast[ptr nuklear.uint](sizeof(Sdl_vertex.position))
    ),
    draw_vertex_layout_element(
      attribute: VERTEX_COLOR,
      format: FORMAT_R8G8B8A8,
      offset: cast[ptr nuklear.uint](sizeof(Sdl_vertex.position) + sizeof(Sdl_vertex.uv))
    ),
    # NK_VERTEX_LAYOUT_END
    draw_vertex_layout_element(
      attribute: VERTEX_ATTRIBUTE_COUNT,
      format: FORMAT_COUNT,
      offset: nil
    )
  ]
  zeroMem(addr(config), sizeof(config))
  config.vertex_layout = addr vertex_layout[0]
  config.vertex_size = cast[size](sizeof(Sdl_vertex))
  ## FIXME: Nim doesn't have alignof.  The original invocation was:
  ##        NK_ALIGNOF(struct nk_sdl_vertex)
  config.vertex_alignment = cast[size](8)
  config.null = dev.null
  config.circle_segment_count = 22
  config.curve_segment_count = 22
  config.arc_segment_count = 22
  config.global_alpha = 1.0
  config.shape_AA = AA
  config.line_AA = AA

  ##  setup buffers to load vertices and elements
  buffer_init_fixed(addr(vbuf), vertices, cast[size](max_vertex_buffer))
  buffer_init_fixed(addr(ebuf), elements, cast[size](max_element_buffer))
  discard convert(addr(sdl.ctx), addr(dev.cmds), addr(vbuf), addr(ebuf), addr(config))

  discard glUnmapBuffer(GL_ARRAY_BUFFER)
  discard glUnmapBuffer(GL_ELEMENT_ARRAY_BUFFER)

  ##  iterate over and execute each draw command
  for cmd in draw_foreach(addr sdl.ctx, addr dev.cmds):
    if cmd.elem_count == 0:
      continue

    glBindTexture(GL_TEXTURE_2D, cast[GLuint](cmd.texture.id))
    glScissor(
      GLint(cmd.clip_rect.x * scale.x),
      GLint(cfloat(height - GLint(cmd.clip_rect.y + cmd.clip_rect.h)) * scale.y),
      GLint(cmd.clip_rect.w * scale.x),
      GLint(cmd.clip_rect.h * scale.y))
    glDrawElements(GL_TRIANGLES, cast[GLsizei](cmd.elem_count), GL_UNSIGNED_SHORT,
                  cast[pointer](offset))

    # The original code is offset += cmd->elem_count.
    inc(offset, system.int(cmd.elem_count) * sizeof(draw_index))

  clear(addr(sdl.ctx))

  # default OpenGL state
  glUseProgram(0)
  glBindBuffer(GL_ARRAY_BUFFER, 0)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
  glBindVertexArray(0)
  glDisable(GL_BLEND)
  glDisable(GL_SCISSOR_TEST)

proc nk_sdl_clipbard_paste*(usr: handle; edit: ptr text_edit) {.cdecl.} =
  var text: cstring = sdl2.getClipboardText()
  if not text.isNil:
    discard textedit_paste(edit, text, strlen(text))

proc nk_sdl_clipbard_copy*(usr: handle; text: cstring; len: cint) {.cdecl.} =
  var str: cstring = nil
  if len == 0:
    return
  str = cast[cstring](alloc(len + 1))
  if str.isNil:
    return
  defer: dealloc(str)
  copyMem(str, text, len)
  str[len] = '\x00'
  discard sdl2.setClipboardText(str)

proc nk_sdl_init*(win: sdl2.WindowPtr): ptr context =
  sdl.win = win
  discard init_default(addr(sdl.ctx), nil)
  sdl.ctx.clip.copy = nk_sdl_clipbard_copy
  sdl.ctx.clip.paste = nk_sdl_clipbard_paste
  sdl.ctx.clip.userdata = handle_ptr(nil)
  nk_sdl_device_create()
  return addr(sdl.ctx)

proc nk_sdl_font_stash_begin*(atlas: ptr ptr font_atlas) =
  font_atlas_init_default(addr(sdl.atlas))
  font_atlas_begin(addr(sdl.atlas))
  atlas[] = addr(sdl.atlas)

proc nk_sdl_font_stash_end*() =
  var image: pointer
  var
    w: cint
    h: cint
  image = font_atlas_bake(addr(sdl.atlas), addr(w), addr(h),
                           FONT_ATLAS_RGBA32)
  nk_sdl_device_upload_atlas(image, w, h)
  font_atlas_end(addr(sdl.atlas),
                    handle_id(cast[cint](sdl.ogl.font_tex)),
                    addr(sdl.ogl.null))
  if not sdl.atlas.default_font.isNil:
    style_set_font(addr(sdl.ctx), addr(sdl.atlas.default_font.handle))

var length*: cint 
var buffers*: array[256, char] 
var current* {.global.} : ptr char = addr buffers[0]

var buffercs*: cstring = cast[cstring](addr buffers[0])

let ipv6Address = parseFile("ipconfig.json")["dial_ipv6"].getStr() 

proc nk_sdl_handle_event*(evt: ptr sdl2.Event): cint =
  const SCANCODE_LCTRL = system.int(sdl2.SDL_SCANCODE_LCTRL)
  var ctx: ptr context = addr(sdl.ctx)
  if evt.kind == sdl2.KeyUp or evt.kind == sdl2.KeyDown:
    var down = evt.kind == sdl2.KeyDown
    var state = sdl2.getKeyboardState()
    var sym = evt[].key.keysym.sym
    if sym == K_RSHIFT or sym == K_LSHIFT:
      input_key(ctx, KEY_SHIFT, down.cint)
    elif sym == K_DELETE:
      input_key(ctx, KEY_DEL, down.cint)
    elif sym == K_RETURN:
      var ctrlReturn = down.cint and state[SCANCODE_LCTRL].cint
      if ctrlReturn == 1:
        try:
          var socket = dial(ipv6Address, Port(1234))
          defer: socket.close
          var content = $buffercs
          socket.send(content)
          zeroMem(buffercs, buffercs.len)
        except:
          echo getCurrentExceptionMsg()
      else:
        input_key(ctx, KEY_ENTER, down.cint)
    elif sym == K_TAB:
      input_key(ctx, KEY_TAB, down.cint)
    elif sym == K_BACKSPACE:
      input_key(ctx, KEY_BACKSPACE, down.cint)
    elif sym == K_HOME:
      input_key(ctx, KEY_TEXT_START, down.cint)
      input_key(ctx, KEY_SCROLL_START, down.cint)
    elif sym == K_END:
      input_key(ctx, KEY_TEXT_END, down.cint)
      input_key(ctx, KEY_SCROLL_END, down.cint)
    elif sym == K_PAGEDOWN:
      input_key(ctx, KEY_SCROLL_DOWN, down.cint)
    elif sym == K_PAGEUP:
      input_key(ctx, KEY_SCROLL_UP, down.cint)
    elif sym == K_z:
      input_key(ctx, KEY_TEXT_UNDO, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_r:
      input_key(ctx, KEY_TEXT_REDO, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_c:
      input_key(ctx, KEY_COPY, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_v:
      input_key(ctx, KEY_PASTE, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_x:
      input_key(ctx, KEY_CUT, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_b:
      input_key(ctx, KEY_TEXT_LINE_START, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_e:
      input_key(ctx, KEY_TEXT_LINE_END, down.cint and state[SCANCODE_LCTRL].cint)
    elif sym == K_UP:
      input_key(ctx, keys.KEY_UP, down.cint)
    elif sym == K_DOWN:
      input_key(ctx, keys.KEY_DOWN, down.cint)
    elif sym == K_LEFT:
      if state[SCANCODE_LCTRL] == 1:
        input_key(ctx, KEY_TEXT_WORD_LEFT, down.cint)
      else:
        input_key(ctx, KEY_LEFT, down.cint)
    elif sym == K_RIGHT:
      if state[SCANCODE_LCTRL] == 1:
        input_key(ctx, KEY_TEXT_WORD_RIGHT, down.cint)
      else:
        input_key(ctx, KEY_RIGHT, down.cint)
    else:
      return 0
    return 1
  elif evt.kind == sdl2.MouseButtonDown or evt.kind == sdl2.MouseButtonUp:
    ##  mouse button
    var down = evt.kind == MouseButtonDown
    var
      x: cint = evt[].button.x
      y: cint = evt[].button.y
    if evt[].button.button == sdl2.BUTTON_LEFT:
      if evt[].button.clicks > 1'u8:
        input_button(ctx, BUTTON_DOUBLE, x, y, down.cint)
      input_button(ctx, buttons.BUTTON_LEFT, x, y, down.cint)
    elif evt[].button.button == sdl2.BUTTON_MIDDLE:
      input_button(ctx, buttons.BUTTON_MIDDLE, x, y, down.cint)
    elif evt[].button.button == sdl2.BUTTON_RIGHT:
      input_button(ctx, buttons.BUTTON_RIGHT, x, y, down.cint)
    return 1
  elif evt.kind == sdl2.MouseMotion:
    ##  mouse motion
    if ctx.input.mouse.grabbed != 0.cuchar:
      var
        x: cint = ctx.input.mouse.prev.x.cint
        y: cint = ctx.input.mouse.prev.y.cint
      input_motion(ctx, x + evt[].motion.xrel, y + evt[].motion.yrel)
    else:
      input_motion(ctx, evt[].motion.x, evt[].motion.y)
    return 1
  elif evt.kind == sdl2.TextInput:
    ##  text input
    var glyph: glyph
    copyMem(addr glyph[0], addr evt[].text.text[0], UTF_SIZE)
    input_glyph(ctx, glyph)
    return 1
  elif evt.kind == sdl2.MouseWheel:
    ##  mouse wheel
    input_scroll(ctx, vec2(
      x: evt[].wheel.x.cfloat,
      y: evt[].wheel.y.cfloat
    ))
    return 1
  return 0

proc nk_sdl_shutdown*() =
  font_atlas_clear(addr(sdl.atlas))
  free(addr(sdl.ctx))
  nk_sdl_device_destroy()
  zeroMem(addr sdl, sizeof(sdl))
