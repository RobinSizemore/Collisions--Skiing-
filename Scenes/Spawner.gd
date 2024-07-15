extends Node3D

var tree_scene = preload("res://Scenes/tree.tscn") # Load the tree scene

func _ready():
	spawn_trees(30) # Spawn 10 trees

func spawn_trees(number_of_trees):
	for i in range(number_of_trees):
		var tree_instance = tree_scene.instantiate()
		var random_x = randi_range(-5, 5) # Assuming the center of the slope is at x = 0
		var random_z = randi_range(0, -200) # Length of the slope
		var start_position = Vector3(random_x, 10, random_z) # Start above the slope
		var end_position = Vector3(random_x, -75, random_z) # End below the slope

		var space_state = get_world_3d().direct_space_state
		var ray = PhysicsRayQueryParameters3D.create(start_position, end_position)
		var result = space_state.intersect_ray(ray)

		if result.size() != 0: # If the raycast hit the slope
			print("Tree spawned at: ", result.position)
			tree_instance.global_position = result.position
			get_tree().root.add_child.call_deferred(tree_instance) # Add the tree instance to the scene
		else:
			print("Tree not spawned, no collision detected at " + str(start_position) + " to " + str(end_position))

