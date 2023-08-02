package main

import rl "vendor:raylib"
import time "core:time"


GameState :: struct {
	height : int,
	width : int,
	maze: [10][10]f32,
	start_pos : vec2,
	end_pos   : vec2,
	path :[dynamic]vec2,
	path_travelled : int
}

draw_grid :: proc(game: ^GameState){
	using rl

    for y in 0..<10 {
        for x in 0..<10{

        	val := game.maze[x][y]
            index := y * game.width + x
            //color := colors[world.alive[index]]

            rect := rl.Rectangle{
                x      = f32(x) * 100,
                y      = f32(y) * 100,
                width  = 100,
                height = 100,
            }
            if(game.start_pos == vec2{f32(x), f32(y)}){
            	rl.DrawRectangleRec(rect, rl.GREEN)
            	DrawRectangleLinesEx(rect, 1, rl.GREEN)
            }
            else if(game.end_pos == vec2{f32(x), f32(y)}){
            	rl.DrawRectangleRec(rect, rl.GREEN)
            	DrawRectangleLinesEx(rect, 1, rl.GREEN)
            }
            else if(val == 0.0){
            	rl.DrawRectangleRec(rect, rl.WHITE)
            	DrawRectangleLinesEx(rect, 1, rl.BLACK)
            }else{
            	rl.DrawRectangleRec(rect, rl.YELLOW)
            }
        }
    }

    for i in 0..<game.path_travelled{
    	pos := game.path[i]
    	rect := rl.Rectangle{
    		x      = pos.x * 100,
    		y      = pos.y * 100,
    		width  = 100,
    		height = 100,
    	}
    	rl.DrawRectangleRec(rect, rl.BLUE)
    	DrawRectangleLinesEx(rect, 1, rl.BLUE)
    }
}

main :: proc (){
	using rl

	game :GameState
	game.maze = 
	{{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}};



	InitWindow(1024, 1024, "A Star search")

	configs :ConfigFlags={.WINDOW_RESIZABLE}
	SetWindowState(configs)

	SetTargetFPS(GetFPS())

	game.start_pos ={0,0 }
	game.end_pos ={7,6 }
	game.path = a_star(&game)

	tick_rate := 300 * time.Millisecond
	last_time := time.now()

	for !WindowShouldClose(){

		if time.since(last_time) > tick_rate{
			last_time = time.now()
			if(game.path_travelled >= len(game.path)){
				game.path_travelled = 0
			}else{
				game.path_travelled += 1
			}
		}

		BeginDrawing()
		ClearBackground(rl.GRAY)
		draw_grid(&game)
		EndDrawing()
	}

}





















