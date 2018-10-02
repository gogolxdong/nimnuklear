##  nuklear - v1.00 - public domain

import nimnuklear/nuklear except true, false, char

import strformat, strutils

## FIXME: Necessary in order to combine panel flags.  This should really
##        be a part of the bindings.
# proc `or`(a, b :panel_flags): panel_flags =
#   return panel_flags(a.cint or b.cint)

proc calculator*(ctx: ptr context) =
  if begin(ctx, "Calculator", rect(x:10, y:10, w:180, h:250),
           flags WINDOW_BORDER.cint or WINDOW_NO_SCROLLBAR.cint or WINDOW_MOVABLE.cint) != 0:
    var
      set {.global.}: bool = false
      prev {.global.}: char = '\0'
      op {.global.}: char = '\0'
      numbers {.global.}: cstring = "789456123"
      ops {.global.}: cstring = "+-*/"
      a {.global.}: float = 0
      b {.global.}: float = 0
      current {.global.}: ptr float = addr a
      # current {.global.}: cstring = cast[cstring](alloc0(256))
      solve: bool = false

    var len: cint # string editor
    var buffer: array[256, char] # string editor
    var buffercs: cstring = cast[cstring](addr buffer[0])

    nuklear.layout_row_dynamic(ctx, 35, 1)
    var curstring = current[].formatFloat(ffDecimal, 2)
    copyMem(buffercs, curstring.cstring, curstring.len)
    buffer[curstring.len + 1] = '\0'
    len = curstring.len.cint
    discard nuklear.edit_string(ctx, EDIT_SIMPLE.flags, buffercs, addr(len), 255, filter_default)
    buffer[len] = '\0'
    current[] = parseFloat($buffercs)
    echo a
        

    # nuklear.layout_row_dynamic(ctx, 35, 4)
    # for i in 0..15:
    #   if i >= 12 and i < 15:
    #     if i > 12:
    #       continue
    #     if nuklear.button_label(ctx, "C") != 0:
    #       a = 0; b = 0; op = '\0'
    #       current = addr(a)
    #       set = false
    #     if nuklear.button_label(ctx, "0") != 0:
    #       current[] = current[] * 10.0
    #       set = false
    #     if nuklear.button_label(ctx, "=") != 0:
    #       solve = true
    #       prev = op
    #       op = '\0'
    #   elif ((i + 1) mod 4) != 0:
    #     if nuklear.button_text(ctx, addr(numbers[(i div 4) * 3 + i mod 4]), 1) != 0:
    #       current[] = current[] * 10.0 + float(numbers[(i div 4) * 3 + i mod 4].ord - '0'.ord)
    #       set = false
    #   elif nuklear.button_text(ctx, addr(ops[i div 4]), 1) != 0:
    #     if not set:
    #       if current != addr(b):
    #         current = addr(b)
    #       else:
    #         prev = op
    #         solve = true
    #     op = ops[i div 4]
    #     set = true

    # if solve:
    #   if prev == '+':
    #     a = a + b
    #   if prev == '-':
    #     a = a - b
    #   if prev == '*':
    #     a = a * b
    #   if prev == '/':
    #     a = a / b
    #   current = addr(a)
    #   if set:
    #     current = addr(b)
    #   b = 0
    #   set = false
  nuklear.end(ctx)
