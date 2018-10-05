macro find_size(a,b: untyped): untyped =
  if sizeof(a) < sizeof(b):
    sizeof(b)
  else:
    sizeof(a) div sizeof(uint32) div 2
import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "/src\"".}
const headernuklear = sourcePath & "/src/nuklear.h"
{.passC: "-DNK_INCLUDE_FIXED_TYPES -DNK_INCLUDE_STANDARD_IO".}
{.passC: "-DNK_INCLUDE_FONT_BAKING -DNK_INCLUDE_DEFAULT_ALLOCATOR".}
{.passC: "-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT -DNK_INCLUDE_DEFAULT_FONT".}
{.passC: "-DNK_INCLUDE_STANDARD_VARARGS".}
{.compile: "nimnuklear/src/nuklear_buffer.c".}
{.compile: "nimnuklear/src/nuklear_button.c".}
{.compile: "nimnuklear/src/nuklear_chart.c".}
{.compile: "nimnuklear/src/nuklear_color.c".}
{.compile: "nimnuklear/src/nuklear_color_picker.c".}
{.compile: "nimnuklear/src/nuklear_combo.c".}
{.compile: "nimnuklear/src/nuklear_context.c".}
{.compile: "nimnuklear/src/nuklear_contextual.c".}
{.compile: "nimnuklear/src/nuklear_draw.c".}
{.compile: "nimnuklear/src/nuklear_edit.c".}
{.compile: "nimnuklear/src/nuklear_font.c".}
{.compile: "nimnuklear/src/nuklear_group.c".}
{.compile: "nimnuklear/src/nuklear_image.c".}
{.compile: "nimnuklear/src/nuklear_input.c".}
{.compile: "nimnuklear/src/nuklear_layout.c".}
{.compile: "nimnuklear/src/nuklear_list_view.c".}
{.compile: "nimnuklear/src/nuklear_math.c".}
{.compile: "nimnuklear/src/nuklear_menu.c".}
{.compile: "nimnuklear/src/nuklear_page_element.c".}
{.compile: "nimnuklear/src/nuklear_panel.c".}
{.compile: "nimnuklear/src/nuklear_pool.c".}
{.compile: "nimnuklear/src/nuklear_popup.c".}
{.compile: "nimnuklear/src/nuklear_progress.c".}
{.compile: "nimnuklear/src/nuklear_property.c".}
{.compile: "nimnuklear/src/nuklear_scrollbar.c".}
{.compile: "nimnuklear/src/nuklear_selectable.c".}
{.compile: "nimnuklear/src/nuklear_slider.c".}
{.compile: "nimnuklear/src/nuklear_string.c".}
{.compile: "nimnuklear/src/nuklear_style.c".}
{.compile: "nimnuklear/src/nuklear_table.c".}
{.compile: "nimnuklear/src/nuklear_text.c".}
{.compile: "nimnuklear/src/nuklear_text_editor.c".}
{.compile: "nimnuklear/src/nuklear_toggle.c".}
{.compile: "nimnuklear/src/nuklear_tooltip.c".}
{.compile: "nimnuklear/src/nuklear_tree.c".}
{.compile: "nimnuklear/src/nuklear_utf8.c".}
{.compile: "nimnuklear/src/nuklear_util.c".}
{.compile: "nimnuklear/src/nuklear_vertex.c".}
{.compile: "nimnuklear/src/nuklear_widget.c".}
{.compile: "nimnuklear/src/nuklear_window.c".}
const
  #UTF_INVALID* = 0x00000000
  UTF_SIZE* = 4
  INPUT_MAX* = 16
  MAX_NUMBER_BUFFER* = 64
  SCROLLBAR_HIDING_TIMEOUT* = 4.0
  TEXTEDIT_UNDOSTATECOUNT* = 99
  TEXTEDIT_UNDOCHARCOUNT* = 999
  MAX_LAYOUT_ROW_TEMPLATE_COLUMNS* = 16
  CHART_MAX_SLOT* = 4
  WINDOW_MAX_NAME* = 64
  BUTTON_BEHAVIOR_STACK_SIZE* = 8
  FONT_STACK_SIZE* = 8
  STYLE_ITEM_STACK_SIZE* = 16
  FLOAT_STACK_SIZE* = 32
  VECTOR_STACK_SIZE* = 16
  FLAGS_STACK_SIZE* = 32
  COLOR_STACK_SIZE* = 32
  #float* = f
  PI* = 3.141592654
  #UTF_INVALID* = 0x00000000
  MAX_FLOAT_PRECISION* = 2
  

type
  char* = int8
  uchar* = uint8
  byte* = uint8
  short* = int16
  ushort* = uint16
  int* = int32
  uint* = uint32
  size* = ptr uint
  `ptr`* = ptr uint
  hash* = uint
  flags* = uint
  rune* = uint
const
  false* = 0
  true* = 1

type
  color* {.importc: "struct nk_color", header: headernuklear.} = object
    r* {.importc: "r".}: byte
    g* {.importc: "g".}: byte
    b* {.importc: "b".}: byte
    a* {.importc: "a".}: byte

  colorf* {.importc: "struct nk_colorf", header: headernuklear.} = object
    r* {.importc: "r".}: cfloat
    g* {.importc: "g".}: cfloat
    b* {.importc: "b".}: cfloat
    a* {.importc: "a".}: cfloat

  vec2* {.importc: "struct nk_vec2", header: headernuklear.} = object
    x* {.importc: "x".}: cfloat
    y* {.importc: "y".}: cfloat

  vec2i* {.importc: "struct nk_vec2i", header: headernuklear.} = object
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort

  rect* {.importc: "struct nk_rect", header: headernuklear.} = object
    x* {.importc: "x".}: cfloat
    y* {.importc: "y".}: cfloat
    w* {.importc: "w".}: cfloat
    h* {.importc: "h".}: cfloat

  recti* {.importc: "struct nk_recti", header: headernuklear.} = object
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cshort
    h* {.importc: "h".}: cshort

  glyph* = array[4, char]
  handle* {.importc: "nk_handle", header: headernuklear.} = object {.union.}
    `ptr`* {.importc: "ptr".}: pointer
    id* {.importc: "id".}: cint

  img* {.importc: "struct nk_image", header: headernuklear.} = object
    handle* {.importc: "handle".}: handle
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    region* {.importc: "region".}: array[4, cushort]

  cursor* {.importc: "struct nk_cursor", header: headernuklear.} = object
    img* {.importc: "img".}: img
    size* {.importc: "size".}: vec2
    offset* {.importc: "offset".}: vec2

  scroll* {.importc: "struct nk_scroll", header: headernuklear.} = object
    x* {.importc: "x".}: uint
    y* {.importc: "y".}: uint

  heading* {.size: sizeof(cint).} = enum
    UP, RIGHT, DOWN, LEFT


type
  button_behavior* {.size: sizeof(cint).} = enum
    BUTTON_DEFAULT, BUTTON_REPEATER


type
  modify* {.size: sizeof(cint).} = enum
    FIXED = false, MODIFIABLE = true


type
  orientation* {.size: sizeof(cint).} = enum
    VERTICAL, HORIZONTAL


type
  collapse_states* {.size: sizeof(cint).} = enum
    MINIMIZED = false, MAXIMIZED = true


type
  show_states* {.size: sizeof(cint).} = enum
    HIDDEN = false, SHOWN = true


type
  chart_type* {.size: sizeof(cint).} = enum
    CHART_LINES, CHART_COLUMN, CHART_MAX


type
  chart_event* {.size: sizeof(cint).} = enum
    CHART_HOVERING = 0x00000001, CHART_CLICKED = 0x00000002


type
  color_format* {.size: sizeof(cint).} = enum
    RGB, RGBA


type
  popup_type* {.size: sizeof(cint).} = enum
    POPUP_STATIC, POPUP_DYNAMIC


type
  layout_format* {.size: sizeof(cint).} = enum
    DYNAMIC, STATIC


type
  tree_type* {.size: sizeof(cint).} = enum
    TREE_NODE, TREE_TAB
    type
  panel_type* {.size: sizeof(cint).} = enum
    PANEL_NONE = 0, PANEL_WINDOW = (1 shl (0)), PANEL_GROUP = (1 shl (1)),
    PANEL_POPUP = (1 shl (2)), PANEL_CONTEXTUAL = (1 shl (4)), PANEL_COMBO = (1 shl (5)),
    PANEL_MENU = (1 shl (6)), PANEL_TOOLTIP = (1 shl (7))


type
  panel_set* {.size: sizeof(cint).} = enum
    PANEL_SET_NONBLOCK = PANEL_CONTEXTUAL.int or PANEL_COMBO.int or PANEL_MENU.int or
        PANEL_TOOLTIP.int, PANEL_SET_POPUP = PANEL_SET_NONBLOCK.int or PANEL_POPUP.int,
    PANEL_SET_SUB = PANEL_SET_POPUP.int or PANEL_GROUP.int

  panel_flags* {.size: sizeof(cint).} = enum
    WINDOW_BORDER = (1 shl (0)), WINDOW_MOVABLE = (1 shl (1)),
    WINDOW_SCALABLE = (1 shl (2)), WINDOW_CLOSABLE = (1 shl (3)),
    WINDOW_MINIMIZABLE = (1 shl (4)), WINDOW_NO_SCROLLBAR = (1 shl (5)),
    WINDOW_TITLE = (1 shl (6)), WINDOW_SCROLL_AUTO_HIDE = (1 shl (7)),
    WINDOW_BACKGROUND = (1 shl (8)), WINDOW_SCALE_LEFT = (1 shl (9)),
    WINDOW_NO_INPUT = (1 shl (10))

  window_flags* {.size: sizeof(cint).} = enum
    WINDOW_PRIVATE = (1 shl (11)), WINDOW_ROM = (1 shl (12)),
    WINDOW_NOT_INTERACTIVE = WINDOW_ROM.int32 or WINDOW_NO_INPUT.int32,
    WINDOW_HIDDEN = (1 shl (13)), WINDOW_CLOSED = (1 shl (14)),
    WINDOW_MINIMIZED = (1 shl (15)), WINDOW_REMOVE_ROM = (1 shl (16))
const WINDOW_DYNAMIC = WINDOW_PRIVATE
type
  chart_slot* {.importc: "struct nk_chart_slot", header: headernuklear.} = object
    `type`* {.importc: "type".}: chart_type
    color* {.importc: "color".}: color
    highlight* {.importc: "highlight".}: color
    min* {.importc: "min".}: cfloat
    max* {.importc: "max".}: cfloat
    range* {.importc: "range".}: cfloat
    count* {.importc: "count".}: cint
    last* {.importc: "last".}: vec2
    index* {.importc: "index".}: cint

  chart* {.importc: "struct nk_chart", header: headernuklear.} = object
    slot* {.importc: "slot".}: cint
    x* {.importc: "x".}: cfloat
    y* {.importc: "y".}: cfloat
    w* {.importc: "w".}: cfloat
    h* {.importc: "h".}: cfloat
    slots* {.importc: "slots".}: array[4, chart_slot]

  panel_row_layout_type* {.size: sizeof(cint).} = enum
    LAYOUT_DYNAMIC_FIXED = 0, LAYOUT_DYNAMIC_ROW, LAYOUT_DYNAMIC_FREE,
    LAYOUT_DYNAMIC, LAYOUT_STATIC_FIXED, LAYOUT_STATIC_ROW, LAYOUT_STATIC_FREE,
    LAYOUT_STATIC, LAYOUT_TEMPLATE, LAYOUT_COUNT


type
  row_layout* {.importc: "struct nk_row_layout", header: headernuklear.} = object
    `type`* {.importc: "type".}: panel_row_layout_type
    index* {.importc: "index".}: cint
    height* {.importc: "height".}: cfloat
    min_height* {.importc: "min_height".}: cfloat
    columns* {.importc: "columns".}: cint
    ratio* {.importc: "ratio".}: ptr cfloat
    item_width* {.importc: "item_width".}: cfloat
    item_height* {.importc: "item_height".}: cfloat
    item_offset* {.importc: "item_offset".}: cfloat
    filled* {.importc: "filled".}: cfloat
    item* {.importc: "item".}: rect
    tree_depth* {.importc: "tree_depth".}: cint
    templates* {.importc: "templates".}: array[16, cfloat]

  popup_buffer* {.importc: "struct nk_popup_buffer", header: headernuklear.} = object
    begin* {.importc: "begin".}: size
    parent* {.importc: "parent".}: size
    last* {.importc: "last".}: size
    `end`* {.importc: "end".}: size
    active* {.importc: "active".}: cint

  menu_state* {.importc: "struct nk_menu_state", header: headernuklear.} = object
    x* {.importc: "x".}: cfloat
    y* {.importc: "y".}: cfloat
    w* {.importc: "w".}: cfloat
    h* {.importc: "h".}: cfloat
    offset* {.importc: "offset".}: scroll

  buffer_allocation_type* {.size: sizeof(cint).} = enum
    BUFFER_FRONT, BUFFER_BACK, BUFFER_MAX

  buffer_marker* {.importc: "struct nk_buffer_marker", header: headernuklear.} = object
    active* {.importc: "active".}: cint
    offset* {.importc: "offset".}: size

  memory* {.importc: "struct nk_memory", header: headernuklear.} = object
    `ptr`* {.importc: "ptr".}: pointer
    size* {.importc: "size".}: size

  clipboard* {.importc: "struct nk_clipboard", header: headernuklear.} = object
    userdata* {.importc: "userdata".}: handle
    paste* {.importc: "paste".}: plugin_paste
    copy* {.importc: "copy".}: plugin_copy

  str* {.importc: "struct nk_str", header: headernuklear.} = object
    buffer* {.importc: "buffer".}: buffer
    len* {.importc: "len".}: cint
  
  text_undo_record* {.importc: "struct nk_text_undo_record", header: headernuklear.} = object
    where* {.importc: "where".}: cint
    insert_length* {.importc: "insert_length".}: cshort
    delete_length* {.importc: "delete_length".}: cshort
    char_storage* {.importc: "char_storage".}: cshort

  text_undo_state* {.importc: "struct nk_text_undo_state", header: headernuklear.} = object
    undo_rec* {.importc: "undo_rec".}: array[99, text_undo_record]
    undo_char* {.importc: "undo_char".}: array[999, rune]
    undo_point* {.importc: "undo_point".}: cshort
    redo_point* {.importc: "redo_point".}: cshort
    undo_char_point* {.importc: "undo_char_point".}: cshort
    redo_char_point* {.importc: "redo_char_point".}: cshort

  text_edit_type* {.size: sizeof(cint).} = enum
    TEXT_EDIT_SINGLE_LINE, TEXT_EDIT_MULTI_LINE

  text_edit_mode* {.size: sizeof(cint).} = enum
    TEXT_EDIT_MODE_VIEW, TEXT_EDIT_MODE_INSERT, TEXT_EDIT_MODE_REPLACE

  text_edit* {.importc: "struct nk_text_edit", header: headernuklear.} = object
    clip* {.importc: "clip".}: clipboard
    string* {.importc: "string".}: str
    filter* {.importc: "filter".}: plugin_filter
    scrollbar* {.importc: "scrollbar".}: vec2
    cursor* {.importc: "cursor".}: cint
    select_start* {.importc: "select_start".}: cint
    select_end* {.importc: "select_end".}: cint
    mode* {.importc: "mode".}: cuchar
    cursor_at_end_of_line* {.importc: "cursor_at_end_of_line".}: cuchar
    initialized* {.importc: "initialized".}: cuchar
    has_preferred_x* {.importc: "has_preferred_x".}: cuchar
    single_line* {.importc: "single_line".}: cuchar
    active* {.importc: "active".}: cuchar
    padding1* {.importc: "padding1".}: cuchar
    preferred_x* {.importc: "preferred_x".}: cfloat
    undo* {.importc: "undo".}: text_undo_state

  plugin_alloc* = proc (a2: handle; old: pointer; a4: size): pointer {.cdecl.}
  plugin_free* = proc (a2: handle; old: pointer)  {.cdecl.}
  plugin_filter* = proc (a2: ptr text_edit; unicode: rune): cint  {.cdecl.}
  plugin_paste* = proc (a2: handle; a3: ptr text_edit)  {.cdecl.}
  plugin_copy* = proc (a2: handle; a3: cstring; len: cint)  {.cdecl.}
  allocator* {.importc: "struct nk_allocator", header: headernuklear.} = object
    userdata* {.importc: "userdata".}: handle
    alloc* {.importc: "alloc".}: plugin_alloc
    free* {.importc: "free".}: plugin_free

  allocation_type* {.size: sizeof(cint).} = enum
    BUFFER_FIXED, BUFFER_DYNAMIC
  buffer* {.importc: "struct nk_buffer", header: headernuklear.} = object
    marker* {.importc: "marker".}: array[BUFFER_MAX, buffer_marker]
    pool* {.importc: "pool".}: allocator
    `type`* {.importc: "type".}: allocation_type
    memory* {.importc: "memory".}: memory
    grow_factor* {.importc: "grow_factor".}: cfloat
    allocated* {.importc: "allocated".}: size
    needed* {.importc: "needed".}: size
    calls* {.importc: "calls".}: size
    size* {.importc: "size".}: size

  command_buffer* {.importc: "struct nk_command_buffer", header: headernuklear.} = object
    base* {.importc: "base".}: ptr buffer
    clip* {.importc: "clip".}: rect
    use_clipping* {.importc: "use_clipping".}: cint
    userdata* {.importc: "userdata".}: handle
    begin* {.importc: "begin".}: size
    `end`* {.importc: "end".}: size
    last* {.importc: "last".}: size
  panel* {.importc: "struct nk_panel", header: headernuklear.} = object
    `type`* {.importc: "type".}: panel_type
    flags* {.importc: "flags".}: flags
    bounds* {.importc: "bounds".}: rect
    offset_x* {.importc: "offset_x".}: ptr uint
    offset_y* {.importc: "offset_y".}: ptr uint
    at_x* {.importc: "at_x".}: cfloat
    at_y* {.importc: "at_y".}: cfloat
    max_x* {.importc: "max_x".}: cfloat
    footer_height* {.importc: "footer_height".}: cfloat
    header_height* {.importc: "header_height".}: cfloat
    border* {.importc: "border".}: cfloat
    has_scrolling* {.importc: "has_scrolling".}: cuint
    clip* {.importc: "clip".}: rect
    menu* {.importc: "menu".}: menu_state
    row* {.importc: "row".}: row_layout
    chart* {.importc: "chart".}: chart
    buffer* {.importc: "buffer".}: ptr command_buffer
    parent* {.importc: "parent".}: ptr panel





  style_item_type* {.size: sizeof(cint).} = enum
    STYLE_ITEM_COLOR, STYLE_ITEM_IMAGE


