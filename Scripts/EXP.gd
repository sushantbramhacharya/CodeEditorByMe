extends TextEdit

var auto_compelete_right = [ "'", "{", '"', "(", "["]
var auto_compelete_left  = ["'", "}", '"', ")", "]"]

func auto_complete():
	if InputEventAction:
		select(cursor_get_line(), cursor_get_column() - 1, cursor_get_line() , cursor_get_column())
		var key = get_selection_text()
		select(cursor_get_line(), cursor_get_column(), cursor_get_line(), cursor_get_column())
		for i in range(5):
			if key == auto_compelete_right[i]:
				insert_text_at_cursor(auto_compelete_left[i])
				cursor_set_column(cursor_get_column() - 1)


var keywords = [
	"public", "private",
	"partial", "static",
	"namespace", "class",
	"using", "void",
	"foreach", "in",
	"if", "else",
	"return"
]

func color_syntax():
	for i in keywords:
		add_keyword_color(i , Color.red)
	add_color_region("//", "\n", Color.gray, true)
	add_color_region("/*", "*/" , Color.gray , false)
	add_color_region("'", "'" , Color.green, false)
	add_color_region('"', '"', Color.green, false)

