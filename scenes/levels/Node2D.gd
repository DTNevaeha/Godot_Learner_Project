extends Node2D

export var width: int = 8
export var height: int = 8

var minSizeOfSquares: float = 0.0
var offset: Vector2 = Vector2(50,50)
var board_size: Vector2

func _ready():
    board_size = get_viewport_rect().size
    # board_size = Vector2(400,400)
    findSizeOfSquares()
    # update()

func findSizeOfSquares():
    minSizeOfSquares = 20

func _draw():
    var i: int = 0
    
    for x in width:
        if width % 2 == 0 and height % 2 == 0:
            i += 1

        for y in height:
            var rect = Rect2(Vector2(x*minSizeOfSquares, y*minSizeOfSquares), Vector2(minSizeOfSquares, minSizeOfSquares))
            var col = Color.BLACK if (i % 2) else Color.WHITE
            draw_rect(rect, col)
            i += 1