type
  style_item_data* {.importc: "nk_style_item_data", header: headernuklear.} = object {.
      union.}
    img* {.importc: "image".}: img
    color* {.importc: "color".}: color

  style_item* {.importc: "struct nk_style_item", header: headernuklear.} = object
    `type`* {.importc: "type".}: style_item_type
    data* {.importc: "data".}: style_item_data

  style_text* {.importc: "struct nk_style_text", header: headernuklear.} = object
    color* {.importc: "color".}: color
    padding* {.importc: "padding".}: vec2

  style_button* {.importc: "struct nk_style_button", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    text_background* {.importc: "text_background".}: color
    text_normal* {.importc: "text_normal".}: color
    text_hover* {.importc: "text_hover".}: color
    text_active* {.importc: "text_active".}: color
    text_alignment* {.importc: "text_alignment".}: flags
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    padding* {.importc: "padding".}: vec2
    image_padding* {.importc: "image_padding".}: vec2
    touch_padding* {.importc: "touch_padding".}: vec2
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer;
        userdata: handle) {.cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; userdata: handle) {.
        cdecl.}

  style_toggle* {.importc: "struct nk_style_toggle", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    cursor_normal* {.importc: "cursor_normal".}: style_item
    cursor_hover* {.importc: "cursor_hover".}: style_item
    text_normal* {.importc: "text_normal".}: color
    text_hover* {.importc: "text_hover".}: color
    text_active* {.importc: "text_active".}: color
    text_background* {.importc: "text_background".}: color
    text_alignment* {.importc: "text_alignment".}: flags
    padding* {.importc: "padding".}: vec2
    touch_padding* {.importc: "touch_padding".}: vec2
    spacing* {.importc: "spacing".}: cfloat
    border* {.importc: "border".}: cfloat
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  style_selectable* {.importc: "struct nk_style_selectable", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    pressed* {.importc: "pressed".}: style_item
    normal_active* {.importc: "normal_active".}: style_item
    hover_active* {.importc: "hover_active".}: style_item
    pressed_active* {.importc: "pressed_active".}: style_item
    text_normal* {.importc: "text_normal".}: color
    text_hover* {.importc: "text_hover".}: color
    text_pressed* {.importc: "text_pressed".}: color
    text_normal_active* {.importc: "text_normal_active".}: color
    text_hover_active* {.importc: "text_hover_active".}: color
    text_pressed_active* {.importc: "text_pressed_active".}: color
    text_background* {.importc: "text_background".}: color
    text_alignment* {.importc: "text_alignment".}: flags
    rounding* {.importc: "rounding".}: cfloat
    padding* {.importc: "padding".}: vec2
    touch_padding* {.importc: "touch_padding".}: vec2
    image_padding* {.importc: "image_padding".}: vec2
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  symbol_type* {.size: sizeof(cint).} = enum
    SYMBOL_NONE, SYMBOL_X, SYMBOL_UNDERSCORE, SYMBOL_CIRCLE_SOLID,
    SYMBOL_CIRCLE_OUTLINE, SYMBOL_RECT_SOLID, SYMBOL_RECT_OUTLINE,
    SYMBOL_TRIANGLE_UP, SYMBOL_TRIANGLE_DOWN, SYMBOL_TRIANGLE_LEFT,
    SYMBOL_TRIANGLE_RIGHT, SYMBOL_PLUS, SYMBOL_MINUS, SYMBOL_MAX
  style_slider* {.importc: "struct nk_style_slider", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    bar_normal* {.importc: "bar_normal".}: color
    bar_hover* {.importc: "bar_hover".}: color
    bar_active* {.importc: "bar_active".}: color
    bar_filled* {.importc: "bar_filled".}: color
    cursor_normal* {.importc: "cursor_normal".}: style_item
    cursor_hover* {.importc: "cursor_hover".}: style_item
    cursor_active* {.importc: "cursor_active".}: style_item
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    bar_height* {.importc: "bar_height".}: cfloat
    padding* {.importc: "padding".}: vec2
    spacing* {.importc: "spacing".}: vec2
    cursor_size* {.importc: "cursor_size".}: vec2
    show_buttons* {.importc: "show_buttons".}: cint
    inc_button* {.importc: "inc_button".}: style_button
    dec_button* {.importc: "dec_button".}: style_button
    inc_symbol* {.importc: "inc_symbol".}: symbol_type
    dec_symbol* {.importc: "dec_symbol".}: symbol_type
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  style_progress* {.importc: "struct nk_style_progress", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    cursor_normal* {.importc: "cursor_normal".}: style_item
    cursor_hover* {.importc: "cursor_hover".}: style_item
    cursor_active* {.importc: "cursor_active".}: style_item
    cursor_border_color* {.importc: "cursor_border_color".}: color
    rounding* {.importc: "rounding".}: cfloat
    border* {.importc: "border".}: cfloat
    cursor_border* {.importc: "cursor_border".}: cfloat
    cursor_rounding* {.importc: "cursor_rounding".}: cfloat
    padding* {.importc: "padding".}: vec2
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  style_scrollbar* {.importc: "struct nk_style_scrollbar", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    cursor_normal* {.importc: "cursor_normal".}: style_item
    cursor_hover* {.importc: "cursor_hover".}: style_item
    cursor_active* {.importc: "cursor_active".}: style_item
    cursor_border_color* {.importc: "cursor_border_color".}: color
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    border_cursor* {.importc: "border_cursor".}: cfloat
    rounding_cursor* {.importc: "rounding_cursor".}: cfloat
    padding* {.importc: "padding".}: vec2
    show_buttons* {.importc: "show_buttons".}: cint
    inc_button* {.importc: "inc_button".}: style_button
    dec_button* {.importc: "dec_button".}: style_button
    inc_symbol* {.importc: "inc_symbol".}: symbol_type
    dec_symbol* {.importc: "dec_symbol".}: symbol_type
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  style_edit* {.importc: "struct nk_style_edit", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    scrollbar* {.importc: "scrollbar".}: style_scrollbar
    cursor_normal* {.importc: "cursor_normal".}: color
    cursor_hover* {.importc: "cursor_hover".}: color
    cursor_text_normal* {.importc: "cursor_text_normal".}: color
    cursor_text_hover* {.importc: "cursor_text_hover".}: color
    text_normal* {.importc: "text_normal".}: color
    text_hover* {.importc: "text_hover".}: color
    text_active* {.importc: "text_active".}: color
    selected_normal* {.importc: "selected_normal".}: color
    selected_hover* {.importc: "selected_hover".}: color
    selected_text_normal* {.importc: "selected_text_normal".}: color
    selected_text_hover* {.importc: "selected_text_hover".}: color
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    cursor_size* {.importc: "cursor_size".}: cfloat
    scrollbar_size* {.importc: "scrollbar_size".}: vec2
    padding* {.importc: "padding".}: vec2
    row_padding* {.importc: "row_padding".}: cfloat

  style_property* {.importc: "struct nk_style_property", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    label_normal* {.importc: "label_normal".}: color
    label_hover* {.importc: "label_hover".}: color
    label_active* {.importc: "label_active".}: color
    sym_left* {.importc: "sym_left".}: symbol_type
    sym_right* {.importc: "sym_right".}: symbol_type
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    padding* {.importc: "padding".}: vec2
    edit* {.importc: "edit".}: style_edit
    inc_button* {.importc: "inc_button".}: style_button
    dec_button* {.importc: "dec_button".}: style_button
    userdata* {.importc: "userdata".}: handle
    draw_begin* {.importc: "draw_begin".}: proc (a2: ptr command_buffer; a3: handle) {.
        cdecl.}
    draw_end* {.importc: "draw_end".}: proc (a2: ptr command_buffer; a3: handle) {.cdecl.}

  style_chart* {.importc: "struct nk_style_chart", header: headernuklear.} = object
    background* {.importc: "background".}: style_item
    border_color* {.importc: "border_color".}: color
    selected_color* {.importc: "selected_color".}: color
    color* {.importc: "color".}: color
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    padding* {.importc: "padding".}: vec2

  style_combo* {.importc: "struct nk_style_combo", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    border_color* {.importc: "border_color".}: color
    label_normal* {.importc: "label_normal".}: color
    label_hover* {.importc: "label_hover".}: color
    label_active* {.importc: "label_active".}: color
    symbol_normal* {.importc: "symbol_normal".}: color
    symbol_hover* {.importc: "symbol_hover".}: color
    symbol_active* {.importc: "symbol_active".}: color
    button* {.importc: "button".}: style_button
    sym_normal* {.importc: "sym_normal".}: symbol_type
    sym_hover* {.importc: "sym_hover".}: symbol_type
    sym_active* {.importc: "sym_active".}: symbol_type
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    content_padding* {.importc: "content_padding".}: vec2
    button_padding* {.importc: "button_padding".}: vec2
    spacing* {.importc: "spacing".}: vec2

  style_tab* {.importc: "struct nk_style_tab", header: headernuklear.} = object
    background* {.importc: "background".}: style_item
    border_color* {.importc: "border_color".}: color
    text* {.importc: "text".}: color
    tab_maximize_button* {.importc: "tab_maximize_button".}: style_button
    tab_minimize_button* {.importc: "tab_minimize_button".}: style_button
    node_maximize_button* {.importc: "node_maximize_button".}: style_button
    node_minimize_button* {.importc: "node_minimize_button".}: style_button
    sym_minimize* {.importc: "sym_minimize".}: symbol_type
    sym_maximize* {.importc: "sym_maximize".}: symbol_type
    border* {.importc: "border".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    indent* {.importc: "indent".}: cfloat
    padding* {.importc: "padding".}: vec2
    spacing* {.importc: "spacing".}: vec2

  style_header_align* {.size: sizeof(cint).} = enum
    HEADER_LEFT, HEADER_RIGHT
    
  text_width_f* = proc (a2: handle; h: cfloat; a4: cstring; len: cint): cfloat 
  query_font_glyph_f* = proc (handle: handle; font_height: cfloat;
                           glyph: ptr user_font_glyph; codepoint: rune;
                           next_codepoint: rune) {.cdecl.}
  user_font_glyph* {.importc: "struct nk_user_font_glyph", header: headernuklear.} = object
    uv* {.importc: "uv".}: array[2, vec2]
    offset* {.importc: "offset".}: vec2
    width* {.importc: "width".}: cfloat
    height* {.importc: "height".}: cfloat
    xadvance* {.importc: "xadvance".}: cfloat

  user_font* {.importc: "struct nk_user_font", header: headernuklear.} = object
    userdata* {.importc: "userdata".}: handle
    height* {.importc: "height".}: cfloat
    width* {.importc: "width".}: text_width_f
    query* {.importc: "query".}: query_font_glyph_f
    texture* {.importc: "texture".}: handle

  font_coord_type* {.size: sizeof(cint).} = enum
    COORD_UV, COORD_PIXEL


type
  baked_font* {.importc: "struct nk_baked_font", header: headernuklear.} = object
    height* {.importc: "height".}: cfloat
    ascent* {.importc: "ascent".}: cfloat
    descent* {.importc: "descent".}: cfloat
    glyph_offset* {.importc: "glyph_offset".}: rune
    glyph_count* {.importc: "glyph_count".}: rune
    ranges* {.importc: "ranges".}: ptr rune

  font_config* {.importc: "struct nk_font_config", header: headernuklear.} = object
    next* {.importc: "next".}: ptr font_config
    ttf_blob* {.importc: "ttf_blob".}: pointer
    ttf_size* {.importc: "ttf_size".}: size
    ttf_data_owned_by_atlas* {.importc: "ttf_data_owned_by_atlas".}: cuchar
    merge_mode* {.importc: "merge_mode".}: cuchar
    pixel_snap* {.importc: "pixel_snap".}: cuchar
    oversample_v* {.importc: "oversample_v".}: cuchar
    oversample_h* {.importc: "oversample_h".}: cuchar
    padding* {.importc: "padding".}: array[3, cuchar]
    size* {.importc: "size".}: cfloat
    coord_type* {.importc: "coord_type".}: font_coord_type
    spacing* {.importc: "spacing".}: vec2
    range* {.importc: "range".}: ptr rune
    font* {.importc: "font".}: ptr baked_font
    fallback_glyph* {.importc: "fallback_glyph".}: rune
    n* {.importc: "n".}: ptr font_config
    p* {.importc: "p".}: ptr font_config

  font_glyph* {.importc: "struct nk_font_glyph", header: headernuklear.} = object
    codepoint* {.importc: "codepoint".}: rune
    xadvance* {.importc: "xadvance".}: cfloat
    x0* {.importc: "x0".}: cfloat
    y0* {.importc: "y0".}: cfloat
    x1* {.importc: "x1".}: cfloat
    y1* {.importc: "y1".}: cfloat
    w* {.importc: "w".}: cfloat
    h* {.importc: "h".}: cfloat
    u0* {.importc: "u0".}: cfloat
    v0* {.importc: "v0".}: cfloat
    u1* {.importc: "u1".}: cfloat
    v1* {.importc: "v1".}: cfloat

  font* {.importc: "struct nk_font", header: headernuklear.} = object
    next* {.importc: "next".}: ptr font
    handle* {.importc: "handle".}: user_font
    info* {.importc: "info".}: baked_font
    scale* {.importc: "scale".}: cfloat
    glyphs* {.importc: "glyphs".}: ptr font_glyph
    fallback* {.importc: "fallback".}: ptr font_glyph
    fallback_codepoint* {.importc: "fallback_codepoint".}: rune
    texture* {.importc: "texture".}: handle
    config* {.importc: "config".}: ptr font_config

  font_atlas_format* {.size: sizeof(cint).} = enum
    FONT_ATLAS_ALPHA8, FONT_ATLAS_RGBA32
type
  popup_state* {.importc: "struct nk_popup_state", header: headernuklear.} = object
    win* {.importc: "win".}: ptr window
    `type`* {.importc: "type".}: panel_type
    buf* {.importc: "buf".}: popup_buffer
    name* {.importc: "name".}: hash
    active* {.importc: "active".}: cint
    combo_count* {.importc: "combo_count".}: cuint
    con_count* {.importc: "con_count".}: cuint
    con_old* {.importc: "con_old".}: cuint
    active_con* {.importc: "active_con".}: cuint
    header* {.importc: "header".}: rect

  edit_state* {.importc: "struct nk_edit_state", header: headernuklear.} = object
    name* {.importc: "name".}: hash
    seq* {.importc: "seq".}: cuint
    old* {.importc: "old".}: cuint
    active* {.importc: "active".}: cint
    prev* {.importc: "prev".}: cint
    cursor* {.importc: "cursor".}: cint
    sel_start* {.importc: "sel_start".}: cint
    sel_end* {.importc: "sel_end".}: cint
    scrollbar* {.importc: "scrollbar".}: scroll
    mode* {.importc: "mode".}: cuchar
    single_line* {.importc: "single_line".}: cuchar

  property_state* {.importc: "struct nk_property_state", header: headernuklear.} = object
    active* {.importc: "active".}: cint
    prev* {.importc: "prev".}: cint
    buffer* {.importc: "buffer".}: array[64, char]
    length* {.importc: "length".}: cint
    cursor* {.importc: "cursor".}: cint
    select_start* {.importc: "select_start".}: cint
    select_end* {.importc: "select_end".}: cint
    name* {.importc: "name".}: hash
    seq* {.importc: "seq".}: cuint
    old* {.importc: "old".}: cuint
    state* {.importc: "state".}: cint

  window* {.importc: "struct nk_window", header: headernuklear.} = object
    seq* {.importc: "seq".}: cuint
    name* {.importc: "name".}: hash
    name_string* {.importc: "name_string".}: array[64, char]
    flags* {.importc: "flags".}: flags
    bounds* {.importc: "bounds".}: rect
    scrollbar* {.importc: "scrollbar".}: scroll
    buffer* {.importc: "buffer".}: command_buffer
    layout* {.importc: "layout".}: ptr panel
    scrollbar_hiding_timer* {.importc: "scrollbar_hiding_timer".}: cfloat
    property* {.importc: "property".}: property_state
    popup* {.importc: "popup".}: popup_state
    edit* {.importc: "edit".}: edit_state
    scrolled* {.importc: "scrolled".}: cuint
    tables* {.importc: "tables".}: ptr table
    table_count* {.importc: "table_count".}: cuint
    next* {.importc: "next".}: ptr window
    prev* {.importc: "prev".}: ptr window
    parent* {.importc: "parent".}: ptr window

  config_stack_style_item_element* {.importc: "struct nk_config_stack_style_item_element",
                                    header: headernuklear.} = object
    address* {.importc: "address".}: ptr style_item
    old_value* {.importc: "old_value".}: style_item

  config_stack_float_element* {.importc: "struct nk_config_stack_float_element",
                               header: headernuklear.} = object
    address* {.importc: "address".}: ptr cfloat
    old_value* {.importc: "old_value".}: cfloat

  config_stack_vec2_element* {.importc: "struct nk_config_stack_vec2_element",
                              header: headernuklear.} = object
    address* {.importc: "address".}: ptr vec2
    old_value* {.importc: "old_value".}: vec2

  config_stack_flags_element* {.importc: "struct nk_config_stack_flags_element",
                               header: headernuklear.} = object
    address* {.importc: "address".}: ptr flags
    old_value* {.importc: "old_value".}: flags

  config_stack_color_element* {.importc: "struct nk_config_stack_color_element",
                               header: headernuklear.} = object
    address* {.importc: "address".}: ptr color
    old_value* {.importc: "old_value".}: color

  config_stack_user_font_element* {.importc: "struct nk_config_stack_user_font_element",
                                   header: headernuklear.} = object
    address* {.importc: "address".}: ptr ptr user_font
    old_value* {.importc: "old_value".}: ptr user_font

  config_stack_button_behavior_element* {.
      importc: "struct nk_config_stack_button_behavior_element", header: headernuklear.} = object
    address* {.importc: "address".}: ptr button_behavior
    old_value* {.importc: "old_value".}: button_behavior

  config_stack_style_item* {.importc: "struct nk_config_stack_style_item",
                            header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[16, config_stack_style_item_element]

  config_stack_float* {.importc: "struct nk_config_stack_float", header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[32, config_stack_float_element]

  config_stack_vec2* {.importc: "struct nk_config_stack_vec2", header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[16, config_stack_vec2_element]

  config_stack_flags* {.importc: "struct nk_config_stack_flags", header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[32, config_stack_flags_element]

  config_stack_color* {.importc: "struct nk_config_stack_color", header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[32, config_stack_color_element]

  config_stack_user_font* {.importc: "struct nk_config_stack_user_font",
                           header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[8, config_stack_user_font_element]

  config_stack_button_behavior* {.importc: "struct nk_config_stack_button_behavior",
                                 header: headernuklear.} = object
    head* {.importc: "head".}: cint
    elements* {.importc: "elements".}: array[8, config_stack_button_behavior_element]

  configuration_stacks* {.importc: "struct nk_configuration_stacks", header: headernuklear.} = object
    style_items* {.importc: "style_items".}: config_stack_style_item
    floats* {.importc: "floats".}: config_stack_float
    vectors* {.importc: "vectors".}: config_stack_vec2
    flags* {.importc: "flags".}: config_stack_flags
    colors* {.importc: "colors".}: config_stack_color
    fonts* {.importc: "fonts".}: config_stack_user_font
    button_behaviors* {.importc: "button_behaviors".}: config_stack_button_behavior

  table* {.importc: "struct nk_table", header: headernuklear.} = object
    seq* {.importc: "seq".}: cuint
    size* {.importc: "size".}: cuint
    keys* {.importc: "keys".}: array[find_size(window, panel), uint32]
    values* {.importc: "values".}: array[find_size(window, panel), uint32]
    next* {.importc: "next".}: ptr table
    prev* {.importc: "prev".}: ptr table

  page_data* {.importc: "nk_page_data", header: headernuklear.} = object {.union.}
    tbl* {.importc: "tbl".}: table
    pan* {.importc: "pan".}: panel
    win* {.importc: "win".}: window

  page_element* {.importc: "struct nk_page_element", header: headernuklear.} = object
    data* {.importc: "data".}: page_data
    next* {.importc: "next".}: ptr page_element
    prev* {.importc: "prev".}: ptr page_element

  page* {.importc: "struct nk_page", header: headernuklear.} = object
    size* {.importc: "size".}: cuint
    next* {.importc: "next".}: ptr page
    win* {.importc: "win".}: array[1, page_element]

  pool* {.importc: "struct nk_pool", header: headernuklear.} = object
    alloc* {.importc: "alloc".}: allocator
    `type`* {.importc: "type".}: allocation_type
    page_count* {.importc: "page_count".}: cuint
    pages* {.importc: "pages".}: ptr page
    freelist* {.importc: "freelist".}: ptr page_element
    capacity* {.importc: "capacity".}: cuint
    size* {.importc: "size".}: size
    cap* {.importc: "cap".}: size

  key* {.importc: "struct nk_key", header: headernuklear.} = object
    down* {.importc: "down".}: cint
    clicked* {.importc: "clicked".}: cuint

type
  keys* {.size: sizeof(cint).} = enum
    KEY_NONE, KEY_SHIFT, KEY_CTRL, KEY_DEL, KEY_ENTER, KEY_TAB, KEY_BACKSPACE,
    KEY_COPY, KEY_CUT, KEY_PASTE, KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT,
    KEY_TEXT_INSERT_MODE, KEY_TEXT_REPLACE_MODE, KEY_TEXT_RESET_MODE,
    KEY_TEXT_LINE_START, KEY_TEXT_LINE_END, KEY_TEXT_START, KEY_TEXT_END,
    KEY_TEXT_UNDO, KEY_TEXT_REDO, KEY_TEXT_SELECT_ALL, KEY_TEXT_WORD_LEFT,
    KEY_TEXT_WORD_RIGHT, KEY_SCROLL_START, KEY_SCROLL_END, KEY_SCROLL_DOWN,
    KEY_SCROLL_UP, KEY_MAX

  keyboard* {.importc: "struct nk_keyboard", header: headernuklear.} = object
    keys* {.importc: "keys".}: array[KEY_MAX, key]
    text* {.importc: "text".}: array[16, char]
    text_len* {.importc: "text_len".}: cint

type
  buttons* {.size: sizeof(cint).} = enum
    BUTTON_LEFT, BUTTON_MIDDLE, BUTTON_RIGHT, BUTTON_DOUBLE, BUTTON_MAX

type
  mouse_button* {.importc: "struct nk_mouse_button", header: headernuklear.} = object
    down* {.importc: "down".}: cint
    clicked* {.importc: "clicked".}: cuint
    clicked_pos* {.importc: "clicked_pos".}: vec2

  mouse* {.importc: "struct nk_mouse", header: headernuklear.} = object
    buttons* {.importc: "buttons".}: array[BUTTON_MAX, mouse_button]
    pos* {.importc: "pos".}: vec2
    prev* {.importc: "prev".}: vec2
    delta* {.importc: "delta".}: vec2
    scroll_delta* {.importc: "scroll_delta".}: vec2
    grab* {.importc: "grab".}: cuchar
    grabbed* {.importc: "grabbed".}: cuchar
    ungrab* {.importc: "ungrab".}: cuchar
  input* {.importc: "struct nk_input", header: headernuklear.} = object
    keyboard* {.importc: "keyboard".}: keyboard
    mouse* {.importc: "mouse".}: mouse
type
  style_window_header* {.importc: "struct nk_style_window_header", header: headernuklear.} = object
    normal* {.importc: "normal".}: style_item
    hover* {.importc: "hover".}: style_item
    active* {.importc: "active".}: style_item
    close_button* {.importc: "close_button".}: style_button
    minimize_button* {.importc: "minimize_button".}: style_button
    close_symbol* {.importc: "close_symbol".}: symbol_type
    minimize_symbol* {.importc: "minimize_symbol".}: symbol_type
    maximize_symbol* {.importc: "maximize_symbol".}: symbol_type
    label_normal* {.importc: "label_normal".}: color
    label_hover* {.importc: "label_hover".}: color
    label_active* {.importc: "label_active".}: color
    align* {.importc: "align".}: style_header_align
    padding* {.importc: "padding".}: vec2
    label_padding* {.importc: "label_padding".}: vec2
    spacing* {.importc: "spacing".}: vec2

  style_window* {.importc: "struct nk_style_window", header: headernuklear.} = object
    header* {.importc: "header".}: style_window_header
    fixed_background* {.importc: "fixed_background".}: style_item
    background* {.importc: "background".}: color
    border_color* {.importc: "border_color".}: color
    popup_border_color* {.importc: "popup_border_color".}: color
    combo_border_color* {.importc: "combo_border_color".}: color
    contextual_border_color* {.importc: "contextual_border_color".}: color
    menu_border_color* {.importc: "menu_border_color".}: color
    group_border_color* {.importc: "group_border_color".}: color
    tooltip_border_color* {.importc: "tooltip_border_color".}: color
    scaler* {.importc: "scaler".}: style_item
    border* {.importc: "border".}: cfloat
    combo_border* {.importc: "combo_border".}: cfloat
    contextual_border* {.importc: "contextual_border".}: cfloat
    menu_border* {.importc: "menu_border".}: cfloat
    group_border* {.importc: "group_border".}: cfloat
    tooltip_border* {.importc: "tooltip_border".}: cfloat
    popup_border* {.importc: "popup_border".}: cfloat
    min_row_height_padding* {.importc: "min_row_height_padding".}: cfloat
    rounding* {.importc: "rounding".}: cfloat
    spacing* {.importc: "spacing".}: vec2
    scrollbar_size* {.importc: "scrollbar_size".}: vec2
    min_size* {.importc: "min_size".}: vec2
    padding* {.importc: "padding".}: vec2
    group_padding* {.importc: "group_padding".}: vec2
    popup_padding* {.importc: "popup_padding".}: vec2
    combo_padding* {.importc: "combo_padding".}: vec2
    contextual_padding* {.importc: "contextual_padding".}: vec2
    menu_padding* {.importc: "menu_padding".}: vec2
    tooltip_padding* {.importc: "tooltip_padding".}: vec2



  style_cursor* {.size: sizeof(cint).} = enum
    CURSOR_ARROW, CURSOR_TEXT, CURSOR_MOVE, CURSOR_RESIZE_VERTICAL,
    CURSOR_RESIZE_HORIZONTAL, CURSOR_RESIZE_TOP_LEFT_DOWN_RIGHT,
    CURSOR_RESIZE_TOP_RIGHT_DOWN_LEFT, CURSOR_COUNT

  style* {.importc: "struct nk_style", header: headernuklear.} = object
    font* {.importc: "font".}: ptr user_font
    cursors* {.importc: "cursors".}: array[CURSOR_COUNT, ptr cursor]
    cursor_active* {.importc: "cursor_active".}: ptr cursor
    cursor_last* {.importc: "cursor_last".}: ptr cursor
    cursor_visible* {.importc: "cursor_visible".}: cint
    text* {.importc: "text".}: style_text
    button* {.importc: "button".}: style_button
    contextual_button* {.importc: "contextual_button".}: style_button
    menu_button* {.importc: "menu_button".}: style_button
    option* {.importc: "option".}: style_toggle
    checkbox* {.importc: "checkbox".}: style_toggle
    selectable* {.importc: "selectable".}: style_selectable
    slider* {.importc: "slider".}: style_slider
    progress* {.importc: "progress".}: style_progress
    property* {.importc: "property".}: style_property
    edit* {.importc: "edit".}: style_edit
    chart* {.importc: "chart".}: style_chart
    scrollh* {.importc: "scrollh".}: style_scrollbar
    scrollv* {.importc: "scrollv".}: style_scrollbar
    tab* {.importc: "tab".}: style_tab
    combo* {.importc: "combo".}: style_combo
    window* {.importc: "window".}: style_window

  draw_null_texture* {.importc: "struct nk_draw_null_texture", header: headernuklear.} = object
    texture* {.importc: "texture".}: handle
    uv* {.importc: "uv".}: vec2

  anti_aliasing* {.size: sizeof(cint).} = enum
    ANTI_ALIASING_OFF, ANTI_ALIASING_ON

  draw_vertex_layout_attribute* {.size: sizeof(cint).} = enum
    VERTEX_POSITION, VERTEX_COLOR, VERTEX_TEXCOORD, VERTEX_ATTRIBUTE_COUNT

  draw_vertex_layout_format* {.size: sizeof(cint).} = enum
    FORMAT_SCHAR, FORMAT_SSHORT, FORMAT_SINT, FORMAT_UCHAR, FORMAT_USHORT,
    FORMAT_UINT, FORMAT_FLOAT, FORMAT_DOUBLE, FORMAT_COLOR_BEGIN, FORMAT_R16G15B16,
    FORMAT_R32G32B32, FORMAT_R8G8B8A8, FORMAT_B8G8R8A8, FORMAT_R16G15B16A16,
    FORMAT_R32G32B32A32, FORMAT_R32G32B32A32_FLOAT, FORMAT_R32G32B32A32_DOUBLE,
    FORMAT_RGB32, FORMAT_RGBA32, FORMAT_COUNT

  draw_vertex_layout_element* {.importc: "struct nk_draw_vertex_layout_element",
                               header: headernuklear.} = object
    attribute* {.importc: "attribute".}: draw_vertex_layout_attribute
    format* {.importc: "format".}: draw_vertex_layout_format
    offset* {.importc: "offset".}: size

  draw_command* {.importc: "struct nk_draw_command", header: headernuklear.} = object
    elem_count* {.importc: "elem_count".}: cuint
    clip_rect* {.importc: "clip_rect".}: rect
    texture* {.importc: "texture".}: handle
  convert_config* {.importc: "struct nk_convert_config", header: headernuklear.} = object
    global_alpha* {.importc: "global_alpha".}: cfloat
    line_AA* {.importc: "line_AA".}: anti_aliasing
    shape_AA* {.importc: "shape_AA".}: anti_aliasing
    circle_segment_count* {.importc: "circle_segment_count".}: cuint
    arc_segment_count* {.importc: "arc_segment_count".}: cuint
    curve_segment_count* {.importc: "curve_segment_count".}: cuint
    null* {.importc: "null".}: draw_null_texture
    vertex_layout* {.importc: "vertex_layout".}: ptr draw_vertex_layout_element
    vertex_size* {.importc: "vertex_size".}: size
    vertex_alignment* {.importc: "vertex_alignment".}: size

  draw_list* {.importc: "struct nk_draw_list", header: headernuklear.} = object
    clip_rect* {.importc: "clip_rect".}: rect
    circle_vtx* {.importc: "circle_vtx".}: array[12, vec2]
    config* {.importc: "config".}: convert_config
    buffer* {.importc: "buffer".}: ptr buffer
    vertices* {.importc: "vertices".}: ptr buffer
    elements* {.importc: "elements".}: ptr buffer
    element_count* {.importc: "element_count".}: cuint
    vertex_count* {.importc: "vertex_count".}: cuint
    cmd_count* {.importc: "cmd_count".}: cuint
    cmd_offset* {.importc: "cmd_offset".}: size
    path_count* {.importc: "path_count".}: cuint
    path_offset* {.importc: "path_offset".}: cuint
    line_AA* {.importc: "line_AA".}: anti_aliasing
    shape_AA* {.importc: "shape_AA".}: anti_aliasing

  context* {.importc: "struct nk_context", header: headernuklear.} = object
    input* {.importc: "input".}: input
    style* {.importc: "style".}: style
    memory* {.importc: "memory".}: buffer
    clip* {.importc: "clip".}: clipboard
    last_widget_state* {.importc: "last_widget_state".}: flags
    button_behavior* {.importc: "button_behavior".}: button_behavior
    stacks* {.importc: "stacks".}: configuration_stacks
    delta_time_seconds* {.importc: "delta_time_seconds".}: cfloat
    draw_list* {.importc: "draw_list".}: draw_list
    text_edit* {.importc: "text_edit".}: text_edit
    overlay* {.importc: "overlay".}: command_buffer
    build* {.importc: "build".}: cint
    use_pool* {.importc: "use_pool".}: cint
    pool* {.importc: "pool".}: pool
    begin* {.importc: "begin".}: ptr window
    `end`* {.importc: "end".}: ptr window
    active* {.importc: "active".}: ptr window
    current* {.importc: "current".}: ptr window
    freelist* {.importc: "freelist".}: ptr page_element
    count* {.importc: "count".}: cuint
    seq* {.importc: "seq".}: cuint




proc init_default*(a2: ptr context; a3: ptr user_font): cint {.cdecl,
    importc: "nk_init_default", header: headernuklear.}
proc init_fixed*(a2: ptr context; memory: pointer; size: size; a5: ptr user_font): cint {.
    cdecl, importc: "nk_init_fixed", header: headernuklear.}
proc init*(a2: ptr context; a3: ptr allocator; a4: ptr user_font): cint {.cdecl,
    importc: "nk_init", header: headernuklear.}
proc init_custom*(a2: ptr context; cmds: ptr buffer; pool: ptr buffer; a5: ptr user_font): cint {.
    cdecl, importc: "nk_init_custom", header: headernuklear.}
proc clear*(a2: ptr context) {.cdecl, importc: "nk_clear", header: headernuklear.}
proc free*(a2: ptr context) {.cdecl, importc: "nk_free", header: headernuklear.}





proc input_begin*(a2: ptr context) {.cdecl, importc: "nk_input_begin",
                                 header: headernuklear.}
proc input_motion*(a2: ptr context; x: cint; y: cint) {.cdecl,
    importc: "nk_input_motion", header: headernuklear.}
proc input_key*(a2: ptr context; a3: keys; down: cint) {.cdecl, importc: "nk_input_key",
    header: headernuklear.}
proc input_button*(a2: ptr context; a3: buttons; x: cint; y: cint; down: cint) {.cdecl,
    importc: "nk_input_button", header: headernuklear.}
proc input_scroll*(a2: ptr context; val: vec2) {.cdecl, importc: "nk_input_scroll",
    header: headernuklear.}
proc input_char*(a2: ptr context; a3: char) {.cdecl, importc: "nk_input_char",
                                        header: headernuklear.}
proc input_glyph*(a2: ptr context; a3: glyph) {.cdecl, importc: "nk_input_glyph",
    header: headernuklear.}
proc input_unicode*(a2: ptr context; a3: rune) {.cdecl, importc: "nk_input_unicode",
    header: headernuklear.}
proc input_end*(a2: ptr context) {.cdecl, importc: "nk_input_end",
                               header: headernuklear.}
type
  convert_result* {.size: sizeof(cint).} = enum
    CONVERT_SUCCESS = 0, CONVERT_INVALID_PARAM = 1,
    CONVERT_COMMAND_BUFFER_FULL = (1 shl (1)),
    CONVERT_VERTEX_BUFFER_FULL = (1 shl (2)),
    CONVERT_ELEMENT_BUFFER_FULL = (1 shl (3))

type
  command_type* {.size: sizeof(cint).} = enum
    COMMAND_NOP, COMMAND_SCISSOR, COMMAND_LINE, COMMAND_CURVE, COMMAND_RECT,
    COMMAND_RECT_FILLED, COMMAND_RECT_MULTI_COLOR, COMMAND_CIRCLE,
    COMMAND_CIRCLE_FILLED, COMMAND_ARC, COMMAND_ARC_FILLED, COMMAND_TRIANGLE,
    COMMAND_TRIANGLE_FILLED, COMMAND_POLYGON, COMMAND_POLYGON_FILLED,
    COMMAND_POLYLINE, COMMAND_TEXT, COMMAND_IMAGE, COMMAND_CUSTOM

  command* {.importc: "struct nk_command", header: headernuklear.} = object
    `type`* {.importc: "type".}: command_type
    next* {.importc: "next".}: size

  command_scissor* {.importc: "struct nk_command_scissor", header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort

  command_line* {.importc: "struct nk_command_line", header: headernuklear.} = object
    header* {.importc: "header".}: command
    line_thickness* {.importc: "line_thickness".}: cushort
    begin* {.importc: "begin".}: vec2i
    `end`* {.importc: "end".}: vec2i
    color* {.importc: "color".}: color

  command_curve* {.importc: "struct nk_command_curve", header: headernuklear.} = object
    header* {.importc: "header".}: command
    line_thickness* {.importc: "line_thickness".}: cushort
    begin* {.importc: "begin".}: vec2i
    `end`* {.importc: "end".}: vec2i
    ctrl* {.importc: "ctrl".}: array[2, vec2i]
    color* {.importc: "color".}: color

  command_rect* {.importc: "struct nk_command_rect", header: headernuklear.} = object
    header* {.importc: "header".}: command
    rounding* {.importc: "rounding".}: cushort
    line_thickness* {.importc: "line_thickness".}: cushort
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    color* {.importc: "color".}: color

  command_rect_filled* {.importc: "struct nk_command_rect_filled", header: headernuklear.} = object
    header* {.importc: "header".}: command
    rounding* {.importc: "rounding".}: cushort
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    color* {.importc: "color".}: color

  command_rect_multi_color* {.importc: "struct nk_command_rect_multi_color",
                             header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    left* {.importc: "left".}: color
    top* {.importc: "top".}: color
    bottom* {.importc: "bottom".}: color
    right* {.importc: "right".}: color

  command_triangle* {.importc: "struct nk_command_triangle", header: headernuklear.} = object
    header* {.importc: "header".}: command
    line_thickness* {.importc: "line_thickness".}: cushort
    a* {.importc: "a".}: vec2i
    b* {.importc: "b".}: vec2i
    c* {.importc: "c".}: vec2i
    color* {.importc: "color".}: color

  command_triangle_filled* {.importc: "struct nk_command_triangle_filled",
                            header: headernuklear.} = object
    header* {.importc: "header".}: command
    a* {.importc: "a".}: vec2i
    b* {.importc: "b".}: vec2i
    c* {.importc: "c".}: vec2i
    color* {.importc: "color".}: color

  command_circle* {.importc: "struct nk_command_circle", header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    line_thickness* {.importc: "line_thickness".}: cushort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    color* {.importc: "color".}: color

  command_circle_filled* {.importc: "struct nk_command_circle_filled",
                          header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    color* {.importc: "color".}: color

  command_arc* {.importc: "struct nk_command_arc", header: headernuklear.} = object
    header* {.importc: "header".}: command
    cx* {.importc: "cx".}: cshort
    cy* {.importc: "cy".}: cshort
    r* {.importc: "r".}: cushort
    line_thickness* {.importc: "line_thickness".}: cushort
    a* {.importc: "a".}: array[2, cfloat]
    color* {.importc: "color".}: color

  command_arc_filled* {.importc: "struct nk_command_arc_filled", header: headernuklear.} = object
    header* {.importc: "header".}: command
    cx* {.importc: "cx".}: cshort
    cy* {.importc: "cy".}: cshort
    r* {.importc: "r".}: cushort
    a* {.importc: "a".}: array[2, cfloat]
    color* {.importc: "color".}: color

  command_polygon* {.importc: "struct nk_command_polygon", header: headernuklear.} = object
    header* {.importc: "header".}: command
    color* {.importc: "color".}: color
    line_thickness* {.importc: "line_thickness".}: cushort
    point_count* {.importc: "point_count".}: cushort
    points* {.importc: "points".}: array[1, vec2i]

  command_polygon_filled* {.importc: "struct nk_command_polygon_filled",
                           header: headernuklear.} = object
    header* {.importc: "header".}: command
    color* {.importc: "color".}: color
    point_count* {.importc: "point_count".}: cushort
    points* {.importc: "points".}: array[1, vec2i]

  command_polyline* {.importc: "struct nk_command_polyline", header: headernuklear.} = object
    header* {.importc: "header".}: command
    color* {.importc: "color".}: color
    line_thickness* {.importc: "line_thickness".}: cushort
    point_count* {.importc: "point_count".}: cushort
    points* {.importc: "points".}: array[1, vec2i]

  command_image* {.importc: "struct nk_command_image", header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    img* {.importc: "img".}: img
    col* {.importc: "col".}: color

  command_custom_callback* = proc (canvas: pointer; x: cshort; y: cshort; w: cushort;
                                h: cushort; callback_data: handle) {.cdecl.}
  command_custom* {.importc: "struct nk_command_custom", header: headernuklear.} = object
    header* {.importc: "header".}: command
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    callback_data* {.importc: "callback_data".}: handle
    callback* {.importc: "callback".}: command_custom_callback

  command_text* {.importc: "struct nk_command_text", header: headernuklear.} = object
    header* {.importc: "header".}: command
    font* {.importc: "font".}: ptr user_font
    background* {.importc: "background".}: color
    foreground* {.importc: "foreground".}: color
    x* {.importc: "x".}: cshort
    y* {.importc: "y".}: cshort
    w* {.importc: "w".}: cushort
    h* {.importc: "h".}: cushort
    height* {.importc: "height".}: cfloat
    length* {.importc: "length".}: cint
    string* {.importc: "string".}: array[1, char]

  command_clipping* {.size: sizeof(cint).} = enum
    CLIPPING_OFF = false, CLIPPING_ON = true
proc begin*(a2: ptr context): ptr command {.cdecl, importc: "nk__begin",
                                      header: headernuklear.}
proc next*(a2: ptr context; a3: ptr command): ptr command {.cdecl, importc: "nk__next",
    header: headernuklear.}
proc convert*(a2: ptr context; cmds: ptr buffer; vertices: ptr buffer;
             elements: ptr buffer; a6: ptr convert_config): flags {.cdecl,
    importc: "nk_convert", header: headernuklear.}
proc draw_begin*(a2: ptr context; a3: ptr buffer): ptr draw_command {.cdecl,
    importc: "nk__draw_begin", header: headernuklear.}
proc draw_end*(a2: ptr context; a3: ptr buffer): ptr draw_command {.cdecl,
    importc: "nk__draw_end", header: headernuklear.}
proc draw_next*(a2: ptr draw_command; a3: ptr buffer; a4: ptr context): ptr draw_command {.
    cdecl, importc: "nk__draw_next", header: headernuklear.}



proc begin*(ctx: ptr context; title: cstring; bounds: rect; flags: flags): cint {.cdecl,
    importc: "nk_begin", header: headernuklear.}
proc begin_titled*(ctx: ptr context; name: cstring; title: cstring; bounds: rect;
                  flags: flags): cint {.cdecl, importc: "nk_begin_titled",
                                     header: headernuklear.}
proc `end`*(ctx: ptr context) {.cdecl, importc: "nk_end", header: headernuklear.}
proc window_find*(ctx: ptr context; name: cstring): ptr window {.cdecl,
    importc: "nk_window_find", header: headernuklear.}
proc window_get_bounds*(ctx: ptr context): rect {.cdecl,
    importc: "nk_window_get_bounds", header: headernuklear.}
proc window_get_position*(ctx: ptr context): vec2 {.cdecl,
    importc: "nk_window_get_position", header: headernuklear.}
proc window_get_size*(a2: ptr context): vec2 {.cdecl, importc: "nk_window_get_size",
    header: headernuklear.}
proc window_get_width*(a2: ptr context): cfloat {.cdecl,
    importc: "nk_window_get_width", header: headernuklear.}
proc window_get_height*(a2: ptr context): cfloat {.cdecl,
    importc: "nk_window_get_height", header: headernuklear.}
proc window_get_panel*(a2: ptr context): ptr panel {.cdecl,
    importc: "nk_window_get_panel", header: headernuklear.}
proc window_get_content_region*(a2: ptr context): rect {.cdecl,
    importc: "nk_window_get_content_region", header: headernuklear.}
proc window_get_content_region_min*(a2: ptr context): vec2 {.cdecl,
    importc: "nk_window_get_content_region_min", header: headernuklear.}
proc window_get_content_region_max*(a2: ptr context): vec2 {.cdecl,
    importc: "nk_window_get_content_region_max", header: headernuklear.}
proc window_get_content_region_size*(a2: ptr context): vec2 {.cdecl,
    importc: "nk_window_get_content_region_size", header: headernuklear.}
proc window_get_canvas*(a2: ptr context): ptr command_buffer {.cdecl,
    importc: "nk_window_get_canvas", header: headernuklear.}
proc window_has_focus*(a2: ptr context): cint {.cdecl, importc: "nk_window_has_focus",
    header: headernuklear.}
proc window_is_hovered*(a2: ptr context): cint {.cdecl,
    importc: "nk_window_is_hovered", header: headernuklear.}
proc window_is_collapsed*(ctx: ptr context; name: cstring): cint {.cdecl,
    importc: "nk_window_is_collapsed", header: headernuklear.}
proc window_is_closed*(a2: ptr context; a3: cstring): cint {.cdecl,
    importc: "nk_window_is_closed", header: headernuklear.}
proc window_is_hidden*(a2: ptr context; a3: cstring): cint {.cdecl,
    importc: "nk_window_is_hidden", header: headernuklear.}
proc window_is_active*(a2: ptr context; a3: cstring): cint {.cdecl,
    importc: "nk_window_is_active", header: headernuklear.}
proc window_is_any_hovered*(a2: ptr context): cint {.cdecl,
    importc: "nk_window_is_any_hovered", header: headernuklear.}
proc item_is_any_active*(a2: ptr context): cint {.cdecl,
    importc: "nk_item_is_any_active", header: headernuklear.}
proc window_set_bounds*(a2: ptr context; name: cstring; bounds: rect) {.cdecl,
    importc: "nk_window_set_bounds", header: headernuklear.}
proc window_set_position*(a2: ptr context; name: cstring; pos: vec2) {.cdecl,
    importc: "nk_window_set_position", header: headernuklear.}
proc window_set_size*(a2: ptr context; name: cstring; a4: vec2) {.cdecl,
    importc: "nk_window_set_size", header: headernuklear.}
proc window_set_focus*(a2: ptr context; name: cstring) {.cdecl,
    importc: "nk_window_set_focus", header: headernuklear.}
proc window_close*(ctx: ptr context; name: cstring) {.cdecl,
    importc: "nk_window_close", header: headernuklear.}
proc window_collapse*(a2: ptr context; name: cstring; state: collapse_states) {.cdecl,
    importc: "nk_window_collapse", header: headernuklear.}
proc window_collapse_if*(a2: ptr context; name: cstring; a4: collapse_states; cond: cint) {.
    cdecl, importc: "nk_window_collapse_if", header: headernuklear.}
proc window_show*(a2: ptr context; name: cstring; a4: show_states) {.cdecl,
    importc: "nk_window_show", header: headernuklear.}
proc window_show_if*(a2: ptr context; name: cstring; a4: show_states; cond: cint) {.cdecl,
    importc: "nk_window_show_if", header: headernuklear.}
proc layout_set_min_row_height*(a2: ptr context; height: cfloat) {.cdecl,
    importc: "nk_layout_set_min_row_height", header: headernuklear.}
proc layout_reset_min_row_height*(a2: ptr context) {.cdecl,
    importc: "nk_layout_reset_min_row_height", header: headernuklear.}
proc layout_widget_bounds*(a2: ptr context): rect {.cdecl,
    importc: "nk_layout_widget_bounds", header: headernuklear.}
proc layout_ratio_from_pixel*(a2: ptr context; pixel_width: cfloat): cfloat {.cdecl,
    importc: "nk_layout_ratio_from_pixel", header: headernuklear.}
proc layout_row_dynamic*(ctx: ptr context; height: cfloat; cols: cint) {.cdecl,
    importc: "nk_layout_row_dynamic", header: headernuklear.}
proc layout_row_static*(ctx: ptr context; height: cfloat; item_width: cint; cols: cint) {.
    cdecl, importc: "nk_layout_row_static", header: headernuklear.}
proc layout_row_begin*(ctx: ptr context; fmt: layout_format; row_height: cfloat;
                      cols: cint) {.cdecl, importc: "nk_layout_row_begin",
                                  header: headernuklear.}
proc layout_row_push*(a2: ptr context; value: cfloat) {.cdecl,
    importc: "nk_layout_row_push", header: headernuklear.}
proc layout_row_end*(a2: ptr context) {.cdecl, importc: "nk_layout_row_end",
                                    header: headernuklear.}
proc layout_row*(a2: ptr context; a3: layout_format; height: cfloat; cols: cint;
                ratio: ptr cfloat) {.cdecl, importc: "nk_layout_row",
                                  header: headernuklear.}
proc layout_row_template_begin*(a2: ptr context; row_height: cfloat) {.cdecl,
    importc: "nk_layout_row_template_begin", header: headernuklear.}
proc layout_row_template_push_dynamic*(a2: ptr context) {.cdecl,
    importc: "nk_layout_row_template_push_dynamic", header: headernuklear.}
proc layout_row_template_push_variable*(a2: ptr context; min_width: cfloat) {.cdecl,
    importc: "nk_layout_row_template_push_variable", header: headernuklear.}
proc layout_row_template_push_static*(a2: ptr context; width: cfloat) {.cdecl,
    importc: "nk_layout_row_template_push_static", header: headernuklear.}
proc layout_row_template_end*(a2: ptr context) {.cdecl,
    importc: "nk_layout_row_template_end", header: headernuklear.}
proc layout_space_begin*(a2: ptr context; a3: layout_format; height: cfloat;
                        widget_count: cint) {.cdecl,
    importc: "nk_layout_space_begin", header: headernuklear.}
proc layout_space_push*(a2: ptr context; bounds: rect) {.cdecl,
    importc: "nk_layout_space_push", header: headernuklear.}
proc layout_space_end*(a2: ptr context) {.cdecl, importc: "nk_layout_space_end",
                                      header: headernuklear.}
proc layout_space_bounds*(a2: ptr context): rect {.cdecl,
    importc: "nk_layout_space_bounds", header: headernuklear.}
proc layout_space_to_screen*(a2: ptr context; a3: vec2): vec2 {.cdecl,
    importc: "nk_layout_space_to_screen", header: headernuklear.}
proc layout_space_to_local*(a2: ptr context; a3: vec2): vec2 {.cdecl,
    importc: "nk_layout_space_to_local", header: headernuklear.}
proc layout_space_rect_to_screen*(a2: ptr context; a3: rect): rect {.cdecl,
    importc: "nk_layout_space_rect_to_screen", header: headernuklear.}
proc layout_space_rect_to_local*(a2: ptr context; a3: rect): rect {.cdecl,
    importc: "nk_layout_space_rect_to_local", header: headernuklear.}
proc group_begin*(a2: ptr context; title: cstring; a4: flags): cint {.cdecl,
    importc: "nk_group_begin", header: headernuklear.}
proc group_begin_titled*(a2: ptr context; name: cstring; title: cstring; a5: flags): cint {.
    cdecl, importc: "nk_group_begin_titled", header: headernuklear.}
proc group_end*(a2: ptr context) {.cdecl, importc: "nk_group_end",
                               header: headernuklear.}
proc group_scrolled_offset_begin*(a2: ptr context; x_offset: ptr uint;
                                 y_offset: ptr uint; title: cstring; flags: flags): cint {.
    cdecl, importc: "nk_group_scrolled_offset_begin", header: headernuklear.}
proc group_scrolled_begin*(a2: ptr context; off: ptr scroll; title: cstring; a5: flags): cint {.
    cdecl, importc: "nk_group_scrolled_begin", header: headernuklear.}
proc group_scrolled_end*(a2: ptr context) {.cdecl, importc: "nk_group_scrolled_end",
                                        header: headernuklear.}
proc tree_push_hashed*(a2: ptr context; a3: tree_type; title: cstring;
                      initial_state: collapse_states; hash: cstring; len: cint;
                      seed: cint): cint {.cdecl, importc: "nk_tree_push_hashed",
                                       header: headernuklear.}
proc tree_image_push_hashed*(a2: ptr context; a3: tree_type; a4: img; title: cstring;
                            initial_state: collapse_states; hash: cstring;
                            len: cint; seed: cint): cint {.cdecl,
    importc: "nk_tree_image_push_hashed", header: headernuklear.}
proc tree_pop*(a2: ptr context) {.cdecl, importc: "nk_tree_pop", header: headernuklear.}
proc tree_state_push*(a2: ptr context; a3: tree_type; title: cstring;
                     state: ptr collapse_states): cint {.cdecl,
    importc: "nk_tree_state_push", header: headernuklear.}
proc tree_state_image_push*(a2: ptr context; a3: tree_type; a4: img; title: cstring;
                           state: ptr collapse_states): cint {.cdecl,
    importc: "nk_tree_state_image_push", header: headernuklear.}
proc tree_state_pop*(a2: ptr context) {.cdecl, importc: "nk_tree_state_pop",
                                    header: headernuklear.}
proc tree_element_push_hashed*(a2: ptr context; a3: tree_type; title: cstring;
                              initial_state: collapse_states; selected: ptr cint;
                              hash: cstring; len: cint; seed: cint): cint {.cdecl,
    importc: "nk_tree_element_push_hashed", header: headernuklear.}
proc tree_element_image_push_hashed*(a2: ptr context; a3: tree_type; a4: img;
                                    title: cstring;
                                    initial_state: collapse_states;
                                    selected: ptr cint; hash: cstring; len: cint;
                                    seed: cint): cint {.cdecl,
    importc: "nk_tree_element_image_push_hashed", header: headernuklear.}
proc tree_element_pop*(a2: ptr context) {.cdecl, importc: "nk_tree_element_pop",
                                      header: headernuklear.}
type
  list_view* {.importc: "struct nk_list_view", header: headernuklear.} = object
    begin* {.importc: "begin".}: cint
    `end`* {.importc: "end".}: cint
    count* {.importc: "count".}: cint
    total_height* {.importc: "total_height".}: cint
    ctx* {.importc: "ctx".}: ptr context
    scroll_pointer* {.importc: "scroll_pointer".}: ptr uint
    scroll_value* {.importc: "scroll_value".}: uint


proc list_view_begin*(a2: ptr context; `out`: ptr list_view; id: cstring; a5: flags;
                     row_height: cint; row_count: cint): cint {.cdecl,
    importc: "nk_list_view_begin", header: headernuklear.}
proc list_view_end*(a2: ptr list_view) {.cdecl, importc: "nk_list_view_end",
                                     header: headernuklear.}
type
  widget_layout_states* {.size: sizeof(cint).} = enum
    WIDGET_INVALID, WIDGET_VALID, WIDGET_ROM


type
  widget_states* {.size: sizeof(cint).} = enum
    WIDGET_STATE_MODIFIED = (1 shl (1)), WIDGET_STATE_INACTIVE = (1 shl (2)),
    WIDGET_STATE_ENTERED = (1 shl (3)), WIDGET_STATE_HOVER = (1 shl (4)),
    WIDGET_STATE_ACTIVED = (1 shl (5)), WIDGET_STATE_LEFT = (1 shl (6)),




proc widget*(a2: ptr rect; a3: ptr context): widget_layout_states {.cdecl,
    importc: "nk_widget", header: headernuklear.}
proc widget_fitting*(a2: ptr rect; a3: ptr context; a4: vec2): widget_layout_states {.
    cdecl, importc: "nk_widget_fitting", header: headernuklear.}
proc widget_bounds*(a2: ptr context): rect {.cdecl, importc: "nk_widget_bounds",
                                        header: headernuklear.}
proc widget_position*(a2: ptr context): vec2 {.cdecl, importc: "nk_widget_position",
    header: headernuklear.}
proc widget_size*(a2: ptr context): vec2 {.cdecl, importc: "nk_widget_size",
                                      header: headernuklear.}
proc widget_width*(a2: ptr context): cfloat {.cdecl, importc: "nk_widget_width",
    header: headernuklear.}
proc widget_height*(a2: ptr context): cfloat {.cdecl, importc: "nk_widget_height",
    header: headernuklear.}
proc widget_is_hovered*(a2: ptr context): cint {.cdecl,
    importc: "nk_widget_is_hovered", header: headernuklear.}
proc widget_is_mouse_clicked*(a2: ptr context; a3: buttons): cint {.cdecl,
    importc: "nk_widget_is_mouse_clicked", header: headernuklear.}
proc widget_has_mouse_click_down*(a2: ptr context; a3: buttons; down: cint): cint {.
    cdecl, importc: "nk_widget_has_mouse_click_down", header: headernuklear.}
proc spacing*(a2: ptr context; cols: cint) {.cdecl, importc: "nk_spacing",
                                       header: headernuklear.}
type
  text_align* {.size: sizeof(cint).} = enum
    TEXT_ALIGN_LEFT = 0x00000001, TEXT_ALIGN_CENTERED = 0x00000002,
    TEXT_ALIGN_RIGHT = 0x00000004, TEXT_ALIGN_TOP = 0x00000008,
    TEXT_ALIGN_MIDDLE = 0x00000010, TEXT_ALIGN_BOTTOM = 0x00000020


type
  text_alignment* {.size: sizeof(cint).} = enum
    TEXT_LEFT = TEXT_ALIGN_MIDDLE.int32 or TEXT_ALIGN_LEFT.int32
    TEXT_CENTERED = TEXT_ALIGN_MIDDLE.int32 or TEXT_ALIGN_CENTERED.int32
    TEXT_RIGHT = TEXT_ALIGN_MIDDLE.int32 or TEXT_ALIGN_RIGHT.int32


proc text*(a2: ptr context; a3: cstring; a4: cint; a5: flags) {.cdecl, importc: "nk_text",
    header: headernuklear.}
proc text_colored*(a2: ptr context; a3: cstring; a4: cint; a5: flags; a6: color) {.cdecl,
    importc: "nk_text_colored", header: headernuklear.}
proc text_wrap*(a2: ptr context; a3: cstring; a4: cint) {.cdecl, importc: "nk_text_wrap",
    header: headernuklear.}
proc text_wrap_colored*(a2: ptr context; a3: cstring; a4: cint; a5: color) {.cdecl,
    importc: "nk_text_wrap_colored", header: headernuklear.}
proc label*(a2: ptr context; a3: cstring; align: flags) {.cdecl, importc: "nk_label",
    header: headernuklear.}
proc label_colored*(a2: ptr context; a3: cstring; align: flags; a5: color) {.cdecl,
    importc: "nk_label_colored", header: headernuklear.}
proc label_wrap*(a2: ptr context; a3: cstring) {.cdecl, importc: "nk_label_wrap",
    header: headernuklear.}
proc label_colored_wrap*(a2: ptr context; a3: cstring; a4: color) {.cdecl,
    importc: "nk_label_colored_wrap", header: headernuklear.}
proc image*(a2: ptr context; a3: img) {.cdecl, importc: "struct nk_image",
                                    header: headernuklear.}
proc image_color*(a2: ptr context; a3: img; a4: color) {.cdecl,
    importc: "nk_image_color", header: headernuklear.}
proc button_text*(a2: ptr context; title: cstring; len: cint): cint {.cdecl,
    importc: "nk_button_text", header: headernuklear.}
proc button_label*(a2: ptr context; title: cstring): cint {.cdecl,
    importc: "nk_button_label", header: headernuklear.}
proc button_color*(a2: ptr context; a3: color): cint {.cdecl,
    importc: "nk_button_color", header: headernuklear.}
proc button_symbol*(a2: ptr context; a3: symbol_type): cint {.cdecl,
    importc: "nk_button_symbol", header: headernuklear.}
proc button_image*(a2: ptr context; img: img): cint {.cdecl,
    importc: "nk_button_image", header: headernuklear.}
proc button_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring;
                         text_alignment: flags): cint {.cdecl,
    importc: "nk_button_symbol_label", header: headernuklear.}
proc button_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring; a5: cint;
                        alignment: flags): cint {.cdecl,
    importc: "nk_button_symbol_text", header: headernuklear.}
proc button_image_label*(a2: ptr context; img: img; a4: cstring; text_alignment: flags): cint {.
    cdecl, importc: "nk_button_image_label", header: headernuklear.}
proc button_image_text*(a2: ptr context; img: img; a4: cstring; a5: cint;
                       alignment: flags): cint {.cdecl,
    importc: "nk_button_image_text", header: headernuklear.}
proc button_text_styled*(a2: ptr context; a3: ptr style_button; title: cstring; len: cint): cint {.
    cdecl, importc: "nk_button_text_styled", header: headernuklear.}
proc button_label_styled*(a2: ptr context; a3: ptr style_button; title: cstring): cint {.
    cdecl, importc: "nk_button_label_styled", header: headernuklear.}
proc button_symbol_styled*(a2: ptr context; a3: ptr style_button; a4: symbol_type): cint {.
    cdecl, importc: "nk_button_symbol_styled", header: headernuklear.}
proc button_image_styled*(a2: ptr context; a3: ptr style_button; img: img): cint {.
    cdecl, importc: "nk_button_image_styled", header: headernuklear.}
proc button_symbol_text_styled*(a2: ptr context; a3: ptr style_button; a4: symbol_type;
                               a5: cstring; a6: cint; alignment: flags): cint {.cdecl,
    importc: "nk_button_symbol_text_styled", header: headernuklear.}
proc button_symbol_label_styled*(ctx: ptr context; style: ptr style_button;
                                symbol: symbol_type; title: cstring; align: flags): cint {.
    cdecl, importc: "nk_button_symbol_label_styled", header: headernuklear.}
proc button_image_label_styled*(a2: ptr context; a3: ptr style_button; img: img;
                               a5: cstring; text_alignment: flags): cint {.cdecl,
    importc: "nk_button_image_label_styled", header: headernuklear.}
proc button_image_text_styled*(a2: ptr context; a3: ptr style_button; img: img;
                              a5: cstring; a6: cint; alignment: flags): cint {.cdecl,
    importc: "nk_button_image_text_styled", header: headernuklear.}
proc button_set_behavior*(a2: ptr context; a3: button_behavior) {.cdecl,
    importc: "nk_button_set_behavior", header: headernuklear.}
proc button_push_behavior*(a2: ptr context; a3: button_behavior): cint {.cdecl,
    importc: "nk_button_push_behavior", header: headernuklear.}
proc button_pop_behavior*(a2: ptr context): cint {.cdecl,
    importc: "nk_button_pop_behavior", header: headernuklear.}
proc check_label*(a2: ptr context; a3: cstring; active: cint): cint {.cdecl,
    importc: "nk_check_label", header: headernuklear.}
proc check_text*(a2: ptr context; a3: cstring; a4: cint; active: cint): cint {.cdecl,
    importc: "nk_check_text", header: headernuklear.}
proc check_flags_label*(a2: ptr context; a3: cstring; flags: cuint; value: cuint): cuint {.
    cdecl, importc: "nk_check_flags_label", header: headernuklear.}
proc check_flags_text*(a2: ptr context; a3: cstring; a4: cint; flags: cuint; value: cuint): cuint {.
    cdecl, importc: "nk_check_flags_text", header: headernuklear.}
proc checkbox_label*(a2: ptr context; a3: cstring; active: ptr cint): cint {.cdecl,
    importc: "nk_checkbox_label", header: headernuklear.}
proc checkbox_text*(a2: ptr context; a3: cstring; a4: cint; active: ptr cint): cint {.cdecl,
    importc: "nk_checkbox_text", header: headernuklear.}
proc checkbox_flags_label*(a2: ptr context; a3: cstring; flags: ptr cuint; value: cuint): cint {.
    cdecl, importc: "nk_checkbox_flags_label", header: headernuklear.}
proc checkbox_flags_text*(a2: ptr context; a3: cstring; a4: cint; flags: ptr cuint;
                         value: cuint): cint {.cdecl,
    importc: "nk_checkbox_flags_text", header: headernuklear.}
proc radio_label*(a2: ptr context; a3: cstring; active: ptr cint): cint {.cdecl,
    importc: "nk_radio_label", header: headernuklear.}
proc radio_text*(a2: ptr context; a3: cstring; a4: cint; active: ptr cint): cint {.cdecl,
    importc: "nk_radio_text", header: headernuklear.}
proc option_label*(a2: ptr context; a3: cstring; active: cint): cint {.cdecl,
    importc: "nk_option_label", header: headernuklear.}
proc option_text*(a2: ptr context; a3: cstring; a4: cint; active: cint): cint {.cdecl,
    importc: "nk_option_text", header: headernuklear.}
proc selectable_label*(a2: ptr context; a3: cstring; align: flags; value: ptr cint): cint {.
    cdecl, importc: "nk_selectable_label", header: headernuklear.}
proc selectable_text*(a2: ptr context; a3: cstring; a4: cint; align: flags;
                     value: ptr cint): cint {.cdecl, importc: "nk_selectable_text",
    header: headernuklear.}
proc selectable_image_label*(a2: ptr context; a3: img; a4: cstring; align: flags;
                            value: ptr cint): cint {.cdecl,
    importc: "nk_selectable_image_label", header: headernuklear.}
proc selectable_image_text*(a2: ptr context; a3: img; a4: cstring; a5: cint;
                           align: flags; value: ptr cint): cint {.cdecl,
    importc: "nk_selectable_image_text", header: headernuklear.}
proc selectable_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring;
                             align: flags; value: ptr cint): cint {.cdecl,
    importc: "nk_selectable_symbol_label", header: headernuklear.}
proc selectable_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring; a5: cint;
                            align: flags; value: ptr cint): cint {.cdecl,
    importc: "nk_selectable_symbol_text", header: headernuklear.}
proc select_label*(a2: ptr context; a3: cstring; align: flags; value: cint): cint {.cdecl,
    importc: "nk_select_label", header: headernuklear.}
proc select_text*(a2: ptr context; a3: cstring; a4: cint; align: flags; value: cint): cint {.
    cdecl, importc: "nk_select_text", header: headernuklear.}
proc select_image_label*(a2: ptr context; a3: img; a4: cstring; align: flags;
                        value: cint): cint {.cdecl,
    importc: "nk_select_image_label", header: headernuklear.}
proc select_image_text*(a2: ptr context; a3: img; a4: cstring; a5: cint; align: flags;
                       value: cint): cint {.cdecl, importc: "nk_select_image_text",
    header: headernuklear.}
proc select_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring; align: flags;
                         value: cint): cint {.cdecl,
    importc: "nk_select_symbol_label", header: headernuklear.}
proc select_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring; a5: cint;
                        align: flags; value: cint): cint {.cdecl,
    importc: "nk_select_symbol_text", header: headernuklear.}
proc slide_float*(a2: ptr context; min: cfloat; val: cfloat; max: cfloat; step: cfloat): cfloat {.
    cdecl, importc: "nk_slide_float", header: headernuklear.}
proc slide_int*(a2: ptr context; min: cint; val: cint; max: cint; step: cint): cint {.cdecl,
    importc: "nk_slide_int", header: headernuklear.}
proc slider_float*(a2: ptr context; min: cfloat; val: ptr cfloat; max: cfloat; step: cfloat): cint {.
    cdecl, importc: "nk_slider_float", header: headernuklear.}
proc slider_int*(a2: ptr context; min: cint; val: ptr cint; max: cint; step: cint): cint {.
    cdecl, importc: "nk_slider_int", header: headernuklear.}
proc progress*(a2: ptr context; cur: ptr size; max: size; modifyable: cint): cint {.cdecl,
    importc: "nk_progress", header: headernuklear.}
proc prog*(a2: ptr context; cur: size; max: size; modifyable: cint): size {.cdecl,
    importc: "nk_prog", header: headernuklear.}
proc color_picker*(a2: ptr context; a3: colorf; a4: color_format): colorf {.cdecl,
    importc: "nk_color_picker", header: headernuklear.}
proc color_pick*(a2: ptr context; a3: ptr colorf; a4: color_format): cint {.cdecl,
    importc: "nk_color_pick", header: headernuklear.}
proc property_int*(a2: ptr context; name: cstring; min: cint; val: ptr cint; max: cint;
                  step: cint; inc_per_pixel: cfloat) {.cdecl,
    importc: "nk_property_int", header: headernuklear.}
proc property_float*(a2: ptr context; name: cstring; min: cfloat; val: ptr cfloat;
                    max: cfloat; step: cfloat; inc_per_pixel: cfloat) {.cdecl,
    importc: "nk_property_float", header: headernuklear.}
proc property_double*(a2: ptr context; name: cstring; min: cdouble; val: ptr cdouble;
                     max: cdouble; step: cdouble; inc_per_pixel: cfloat) {.cdecl,
    importc: "nk_property_double", header: headernuklear.}
proc propertyi*(a2: ptr context; name: cstring; min: cint; val: cint; max: cint; step: cint;
               inc_per_pixel: cfloat): cint {.cdecl, importc: "nk_propertyi",
    header: headernuklear.}
proc propertyf*(a2: ptr context; name: cstring; min: cfloat; val: cfloat; max: cfloat;
               step: cfloat; inc_per_pixel: cfloat): cfloat {.cdecl,
    importc: "nk_propertyf", header: headernuklear.}
proc propertyd*(a2: ptr context; name: cstring; min: cdouble; val: cdouble; max: cdouble;
               step: cdouble; inc_per_pixel: cfloat): cdouble {.cdecl,
    importc: "nk_propertyd", header: headernuklear.}
type
  edit_flags* {.size: sizeof(cint).} = enum
    EDIT_DEFAULT = 0, EDIT_READ_ONLY = (1 shl (0)), EDIT_AUTO_SELECT = (1 shl (1)),
    EDIT_SIG_ENTER = (1 shl (2)), EDIT_ALLOW_TAB = (1 shl (3)),
    EDIT_NO_CURSOR = (1 shl (4)), EDIT_SELECTABLE = (1 shl (5)),
    EDIT_CLIPBOARD = (1 shl (6)), EDIT_CTRL_ENTER_NEWLINE = (1 shl (7)),
    EDIT_NO_HORIZONTAL_SCROLL = (1 shl (8)), EDIT_ALWAYS_INSERT_MODE = (1 shl (9)),
    EDIT_MULTILINE = (1 shl (10)), EDIT_GOTO_END_ON_ACTIVATE = (1 shl (11))


type
  edit_types* {.size: sizeof(cint).} = enum
    EDIT_SIMPLE = EDIT_ALWAYS_INSERT_MODE,
    EDIT_FIELD = EDIT_SIMPLE.int or EDIT_SELECTABLE.int or EDIT_CLIPBOARD.int
    EDIT_EDITOR = EDIT_SELECTABLE.int or EDIT_MULTILINE.int or EDIT_ALLOW_TAB.int or EDIT_CLIPBOARD.int
    EDIT_BOX = EDIT_ALWAYS_INSERT_MODE.int or EDIT_SELECTABLE.int or EDIT_MULTILINE.int or EDIT_ALLOW_TAB.int or EDIT_CLIPBOARD.int


type
  edit_events* {.size: sizeof(cint).} = enum
    EDIT_ACTIVE = (1 shl (0)), EDIT_INACTIVE = (1 shl (1)), EDIT_ACTIVATED = (1 shl (2)),
    EDIT_DEACTIVATED = (1 shl (3)), EDIT_COMMITED = (1 shl (4))


proc edit_string*(a2: ptr context; a3: flags; buffer: cstring; len: ptr cint; max: cint;
                 a7: plugin_filter): flags {.cdecl, importc: "nk_edit_string",
    header: headernuklear.}
proc edit_string_zero_terminated*(a2: ptr context; a3: flags; buffer: cstring;
                                 max: cint; a6: plugin_filter): flags {.cdecl,
    importc: "nk_edit_string_zero_terminated", header: headernuklear.}
proc edit_buffer*(a2: ptr context; a3: flags; a4: ptr text_edit; a5: plugin_filter): flags {.
    cdecl, importc: "nk_edit_buffer", header: headernuklear.}
proc edit_focus*(a2: ptr context; flags: flags) {.cdecl, importc: "nk_edit_focus",
    header: headernuklear.}
proc edit_unfocus*(a2: ptr context) {.cdecl, importc: "nk_edit_unfocus",
                                  header: headernuklear.}
proc chart_begin*(a2: ptr context; a3: chart_type; num: cint; min: cfloat; max: cfloat): cint {.
    cdecl, importc: "nk_chart_begin", header: headernuklear.}
proc chart_begin_colored*(a2: ptr context; a3: chart_type; a4: color; active: color;
                         num: cint; min: cfloat; max: cfloat): cint {.cdecl,
    importc: "nk_chart_begin_colored", header: headernuklear.}
proc chart_add_slot*(ctx: ptr context; a3: chart_type; count: cint; min_value: cfloat;
                    max_value: cfloat) {.cdecl, importc: "nk_chart_add_slot",
                                       header: headernuklear.}
proc chart_add_slot_colored*(ctx: ptr context; a3: chart_type; a4: color; active: color;
                            count: cint; min_value: cfloat; max_value: cfloat) {.
    cdecl, importc: "nk_chart_add_slot_colored", header: headernuklear.}
proc chart_push*(a2: ptr context; a3: cfloat): flags {.cdecl, importc: "nk_chart_push",
    header: headernuklear.}
proc chart_push_slot*(a2: ptr context; a3: cfloat; a4: cint): flags {.cdecl,
    importc: "nk_chart_push_slot", header: headernuklear.}
proc chart_end*(a2: ptr context) {.cdecl, importc: "nk_chart_end",
                               header: headernuklear.}
proc plot*(a2: ptr context; a3: chart_type; values: ptr cfloat; count: cint; offset: cint) {.
    cdecl, importc: "nk_plot", header: headernuklear.}
proc plot_function*(a2: ptr context; a3: chart_type; userdata: pointer; value_getter: proc (
    user: pointer; index: cint): cfloat {.cdecl.}; count: cint; offset: cint) {.cdecl,
    importc: "nk_plot_function", header: headernuklear.}
proc popup_begin*(a2: ptr context; a3: popup_type; a4: cstring; a5: flags; bounds: rect): cint {.
    cdecl, importc: "nk_popup_begin", header: headernuklear.}
proc popup_close*(a2: ptr context) {.cdecl, importc: "nk_popup_close",
                                 header: headernuklear.}
proc popup_end*(a2: ptr context) {.cdecl, importc: "nk_popup_end",
                               header: headernuklear.}
proc combo*(a2: ptr context; items: cstringArray; count: cint; selected: cint;
           item_height: cint; size: vec2): cint {.cdecl, importc: "nk_combo",
    header: headernuklear.}
proc combo_separator*(a2: ptr context; items_separated_by_separator: cstring;
                     separator: cint; selected: cint; count: cint; item_height: cint;
                     size: vec2): cint {.cdecl, importc: "nk_combo_separator",
                                      header: headernuklear.}
proc combo_string*(a2: ptr context; items_separated_by_zeros: cstring; selected: cint;
                  count: cint; item_height: cint; size: vec2): cint {.cdecl,
    importc: "nk_combo_string", header: headernuklear.}
proc combo_callback*(a2: ptr context; item_getter: proc (a2: pointer; a3: cint;
    a4: cstringArray) {.cdecl.}; userdata: pointer; selected: cint; count: cint;
                    item_height: cint; size: vec2): cint {.cdecl,
    importc: "nk_combo_callback", header: headernuklear.}
proc combobox*(a2: ptr context; items: cstringArray; count: cint; selected: ptr cint;
              item_height: cint; size: vec2) {.cdecl, importc: "nk_combobox",
    header: headernuklear.}
proc combobox_string*(a2: ptr context; items_separated_by_zeros: cstring;
                     selected: ptr cint; count: cint; item_height: cint; size: vec2) {.
    cdecl, importc: "nk_combobox_string", header: headernuklear.}
proc combobox_separator*(a2: ptr context; items_separated_by_separator: cstring;
                        separator: cint; selected: ptr cint; count: cint;
                        item_height: cint; size: vec2) {.cdecl,
    importc: "nk_combobox_separator", header: headernuklear.}
proc combobox_callback*(a2: ptr context; item_getter: proc (a2: pointer; a3: cint;
    a4: cstringArray) {.cdecl.}; a4: pointer; selected: ptr cint; count: cint;
                       item_height: cint; size: vec2) {.cdecl,
    importc: "nk_combobox_callback", header: headernuklear.}
proc combo_begin_text*(a2: ptr context; selected: cstring; a4: cint; size: vec2): cint {.
    cdecl, importc: "nk_combo_begin_text", header: headernuklear.}
proc combo_begin_label*(a2: ptr context; selected: cstring; size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_label", header: headernuklear.}
proc combo_begin_color*(a2: ptr context; color: color; size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_color", header: headernuklear.}
proc combo_begin_symbol*(a2: ptr context; a3: symbol_type; size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_symbol", header: headernuklear.}
proc combo_begin_symbol_label*(a2: ptr context; selected: cstring; a4: symbol_type;
                              size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_symbol_label", header: headernuklear.}
proc combo_begin_symbol_text*(a2: ptr context; selected: cstring; a4: cint;
                             a5: symbol_type; size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_symbol_text", header: headernuklear.}
proc combo_begin_image*(a2: ptr context; img: img; size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_image", header: headernuklear.}
proc combo_begin_image_label*(a2: ptr context; selected: cstring; a4: img; size: vec2): cint {.
    cdecl, importc: "nk_combo_begin_image_label", header: headernuklear.}
proc combo_begin_image_text*(a2: ptr context; selected: cstring; a4: cint; a5: img;
                            size: vec2): cint {.cdecl,
    importc: "nk_combo_begin_image_text", header: headernuklear.}
proc combo_item_label*(a2: ptr context; a3: cstring; alignment: flags): cint {.cdecl,
    importc: "nk_combo_item_label", header: headernuklear.}
proc combo_item_text*(a2: ptr context; a3: cstring; a4: cint; alignment: flags): cint {.
    cdecl, importc: "nk_combo_item_text", header: headernuklear.}
proc combo_item_image_label*(a2: ptr context; a3: img; a4: cstring; alignment: flags): cint {.
    cdecl, importc: "nk_combo_item_image_label", header: headernuklear.}
proc combo_item_image_text*(a2: ptr context; a3: img; a4: cstring; a5: cint;
                           alignment: flags): cint {.cdecl,
    importc: "nk_combo_item_image_text", header: headernuklear.}
proc combo_item_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring;
                             alignment: flags): cint {.cdecl,
    importc: "nk_combo_item_symbol_label", header: headernuklear.}
proc combo_item_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring; a5: cint;
                            alignment: flags): cint {.cdecl,
    importc: "nk_combo_item_symbol_text", header: headernuklear.}
proc combo_close*(a2: ptr context) {.cdecl, importc: "nk_combo_close",
                                 header: headernuklear.}
proc combo_end*(a2: ptr context) {.cdecl, importc: "nk_combo_end",
                               header: headernuklear.}
proc contextual_begin*(a2: ptr context; a3: flags; a4: vec2; trigger_bounds: rect): cint {.
    cdecl, importc: "nk_contextual_begin", header: headernuklear.}
proc contextual_item_text*(a2: ptr context; a3: cstring; a4: cint; align: flags): cint {.
    cdecl, importc: "nk_contextual_item_text", header: headernuklear.}
proc contextual_item_label*(a2: ptr context; a3: cstring; align: flags): cint {.cdecl,
    importc: "nk_contextual_item_label", header: headernuklear.}
proc contextual_item_image_label*(a2: ptr context; a3: img; a4: cstring;
                                 alignment: flags): cint {.cdecl,
    importc: "nk_contextual_item_image_label", header: headernuklear.}
proc contextual_item_image_text*(a2: ptr context; a3: img; a4: cstring; len: cint;
                                alignment: flags): cint {.cdecl,
    importc: "nk_contextual_item_image_text", header: headernuklear.}
proc contextual_item_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring;
                                  alignment: flags): cint {.cdecl,
    importc: "nk_contextual_item_symbol_label", header: headernuklear.}
proc contextual_item_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring;
                                 a5: cint; alignment: flags): cint {.cdecl,
    importc: "nk_contextual_item_symbol_text", header: headernuklear.}
proc contextual_close*(a2: ptr context) {.cdecl, importc: "nk_contextual_close",
                                      header: headernuklear.}
proc contextual_end*(a2: ptr context) {.cdecl, importc: "nk_contextual_end",
                                    header: headernuklear.}
proc tooltip*(a2: ptr context; a3: cstring) {.cdecl, importc: "nk_tooltip",
                                        header: headernuklear.}
proc tooltip_begin*(a2: ptr context; width: cfloat): cint {.cdecl,
    importc: "nk_tooltip_begin", header: headernuklear.}
proc tooltip_end*(a2: ptr context) {.cdecl, importc: "nk_tooltip_end",
                                 header: headernuklear.}
proc menubar_begin*(a2: ptr context) {.cdecl, importc: "nk_menubar_begin",
                                   header: headernuklear.}
proc menubar_end*(a2: ptr context) {.cdecl, importc: "nk_menubar_end",
                                 header: headernuklear.}
proc menu_begin_text*(a2: ptr context; title: cstring; title_len: cint; align: flags;
                     size: vec2): cint {.cdecl, importc: "nk_menu_begin_text",
                                      header: headernuklear.}
proc menu_begin_label*(a2: ptr context; a3: cstring; align: flags; size: vec2): cint {.
    cdecl, importc: "nk_menu_begin_label", header: headernuklear.}
proc menu_begin_image*(a2: ptr context; a3: cstring; a4: img; size: vec2): cint {.cdecl,
    importc: "nk_menu_begin_image", header: headernuklear.}
proc menu_begin_image_text*(a2: ptr context; a3: cstring; a4: cint; align: flags;
                           a6: img; size: vec2): cint {.cdecl,
    importc: "nk_menu_begin_image_text", header: headernuklear.}
proc menu_begin_image_label*(a2: ptr context; a3: cstring; align: flags; a5: img;
                            size: vec2): cint {.cdecl,
    importc: "nk_menu_begin_image_label", header: headernuklear.}
proc menu_begin_symbol*(a2: ptr context; a3: cstring; a4: symbol_type; size: vec2): cint {.
    cdecl, importc: "nk_menu_begin_symbol", header: headernuklear.}
proc menu_begin_symbol_text*(a2: ptr context; a3: cstring; a4: cint; align: flags;
                            a6: symbol_type; size: vec2): cint {.cdecl,
    importc: "nk_menu_begin_symbol_text", header: headernuklear.}
proc menu_begin_symbol_label*(a2: ptr context; a3: cstring; align: flags;
                             a5: symbol_type; size: vec2): cint {.cdecl,
    importc: "nk_menu_begin_symbol_label", header: headernuklear.}
proc menu_item_text*(a2: ptr context; a3: cstring; a4: cint; align: flags): cint {.cdecl,
    importc: "nk_menu_item_text", header: headernuklear.}
proc menu_item_label*(a2: ptr context; a3: cstring; alignment: flags): cint {.cdecl,
    importc: "nk_menu_item_label", header: headernuklear.}
proc menu_item_image_label*(a2: ptr context; a3: img; a4: cstring; alignment: flags): cint {.
    cdecl, importc: "nk_menu_item_image_label", header: headernuklear.}
proc menu_item_image_text*(a2: ptr context; a3: img; a4: cstring; len: cint;
                          alignment: flags): cint {.cdecl,
    importc: "nk_menu_item_image_text", header: headernuklear.}
proc menu_item_symbol_text*(a2: ptr context; a3: symbol_type; a4: cstring; a5: cint;
                           alignment: flags): cint {.cdecl,
    importc: "nk_menu_item_symbol_text", header: headernuklear.}
proc menu_item_symbol_label*(a2: ptr context; a3: symbol_type; a4: cstring;
                            alignment: flags): cint {.cdecl,
    importc: "nk_menu_item_symbol_label", header: headernuklear.}
proc menu_close*(a2: ptr context) {.cdecl, importc: "nk_menu_close",
                                header: headernuklear.}
proc menu_end*(a2: ptr context) {.cdecl, importc: "nk_menu_end", header: headernuklear.}
type
  style_colors* {.size: sizeof(cint).} = enum
    COLOR_TEXT, COLOR_WINDOW, COLOR_HEADER, COLOR_BORDER, COLOR_BUTTON,
    COLOR_BUTTON_HOVER, COLOR_BUTTON_ACTIVE, COLOR_TOGGLE, COLOR_TOGGLE_HOVER,
    COLOR_TOGGLE_CURSOR, COLOR_SELECT, COLOR_SELECT_ACTIVE, COLOR_SLIDER,
    COLOR_SLIDER_CURSOR, COLOR_SLIDER_CURSOR_HOVER, COLOR_SLIDER_CURSOR_ACTIVE,
    COLOR_PROPERTY, COLOR_EDIT, COLOR_EDIT_CURSOR, COLOR_COMBO, COLOR_CHART,
    COLOR_CHART_COLOR, COLOR_CHART_COLOR_HIGHLIGHT, COLOR_SCROLLBAR,
    COLOR_SCROLLBAR_CURSOR, COLOR_SCROLLBAR_CURSOR_HOVER,
    COLOR_SCROLLBAR_CURSOR_ACTIVE, COLOR_TAB_HEADER, COLOR_COUNT





proc style_default*(a2: ptr context) {.cdecl, importc: "nk_style_default",
                                   header: headernuklear.}
proc style_from_table*(a2: ptr context; a3: ptr color) {.cdecl,
    importc: "nk_style_from_table", header: headernuklear.}
proc style_load_cursor*(a2: ptr context; a3: style_cursor; a4: ptr cursor) {.cdecl,
    importc: "nk_style_load_cursor", header: headernuklear.}
proc style_load_all_cursors*(a2: ptr context; a3: ptr cursor) {.cdecl,
    importc: "nk_style_load_all_cursors", header: headernuklear.}
proc style_get_color_by_name*(a2: style_colors): cstring {.cdecl,
    importc: "nk_style_get_color_by_name", header: headernuklear.}
proc style_set_font*(a2: ptr context; a3: ptr user_font) {.cdecl,
    importc: "nk_style_set_font", header: headernuklear.}
proc style_set_cursor*(a2: ptr context; a3: style_cursor): cint {.cdecl,
    importc: "nk_style_set_cursor", header: headernuklear.}
proc style_show_cursor*(a2: ptr context) {.cdecl, importc: "nk_style_show_cursor",
                                       header: headernuklear.}
proc style_hide_cursor*(a2: ptr context) {.cdecl, importc: "nk_style_hide_cursor",
                                       header: headernuklear.}
proc style_push_font*(a2: ptr context; a3: ptr user_font): cint {.cdecl,
    importc: "nk_style_push_font", header: headernuklear.}
proc style_push_float*(a2: ptr context; a3: ptr cfloat; a4: cfloat): cint {.cdecl,
    importc: "nk_style_push_float", header: headernuklear.}
proc style_push_vec2*(a2: ptr context; a3: ptr vec2; a4: vec2): cint {.cdecl,
    importc: "nk_style_push_vec2", header: headernuklear.}
proc style_push_style_item*(a2: ptr context; a3: ptr style_item; a4: style_item): cint {.
    cdecl, importc: "nk_style_push_style_item", header: headernuklear.}
proc style_push_flags*(a2: ptr context; a3: ptr flags; a4: flags): cint {.cdecl,
    importc: "nk_style_push_flags", header: headernuklear.}
proc style_push_color*(a2: ptr context; a3: ptr color; a4: color): cint {.cdecl,
    importc: "nk_style_push_color", header: headernuklear.}
proc style_pop_font*(a2: ptr context): cint {.cdecl, importc: "nk_style_pop_font",
    header: headernuklear.}
proc style_pop_float*(a2: ptr context): cint {.cdecl, importc: "nk_style_pop_float",
    header: headernuklear.}
proc style_pop_vec2*(a2: ptr context): cint {.cdecl, importc: "nk_style_pop_vec2",
    header: headernuklear.}
proc style_pop_style_item*(a2: ptr context): cint {.cdecl,
    importc: "nk_style_pop_style_item", header: headernuklear.}
proc style_pop_flags*(a2: ptr context): cint {.cdecl, importc: "nk_style_pop_flags",
    header: headernuklear.}
proc style_pop_color*(a2: ptr context): cint {.cdecl, importc: "nk_style_pop_color",
    header: headernuklear.}
proc rgb*(r: cint; g: cint; b: cint): color {.cdecl, importc: "nk_rgb",
                                      header: headernuklear.}
proc rgb_iv*(rgb: ptr cint): color {.cdecl, importc: "nk_rgb_iv", header: headernuklear.}
proc rgb_bv*(rgb: ptr byte): color {.cdecl, importc: "nk_rgb_bv", header: headernuklear.}
proc rgb_f*(r: cfloat; g: cfloat; b: cfloat): color {.cdecl, importc: "nk_rgb_f",
    header: headernuklear.}
proc rgb_fv*(rgb: ptr cfloat): color {.cdecl, importc: "nk_rgb_fv",
                                  header: headernuklear.}
proc rgb_cf*(c: colorf): color {.cdecl, importc: "nk_rgb_cf", header: headernuklear.}
proc rgb_hex*(rgb: cstring): color {.cdecl, importc: "nk_rgb_hex",
                                 header: headernuklear.}
proc rgba*(r: cint; g: cint; b: cint; a: cint): color {.cdecl, importc: "nk_rgba",
    header: headernuklear.}
proc rgba_u32*(a2: uint): color {.cdecl, importc: "nk_rgba_u32", header: headernuklear.}
proc rgba_iv*(rgba: ptr cint): color {.cdecl, importc: "nk_rgba_iv",
                                  header: headernuklear.}
proc rgba_bv*(rgba: ptr byte): color {.cdecl, importc: "nk_rgba_bv",
                                  header: headernuklear.}
proc rgba_f*(r: cfloat; g: cfloat; b: cfloat; a: cfloat): color {.cdecl,
    importc: "nk_rgba_f", header: headernuklear.}
proc rgba_fv*(rgba: ptr cfloat): color {.cdecl, importc: "nk_rgba_fv",
                                    header: headernuklear.}
proc rgba_cf*(c: colorf): color {.cdecl, importc: "nk_rgba_cf", header: headernuklear.}
proc rgba_hex*(rgb: cstring): color {.cdecl, importc: "nk_rgba_hex",
                                  header: headernuklear.}
proc hsva_colorf*(h: cfloat; s: cfloat; v: cfloat; a: cfloat): colorf {.cdecl,
    importc: "nk_hsva_colorf", header: headernuklear.}
proc hsva_colorfv*(c: ptr cfloat): colorf {.cdecl, importc: "nk_hsva_colorfv",
                                       header: headernuklear.}
proc colorf_hsva_f*(out_h: ptr cfloat; out_s: ptr cfloat; out_v: ptr cfloat;
                   out_a: ptr cfloat; `in`: colorf) {.cdecl,
    importc: "nk_colorf_hsva_f", header: headernuklear.}
proc colorf_hsva_fv*(hsva: ptr cfloat; `in`: colorf) {.cdecl,
    importc: "nk_colorf_hsva_fv", header: headernuklear.}
proc hsv*(h: cint; s: cint; v: cint): color {.cdecl, importc: "nk_hsv",
                                      header: headernuklear.}
proc hsv_iv*(hsv: ptr cint): color {.cdecl, importc: "nk_hsv_iv", header: headernuklear.}
proc hsv_bv*(hsv: ptr byte): color {.cdecl, importc: "nk_hsv_bv", header: headernuklear.}
proc hsv_f*(h: cfloat; s: cfloat; v: cfloat): color {.cdecl, importc: "nk_hsv_f",
    header: headernuklear.}
proc hsv_fv*(hsv: ptr cfloat): color {.cdecl, importc: "nk_hsv_fv",
                                  header: headernuklear.}
proc hsva*(h: cint; s: cint; v: cint; a: cint): color {.cdecl, importc: "nk_hsva",
    header: headernuklear.}
proc hsva_iv*(hsva: ptr cint): color {.cdecl, importc: "nk_hsva_iv",
                                  header: headernuklear.}
proc hsva_bv*(hsva: ptr byte): color {.cdecl, importc: "nk_hsva_bv",
                                  header: headernuklear.}
proc hsva_f*(h: cfloat; s: cfloat; v: cfloat; a: cfloat): color {.cdecl,
    importc: "nk_hsva_f", header: headernuklear.}
proc hsva_fv*(hsva: ptr cfloat): color {.cdecl, importc: "nk_hsva_fv",
                                    header: headernuklear.}
proc nk_color_f*(r: ptr cfloat; g: ptr cfloat; b: ptr cfloat; a: ptr cfloat; a6: color) {.cdecl,
    importc: "nk_color_f", header: headernuklear.}
proc color_fv*(rgba_out: ptr cfloat; a3: color) {.cdecl, importc: "nk_color_fv",
    header: headernuklear.}
proc color_cf*(a2: color): colorf {.cdecl, importc: "nk_color_cf",
                                header: headernuklear.}
proc color_d*(r: ptr cdouble; g: ptr cdouble; b: ptr cdouble; a: ptr cdouble; a6: color) {.
    cdecl, importc: "nk_color_d", header: headernuklear.}
proc color_dv*(rgba_out: ptr cdouble; a3: color) {.cdecl, importc: "nk_color_dv",
    header: headernuklear.}
proc color_u32*(a2: color): uint {.cdecl, importc: "nk_color_u32",
                               header: headernuklear.}
proc color_hex_rgba*(output: cstring; a3: color) {.cdecl,
    importc: "nk_color_hex_rgba", header: headernuklear.}
proc color_hex_rgb*(output: cstring; a3: color) {.cdecl, importc: "nk_color_hex_rgb",
    header: headernuklear.}
proc color_hsv_i*(out_h: ptr cint; out_s: ptr cint; out_v: ptr cint; a5: color) {.cdecl,
    importc: "nk_color_hsv_i", header: headernuklear.}
proc color_hsv_b*(out_h: ptr byte; out_s: ptr byte; out_v: ptr byte; a5: color) {.cdecl,
    importc: "nk_color_hsv_b", header: headernuklear.}
proc color_hsv_iv*(hsv_out: ptr cint; a3: color) {.cdecl, importc: "nk_color_hsv_iv",
    header: headernuklear.}
proc color_hsv_bv*(hsv_out: ptr byte; a3: color) {.cdecl, importc: "nk_color_hsv_bv",
    header: headernuklear.}
proc color_hsv_f*(out_h: ptr cfloat; out_s: ptr cfloat; out_v: ptr cfloat; a5: color) {.
    cdecl, importc: "nk_color_hsv_f", header: headernuklear.}
proc color_hsv_fv*(hsv_out: ptr cfloat; a3: color) {.cdecl, importc: "nk_color_hsv_fv",
    header: headernuklear.}
proc color_hsva_i*(h: ptr cint; s: ptr cint; v: ptr cint; a: ptr cint; a6: color) {.cdecl,
    importc: "nk_color_hsva_i", header: headernuklear.}
proc color_hsva_b*(h: ptr byte; s: ptr byte; v: ptr byte; a: ptr byte; a6: color) {.cdecl,
    importc: "nk_color_hsva_b", header: headernuklear.}
proc color_hsva_iv*(hsva_out: ptr cint; a3: color) {.cdecl,
    importc: "nk_color_hsva_iv", header: headernuklear.}
proc color_hsva_bv*(hsva_out: ptr byte; a3: color) {.cdecl,
    importc: "nk_color_hsva_bv", header: headernuklear.}
proc color_hsva_f*(out_h: ptr cfloat; out_s: ptr cfloat; out_v: ptr cfloat;
                  out_a: ptr cfloat; a6: color) {.cdecl, importc: "nk_color_hsva_f",
    header: headernuklear.}
proc color_hsva_fv*(hsva_out: ptr cfloat; a3: color) {.cdecl,
    importc: "nk_color_hsva_fv", header: headernuklear.}
proc handle_ptr*(a2: pointer): handle {.cdecl, importc: "nk_handle_ptr",
                                    header: headernuklear.}
proc handle_id*(a2: cint): handle {.cdecl, importc: "nk_handle_id",
                                header: headernuklear.}
proc image_handle*(a2: handle): img {.cdecl, importc: "nk_image_handle",
                                    header: headernuklear.}
proc image_ptr*(a2: pointer): img {.cdecl, importc: "nk_image_ptr",
                                  header: headernuklear.}
proc image_id*(a2: cint): img {.cdecl, importc: "nk_image_id", header: headernuklear.}
proc image_is_subimage*(img: ptr img): cint {.cdecl,
    importc: "nk_image_is_subimage", header: headernuklear.}
proc subimage_ptr*(a2: pointer; w: cushort; h: cushort; sub_region: rect): img {.cdecl,
    importc: "nk_subimage_ptr", header: headernuklear.}
proc subimage_id*(a2: cint; w: cushort; h: cushort; sub_region: rect): img {.cdecl,
    importc: "nk_subimage_id", header: headernuklear.}
proc subimage_handle*(a2: handle; w: cushort; h: cushort; sub_region: rect): img {.
    cdecl, importc: "nk_subimage_handle", header: headernuklear.}
proc murmur_hash*(key: pointer; len: cint; seed: hash): hash {.cdecl,
    importc: "nk_murmur_hash", header: headernuklear.}
proc triangle_from_direction*(result: ptr vec2; r: rect; pad_x: cfloat; pad_y: cfloat;
                             a6: heading) {.cdecl,
    importc: "nk_triangle_from_direction", header: headernuklear.}
proc newVec2*(x: cfloat; y: cfloat): vec2 {.cdecl, importc: "struct nk_vec2", header: headernuklear.}
proc newVec2i*(x: cint; y: cint): vec2 {.cdecl, importc: "struct nk_vec2i", header: headernuklear.}
proc vec2v*(xy: ptr cfloat): vec2 {.cdecl, importc: "nk_vec2v", header: headernuklear.}
proc vec2iv*(xy: ptr cint): vec2 {.cdecl, importc: "nk_vec2iv", header: headernuklear.}
proc get_null_rect*(): rect {.cdecl, importc: "nk_get_null_rect",
                           header: headernuklear.}
proc newRect*(x: cfloat; y: cfloat; w: cfloat; h: cfloat): rect {.cdecl, importc: "struct nk_rect",
    header: headernuklear.}
proc newRecti*(x: cint; y: cint; w: cint; h: cint): rect {.cdecl, importc: "struct nk_recti",
    header: headernuklear.}
proc recta*(pos: vec2; size: vec2): rect {.cdecl, importc: "nk_recta",
                                     header: headernuklear.}
proc rectv*(xywh: ptr cfloat): rect {.cdecl, importc: "nk_rectv", header: headernuklear.}
proc rectiv*(xywh: ptr cint): rect {.cdecl, importc: "nk_rectiv", header: headernuklear.}
proc rect_pos*(a2: rect): vec2 {.cdecl, importc: "nk_rect_pos", header: headernuklear.}
proc rect_size*(a2: rect): vec2 {.cdecl, importc: "nk_rect_size", header: headernuklear.}
proc strlen*(str: cstring): cint {.cdecl, importc: "nk_strlen", header: headernuklear.}
proc stricmp*(s1: cstring; s2: cstring): cint {.cdecl, importc: "nk_stricmp",
    header: headernuklear.}
proc stricmpn*(s1: cstring; s2: cstring; n: cint): cint {.cdecl, importc: "nk_stricmpn",
    header: headernuklear.}
proc strtoi*(str: cstring; endptr: cstringArray): cint {.cdecl, importc: "nk_strtoi",
    header: headernuklear.}
proc strtof*(str: cstring; endptr: cstringArray): cfloat {.cdecl, importc: "nk_strtof",
    header: headernuklear.}
proc strtod*(str: cstring; endptr: cstringArray): cdouble {.cdecl,
    importc: "nk_strtod", header: headernuklear.}
proc strfilter*(text: cstring; regexp: cstring): cint {.cdecl, importc: "nk_strfilter",
    header: headernuklear.}
proc strmatch_fuzzy_string*(str: cstring; pattern: cstring; out_score: ptr cint): cint {.
    cdecl, importc: "nk_strmatch_fuzzy_string", header: headernuklear.}
proc strmatch_fuzzy_text*(txt: cstring; txt_len: cint; pattern: cstring;
                         out_score: ptr cint): cint {.cdecl,
    importc: "nk_strmatch_fuzzy_text", header: headernuklear.}
proc utf_decode*(a2: cstring; a3: ptr rune; a4: cint): cint {.cdecl,
    importc: "nk_utf_decode", header: headernuklear.}
proc utf_encode*(a2: rune; a3: cstring; a4: cint): cint {.cdecl,
    importc: "nk_utf_encode", header: headernuklear.}
proc utf_len*(a2: cstring; byte_len: cint): cint {.cdecl, importc: "nk_utf_len",
    header: headernuklear.}
proc utf_at*(buffer: cstring; length: cint; index: cint; unicode: ptr rune; len: ptr cint): cstring {.
    cdecl, importc: "nk_utf_at", header: headernuklear.}



type
  font_atlas* {.importc: "struct nk_font_atlas", header: headernuklear.} = object
    pixel* {.importc: "pixel".}: pointer
    tex_width* {.importc: "tex_width".}: cint
    tex_height* {.importc: "tex_height".}: cint
    permanent* {.importc: "permanent".}: allocator
    temporary* {.importc: "temporary".}: allocator
    custom* {.importc: "custom".}: recti
    cursors* {.importc: "cursors".}: array[CURSOR_COUNT, cursor]
    glyph_count* {.importc: "glyph_count".}: cint
    glyphs* {.importc: "glyphs".}: ptr font_glyph
    default_font* {.importc: "default_font".}: ptr font
    fonts* {.importc: "fonts".}: ptr font
    config* {.importc: "config".}: ptr font_config
    font_num* {.importc: "font_num".}: cint


proc font_default_glyph_ranges*(): ptr rune {.cdecl,
    importc: "nk_font_default_glyph_ranges", header: headernuklear.}
proc font_chinese_glyph_ranges*(): ptr rune {.cdecl,
    importc: "nk_font_chinese_glyph_ranges", header: headernuklear.}
proc font_cyrillic_glyph_ranges*(): ptr rune {.cdecl,
    importc: "nk_font_cyrillic_glyph_ranges", header: headernuklear.}
proc font_korean_glyph_ranges*(): ptr rune {.cdecl,
    importc: "nk_font_korean_glyph_ranges", header: headernuklear.}
proc font_atlas_init_default*(a2: ptr font_atlas) {.cdecl,
    importc: "nk_font_atlas_init_default", header: headernuklear.}
proc font_atlas_init*(a2: ptr font_atlas; a3: ptr allocator) {.cdecl,
    importc: "nk_font_atlas_init", header: headernuklear.}
proc font_atlas_init_custom*(a2: ptr font_atlas; persistent: ptr allocator;
                            transient: ptr allocator) {.cdecl,
    importc: "nk_font_atlas_init_custom", header: headernuklear.}
proc font_atlas_begin*(a2: ptr font_atlas) {.cdecl, importc: "nk_font_atlas_begin",
    header: headernuklear.}
proc nk_font_config*(pixel_height: cfloat): font_config {.cdecl, importc: "nk_font_config", header: headernuklear.}
proc font_atlas_add*(a2: ptr font_atlas; a3: ptr font_config): ptr font {.cdecl,
    importc: "nk_font_atlas_add", header: headernuklear.}
proc font_atlas_add_default*(a2: ptr font_atlas; height: cfloat; a4: ptr font_config): ptr font {.
    cdecl, importc: "nk_font_atlas_add_default", header: headernuklear.}
proc font_atlas_add_from_memory*(atlas: ptr font_atlas; memory: pointer; size: size;
                                height: cfloat; config: ptr font_config): ptr font {.
    cdecl, importc: "nk_font_atlas_add_from_memory", header: headernuklear.}
proc font_atlas_add_from_file*(atlas: ptr font_atlas; file_path: cstring;
                              height: cfloat; a5: ptr font_config): ptr font {.cdecl,
    importc: "nk_font_atlas_add_from_file", header: headernuklear.}
proc font_atlas_add_compressed*(a2: ptr font_atlas; memory: pointer; size: size;
                               height: cfloat; a6: ptr font_config): ptr font {.cdecl,
    importc: "nk_font_atlas_add_compressed", header: headernuklear.}
proc font_atlas_add_compressed_base85*(a2: ptr font_atlas; data: cstring;
                                      height: cfloat; config: ptr font_config): ptr font {.
    cdecl, importc: "nk_font_atlas_add_compressed_base85", header: headernuklear.}
proc font_atlas_bake*(a2: ptr font_atlas; width: ptr cint; height: ptr cint;
                     a5: font_atlas_format): pointer {.cdecl,
    importc: "nk_font_atlas_bake", header: headernuklear.}
proc font_atlas_end*(a2: ptr font_atlas; tex: handle; a4: ptr draw_null_texture) {.cdecl,
    importc: "nk_font_atlas_end", header: headernuklear.}
proc font_find_glyph*(a2: ptr font; unicode: rune): ptr font_glyph {.cdecl,
    importc: "nk_font_find_glyph", header: headernuklear.}
proc font_atlas_cleanup*(atlas: ptr font_atlas) {.cdecl,
    importc: "nk_font_atlas_cleanup", header: headernuklear.}
proc font_atlas_clear*(a2: ptr font_atlas) {.cdecl, importc: "nk_font_atlas_clear",
    header: headernuklear.}
type
  memory_status* {.importc: "struct nk_memory_status", header: headernuklear.} = object
    memory* {.importc: "memory".}: pointer
    `type`* {.importc: "type".}: cuint
    size* {.importc: "size".}: size
    allocated* {.importc: "allocated".}: size
    needed* {.importc: "needed".}: size
    calls* {.importc: "calls".}: size



proc buffer_init_default*(a2: ptr buffer) {.cdecl, importc: "nk_buffer_init_default",
                                        header: headernuklear.}
proc buffer_init*(a2: ptr buffer; a3: ptr allocator; size: size) {.cdecl,
    importc: "nk_buffer_init", header: headernuklear.}
proc buffer_init_fixed*(a2: ptr buffer; memory: pointer; size: size) {.cdecl,
    importc: "nk_buffer_init_fixed", header: headernuklear.}
proc buffer_info*(a2: ptr memory_status; a3: ptr buffer) {.cdecl,
    importc: "nk_buffer_info", header: headernuklear.}
proc buffer_push*(a2: ptr buffer; `type`: buffer_allocation_type; memory: pointer;
                 size: size; align: size) {.cdecl, importc: "nk_buffer_push",
                                        header: headernuklear.}
proc buffer_mark*(a2: ptr buffer; `type`: buffer_allocation_type) {.cdecl,
    importc: "nk_buffer_mark", header: headernuklear.}
proc buffer_reset*(a2: ptr buffer; `type`: buffer_allocation_type) {.cdecl,
    importc: "nk_buffer_reset", header: headernuklear.}
proc buffer_clear*(a2: ptr buffer) {.cdecl, importc: "nk_buffer_clear",
                                 header: headernuklear.}
proc buffer_free*(a2: ptr buffer) {.cdecl, importc: "nk_buffer_free",
                                header: headernuklear.}
proc buffer_memory*(a2: ptr buffer): pointer {.cdecl, importc: "nk_buffer_memory",
    header: headernuklear.}
proc buffer_memory_const*(a2: ptr buffer): pointer {.cdecl,
    importc: "nk_buffer_memory_const", header: headernuklear.}
proc buffer_total*(a2: ptr buffer): size {.cdecl, importc: "nk_buffer_total",
                                      header: headernuklear.}



proc str_init_default*(a2: ptr str) {.cdecl, importc: "nk_str_init_default",
                                  header: headernuklear.}
proc str_init*(a2: ptr str; a3: ptr allocator; size: size) {.cdecl,
    importc: "nk_str_init", header: headernuklear.}
proc str_init_fixed*(a2: ptr str; memory: pointer; size: size) {.cdecl,
    importc: "nk_str_init_fixed", header: headernuklear.}
proc str_clear*(a2: ptr str) {.cdecl, importc: "nk_str_clear", header: headernuklear.}
proc str_free*(a2: ptr str) {.cdecl, importc: "nk_str_free", header: headernuklear.}
proc str_append_text_char*(a2: ptr str; a3: cstring; a4: cint): cint {.cdecl,
    importc: "nk_str_append_text_char", header: headernuklear.}
proc str_append_str_char*(a2: ptr str; a3: cstring): cint {.cdecl,
    importc: "nk_str_append_str_char", header: headernuklear.}
proc str_append_text_utf8*(a2: ptr str; a3: cstring; a4: cint): cint {.cdecl,
    importc: "nk_str_append_text_utf8", header: headernuklear.}
proc str_append_str_utf8*(a2: ptr str; a3: cstring): cint {.cdecl,
    importc: "nk_str_append_str_utf8", header: headernuklear.}
proc str_append_text_runes*(a2: ptr str; a3: ptr rune; a4: cint): cint {.cdecl,
    importc: "nk_str_append_text_runes", header: headernuklear.}
proc str_append_str_runes*(a2: ptr str; a3: ptr rune): cint {.cdecl,
    importc: "nk_str_append_str_runes", header: headernuklear.}
proc str_insert_at_char*(a2: ptr str; pos: cint; a4: cstring; a5: cint): cint {.cdecl,
    importc: "nk_str_insert_at_char", header: headernuklear.}
proc str_insert_at_rune*(a2: ptr str; pos: cint; a4: cstring; a5: cint): cint {.cdecl,
    importc: "nk_str_insert_at_rune", header: headernuklear.}
proc str_insert_text_char*(a2: ptr str; pos: cint; a4: cstring; a5: cint): cint {.cdecl,
    importc: "nk_str_insert_text_char", header: headernuklear.}
proc str_insert_str_char*(a2: ptr str; pos: cint; a4: cstring): cint {.cdecl,
    importc: "nk_str_insert_str_char", header: headernuklear.}
proc str_insert_text_utf8*(a2: ptr str; pos: cint; a4: cstring; a5: cint): cint {.cdecl,
    importc: "nk_str_insert_text_utf8", header: headernuklear.}
proc str_insert_str_utf8*(a2: ptr str; pos: cint; a4: cstring): cint {.cdecl,
    importc: "nk_str_insert_str_utf8", header: headernuklear.}
proc str_insert_text_runes*(a2: ptr str; pos: cint; a4: ptr rune; a5: cint): cint {.cdecl,
    importc: "nk_str_insert_text_runes", header: headernuklear.}
proc str_insert_str_runes*(a2: ptr str; pos: cint; a4: ptr rune): cint {.cdecl,
    importc: "nk_str_insert_str_runes", header: headernuklear.}
proc str_remove_chars*(a2: ptr str; len: cint) {.cdecl, importc: "nk_str_remove_chars",
    header: headernuklear.}
proc str_remove_runes*(str: ptr str; len: cint) {.cdecl,
    importc: "nk_str_remove_runes", header: headernuklear.}
proc str_delete_chars*(a2: ptr str; pos: cint; len: cint) {.cdecl,
    importc: "nk_str_delete_chars", header: headernuklear.}
proc str_delete_runes*(a2: ptr str; pos: cint; len: cint) {.cdecl,
    importc: "nk_str_delete_runes", header: headernuklear.}
proc str_at_char*(a2: ptr str; pos: cint): cstring {.cdecl, importc: "nk_str_at_char",
    header: headernuklear.}
proc str_at_rune*(a2: ptr str; pos: cint; unicode: ptr rune; len: ptr cint): cstring {.cdecl,
    importc: "nk_str_at_rune", header: headernuklear.}
proc str_rune_at*(a2: ptr str; pos: cint): rune {.cdecl, importc: "nk_str_rune_at",
    header: headernuklear.}
proc str_at_char_const*(a2: ptr str; pos: cint): cstring {.cdecl,
    importc: "nk_str_at_char_const", header: headernuklear.}
proc str_at_const*(a2: ptr str; pos: cint; unicode: ptr rune; len: ptr cint): cstring {.
    cdecl, importc: "nk_str_at_const", header: headernuklear.}
proc str_get*(a2: ptr str): cstring {.cdecl, importc: "nk_str_get",
                                 header: headernuklear.}
proc str_get_const*(a2: ptr str): cstring {.cdecl, importc: "nk_str_get_const",
                                       header: headernuklear.}
proc str_len*(a2: ptr str): cint {.cdecl, importc: "nk_str_len", header: headernuklear.}
proc str_len_char*(a2: ptr str): cint {.cdecl, importc: "nk_str_len_char",
                                   header: headernuklear.}






proc filter_default*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_default", header: headernuklear.}
proc filter_ascii*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_ascii", header: headernuklear.}
proc filter_float*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_float", header: headernuklear.}
proc filter_decimal*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_decimal", header: headernuklear.}
proc filter_hex*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_hex", header: headernuklear.}
proc filter_oct*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_oct", header: headernuklear.}
proc filter_binary*(a2: ptr text_edit; unicode: rune): cint {.cdecl,
    importc: "nk_filter_binary", header: headernuklear.}
proc textedit_init_default*(a2: ptr text_edit) {.cdecl,
    importc: "nk_textedit_init_default", header: headernuklear.}
proc textedit_init*(a2: ptr text_edit; a3: ptr allocator; size: size) {.cdecl,
    importc: "nk_textedit_init", header: headernuklear.}
proc textedit_init_fixed*(a2: ptr text_edit; memory: pointer; size: size) {.cdecl,
    importc: "nk_textedit_init_fixed", header: headernuklear.}
proc textedit_free*(a2: ptr text_edit) {.cdecl, importc: "nk_textedit_free",
                                     header: headernuklear.}
proc textedit_text*(a2: ptr text_edit; a3: cstring; total_len: cint) {.cdecl,
    importc: "nk_textedit_text", header: headernuklear.}
proc textedit_delete*(a2: ptr text_edit; where: cint; len: cint) {.cdecl,
    importc: "nk_textedit_delete", header: headernuklear.}
proc textedit_delete_selection*(a2: ptr text_edit) {.cdecl,
    importc: "nk_textedit_delete_selection", header: headernuklear.}
proc textedit_select_all*(a2: ptr text_edit) {.cdecl,
    importc: "nk_textedit_select_all", header: headernuklear.}
proc textedit_cut*(a2: ptr text_edit): cint {.cdecl, importc: "nk_textedit_cut",
    header: headernuklear.}
proc textedit_paste*(a2: ptr text_edit; a3: cstring; len: cint): cint {.cdecl,
    importc: "nk_textedit_paste", header: headernuklear.}
proc textedit_undo*(a2: ptr text_edit) {.cdecl, importc: "nk_textedit_undo",
                                     header: headernuklear.}
proc textedit_redo*(a2: ptr text_edit) {.cdecl, importc: "nk_textedit_redo",
                                     header: headernuklear.}






proc stroke_line*(b: ptr command_buffer; x0: cfloat; y0: cfloat; x1: cfloat; y1: cfloat;
                 line_thickness: cfloat; a8: color) {.cdecl,
    importc: "nk_stroke_line", header: headernuklear.}
proc stroke_curve*(a2: ptr command_buffer; a3: cfloat; a4: cfloat; a5: cfloat; a6: cfloat;
                  a7: cfloat; a8: cfloat; a9: cfloat; a10: cfloat;
                  line_thickness: cfloat; a12: color) {.cdecl,
    importc: "nk_stroke_curve", header: headernuklear.}
proc stroke_rect*(a2: ptr command_buffer; a3: rect; rounding: cfloat;
                 line_thickness: cfloat; a6: color) {.cdecl,
    importc: "nk_stroke_rect", header: headernuklear.}
proc stroke_circle*(a2: ptr command_buffer; a3: rect; line_thickness: cfloat; a5: color) {.
    cdecl, importc: "nk_stroke_circle", header: headernuklear.}
proc stroke_arc*(a2: ptr command_buffer; cx: cfloat; cy: cfloat; radius: cfloat;
                a_min: cfloat; a_max: cfloat; line_thickness: cfloat; a9: color) {.
    cdecl, importc: "nk_stroke_arc", header: headernuklear.}
proc stroke_triangle*(a2: ptr command_buffer; a3: cfloat; a4: cfloat; a5: cfloat;
                     a6: cfloat; a7: cfloat; a8: cfloat; line_thichness: cfloat;
                     a10: color) {.cdecl, importc: "nk_stroke_triangle",
                                 header: headernuklear.}
proc stroke_polyline*(a2: ptr command_buffer; points: ptr cfloat; point_count: cint;
                     line_thickness: cfloat; col: color) {.cdecl,
    importc: "nk_stroke_polyline", header: headernuklear.}
proc stroke_polygon*(a2: ptr command_buffer; a3: ptr cfloat; point_count: cint;
                    line_thickness: cfloat; a6: color) {.cdecl,
    importc: "nk_stroke_polygon", header: headernuklear.}
proc fill_rect*(a2: ptr command_buffer; a3: rect; rounding: cfloat; a5: color) {.cdecl,
    importc: "nk_fill_rect", header: headernuklear.}
proc fill_rect_multi_color*(a2: ptr command_buffer; a3: rect; left: color; top: color;
                           right: color; bottom: color) {.cdecl,
    importc: "nk_fill_rect_multi_color", header: headernuklear.}
proc fill_circle*(a2: ptr command_buffer; a3: rect; a4: color) {.cdecl,
    importc: "nk_fill_circle", header: headernuklear.}
proc fill_arc*(a2: ptr command_buffer; cx: cfloat; cy: cfloat; radius: cfloat;
              a_min: cfloat; a_max: cfloat; a8: color) {.cdecl, importc: "nk_fill_arc",
    header: headernuklear.}
proc fill_triangle*(a2: ptr command_buffer; x0: cfloat; y0: cfloat; x1: cfloat;
                   y1: cfloat; x2: cfloat; y2: cfloat; a9: color) {.cdecl,
    importc: "nk_fill_triangle", header: headernuklear.}
proc fill_polygon*(a2: ptr command_buffer; a3: ptr cfloat; point_count: cint; a5: color) {.
    cdecl, importc: "nk_fill_polygon", header: headernuklear.}
proc draw_image*(a2: ptr command_buffer; a3: rect; a4: ptr img; a5: color) {.cdecl,
    importc: "nk_draw_image", header: headernuklear.}
proc draw_text*(a2: ptr command_buffer; a3: rect; text: cstring; len: cint;
               a6: ptr user_font; a7: color; a8: color) {.cdecl,
    importc: "nk_draw_text", header: headernuklear.}
proc push_scissor*(a2: ptr command_buffer; a3: rect) {.cdecl,
    importc: "nk_push_scissor", header: headernuklear.}
proc push_custom*(a2: ptr command_buffer; a3: rect; a4: command_custom_callback;
                 usr: handle) {.cdecl, importc: "nk_push_custom",
                              header: headernuklear.}





proc input_has_mouse_click*(a2: ptr input; a3: buttons): cint {.cdecl,
    importc: "nk_input_has_mouse_click", header: headernuklear.}
proc input_has_mouse_click_in_rect*(a2: ptr input; a3: buttons; a4: rect): cint {.cdecl,
    importc: "nk_input_has_mouse_click_in_rect", header: headernuklear.}
proc input_has_mouse_click_down_in_rect*(a2: ptr input; a3: buttons; a4: rect;
                                        down: cint): cint {.cdecl,
    importc: "nk_input_has_mouse_click_down_in_rect", header: headernuklear.}
proc input_is_mouse_click_in_rect*(a2: ptr input; a3: buttons; a4: rect): cint {.cdecl,
    importc: "nk_input_is_mouse_click_in_rect", header: headernuklear.}
proc input_is_mouse_click_down_in_rect*(i: ptr input; id: buttons; b: rect; down: cint): cint {.
    cdecl, importc: "nk_input_is_mouse_click_down_in_rect", header: headernuklear.}
proc input_any_mouse_click_in_rect*(a2: ptr input; a3: rect): cint {.cdecl,
    importc: "nk_input_any_mouse_click_in_rect", header: headernuklear.}
proc input_is_mouse_prev_hovering_rect*(a2: ptr input; a3: rect): cint {.cdecl,
    importc: "nk_input_is_mouse_prev_hovering_rect", header: headernuklear.}
proc input_is_mouse_hovering_rect*(a2: ptr input; a3: rect): cint {.cdecl,
    importc: "nk_input_is_mouse_hovering_rect", header: headernuklear.}
proc input_mouse_clicked*(a2: ptr input; a3: buttons; a4: rect): cint {.cdecl,
    importc: "nk_input_mouse_clicked", header: headernuklear.}
proc input_is_mouse_down*(a2: ptr input; a3: buttons): cint {.cdecl,
    importc: "nk_input_is_mouse_down", header: headernuklear.}
proc input_is_mouse_pressed*(a2: ptr input; a3: buttons): cint {.cdecl,
    importc: "nk_input_is_mouse_pressed", header: headernuklear.}
proc input_is_mouse_released*(a2: ptr input; a3: buttons): cint {.cdecl,
    importc: "nk_input_is_mouse_released", header: headernuklear.}
proc input_is_key_pressed*(a2: ptr input; a3: keys): cint {.cdecl,
    importc: "nk_input_is_key_pressed", header: headernuklear.}
proc input_is_key_released*(a2: ptr input; a3: keys): cint {.cdecl,
    importc: "nk_input_is_key_released", header: headernuklear.}
proc input_is_key_down*(a2: ptr input; a3: keys): cint {.cdecl,
    importc: "nk_input_is_key_down", header: headernuklear.}
type
  draw_index* = ushort
  draw_list_stroke* {.size: sizeof(cint).} = enum
    STROKE_OPEN = false, STROKE_CLOSED = true

const
  FORMAT_R8G8B8 = FORMAT_COLOR_BEGIN
  FORMAT_COLOR_END = FORMAT_RGBA32

proc draw_list_init*(a2: ptr draw_list) {.cdecl, importc: "nk_draw_list_init",
                                      header: headernuklear.}
proc draw_list_setup*(a2: ptr draw_list; a3: ptr convert_config; cmds: ptr buffer;
                     vertices: ptr buffer; elements: ptr buffer;
                     line_aa: anti_aliasing; shape_aa: anti_aliasing) {.cdecl,
    importc: "nk_draw_list_setup", header: headernuklear.}
proc draw_list_begin*(a2: ptr draw_list; a3: ptr buffer): ptr draw_command {.cdecl,
    importc: "nk__draw_list_begin", header: headernuklear.}
proc draw_list_next*(a2: ptr draw_command; a3: ptr buffer; a4: ptr draw_list): ptr draw_command {.
    cdecl, importc: "nk__draw_list_next", header: headernuklear.}
proc draw_list_end*(a2: ptr draw_list; a3: ptr buffer): ptr draw_command {.cdecl,
    importc: "nk__draw_list_end", header: headernuklear.}
proc draw_list_path_clear*(a2: ptr draw_list) {.cdecl,
    importc: "nk_draw_list_path_clear", header: headernuklear.}
proc draw_list_path_line_to*(a2: ptr draw_list; pos: vec2) {.cdecl,
    importc: "nk_draw_list_path_line_to", header: headernuklear.}
proc draw_list_path_arc_to_fast*(a2: ptr draw_list; center: vec2; radius: cfloat;
                                a_min: cint; a_max: cint) {.cdecl,
    importc: "nk_draw_list_path_arc_to_fast", header: headernuklear.}
proc draw_list_path_arc_to*(a2: ptr draw_list; center: vec2; radius: cfloat;
                           a_min: cfloat; a_max: cfloat; segments: cuint) {.cdecl,
    importc: "nk_draw_list_path_arc_to", header: headernuklear.}
proc draw_list_path_rect_to*(a2: ptr draw_list; a: vec2; b: vec2; rounding: cfloat) {.
    cdecl, importc: "nk_draw_list_path_rect_to", header: headernuklear.}
proc draw_list_path_curve_to*(a2: ptr draw_list; p2: vec2; p3: vec2; p4: vec2;
                             num_segments: cuint) {.cdecl,
    importc: "nk_draw_list_path_curve_to", header: headernuklear.}
proc draw_list_path_fill*(a2: ptr draw_list; a3: color) {.cdecl,
    importc: "nk_draw_list_path_fill", header: headernuklear.}
proc draw_list_path_stroke*(a2: ptr draw_list; a3: color; closed: draw_list_stroke;
                           thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_path_stroke", header: headernuklear.}
proc draw_list_stroke_line*(a2: ptr draw_list; a: vec2; b: vec2; a5: color;
                           thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_stroke_line", header: headernuklear.}
proc draw_list_stroke_rect*(a2: ptr draw_list; rect: rect; a4: color; rounding: cfloat;
                           thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_stroke_rect", header: headernuklear.}
proc draw_list_stroke_triangle*(a2: ptr draw_list; a: vec2; b: vec2; c: vec2; a6: color;
                               thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_stroke_triangle", header: headernuklear.}
proc draw_list_stroke_circle*(a2: ptr draw_list; center: vec2; radius: cfloat;
                             a5: color; segs: cuint; thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_stroke_circle", header: headernuklear.}
proc draw_list_stroke_curve*(a2: ptr draw_list; p0: vec2; cp0: vec2; cp1: vec2; p1: vec2;
                            a7: color; segments: cuint; thickness: cfloat) {.cdecl,
    importc: "nk_draw_list_stroke_curve", header: headernuklear.}
proc draw_list_stroke_poly_line*(a2: ptr draw_list; pnts: ptr vec2; cnt: cuint;
                                a5: color; a6: draw_list_stroke; thickness: cfloat;
                                a8: anti_aliasing) {.cdecl,
    importc: "nk_draw_list_stroke_poly_line", header: headernuklear.}
proc draw_list_fill_rect*(a2: ptr draw_list; rect: rect; a4: color; rounding: cfloat) {.
    cdecl, importc: "nk_draw_list_fill_rect", header: headernuklear.}
proc draw_list_fill_rect_multi_color*(a2: ptr draw_list; rect: rect; left: color;
                                     top: color; right: color; bottom: color) {.cdecl,
    importc: "nk_draw_list_fill_rect_multi_color", header: headernuklear.}
proc draw_list_fill_triangle*(a2: ptr draw_list; a: vec2; b: vec2; c: vec2; a6: color) {.
    cdecl, importc: "nk_draw_list_fill_triangle", header: headernuklear.}
proc draw_list_fill_circle*(a2: ptr draw_list; center: vec2; radius: cfloat; col: color;
                           segs: cuint) {.cdecl,
                                        importc: "nk_draw_list_fill_circle",
                                        header: headernuklear.}
proc draw_list_fill_poly_convex*(a2: ptr draw_list; points: ptr vec2; count: cuint;
                                a5: color; a6: anti_aliasing) {.cdecl,
    importc: "nk_draw_list_fill_poly_convex", header: headernuklear.}
proc draw_list_add_image*(a2: ptr draw_list; texture: img; rect: rect; a5: color) {.
    cdecl, importc: "nk_draw_list_add_image", header: headernuklear.}
proc draw_list_add_text*(a2: ptr draw_list; a3: ptr user_font; a4: rect; text: cstring;
                        len: cint; font_height: cfloat; a8: color) {.cdecl,
    importc: "nk_draw_list_add_text", header: headernuklear.}



proc style_item_image*(img: img): style_item {.cdecl,
    importc: "nk_style_item_image", header: headernuklear.}
proc style_item_color*(a2: color): style_item {.cdecl,
    importc: "nk_style_item_color", header: headernuklear.}
proc style_item_hide*(): style_item {.cdecl, importc: "nk_style_item_hide",header: headernuklear.}
