
package main
import "core:math/linalg"
import "core:fmt"
print :: fmt.println

vec2 :: [2]f32 

Node :: struct {
	parent: ^Node,
	position: vec2,
	g, h, f : f32,
}


a_star :: proc(game: ^GameState) -> [dynamic]vec2{
	using game


	start_node : Node;
	start_node.position = start_pos

	end_node: Node;
	end_node.position = end_pos

	open_list :[dynamic]^Node
	closed_list :[dynamic]^Node

	append(&open_list, &start_node)
	adj_pos :[]vec2 = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}}

	for len(open_list) > 0{

		curr_node := open_list[0]
		curr_index := 0

		for item, index in open_list{
			if item.f < curr_node.f{
				curr_node = item
				curr_index = index
			}
		}
		//pop current off open list, add to closed list
		unordered_remove(&open_list, curr_index)
		append(&closed_list, curr_node)

		if curr_node.position == end_node.position{
			path :[dynamic]vec2 

			curr := curr_node
			for curr != nil{
				append(&path, curr.position)
				curr = curr.parent
			}

			return path
		}


		children :[dynamic]Node


		for new_pos in adj_pos{
			node_pos := curr_node.position + new_pos

			if node_pos[0] > f32(len(maze) - 1) || node_pos[0] < 0 || node_pos[1] > f32(len(maze[len(maze)-1]) -1) || node_pos[1] < 0{
				continue
			}

			if maze[int(node_pos[0])][int(node_pos[1])] != 0.0{
				continue
			}

			new_node:Node
			new_node.parent = curr_node
			new_node.position = node_pos
			append(&children, new_node)
		}

		for child in &children{

			is_in_closed_list := false
			for closed_child in closed_list{
				if child.position == closed_child.position{
					is_in_closed_list = true
				}
			}

			if is_in_closed_list{
				continue
			}

			child.g = curr_node.g + 1
			child.h = linalg.length(child.position - end_node.position)
			child.f = child.g + child.h

			is_in_open_list := false
			for open_child in open_list{
				if child.position == open_child.position{
					is_in_open_list = true
				}
			}
			if(is_in_open_list){
				continue
			}

			append(&open_list, &child)
		}
	}

	return nil
}























