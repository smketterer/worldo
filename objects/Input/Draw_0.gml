var i, h, ptext;
ptext = string_replace_all(text, "#", "�")
draw_text(x, y, string_hash_to_newline(ptext))
i = string_width(string_hash_to_newline(string_copy(ptext, 1, caret)))
h = string_height(string_hash_to_newline("\\\\"))
draw_line(x+i,y+1,x+i,y+h-1)