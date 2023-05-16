extends Area3D

var other_mesh_instance: MeshInstance3D

func _ready():
	var mesh_name = String(get_name())
	if mesh_name[mesh_name.length() - 1] == 'A':
		# Change the last letter to 'B'
		mesh_name = mesh_name.substr(0, mesh_name.length() - 1) + 'B'
		
		other_mesh_instance = load("res://Objects/" + mesh_name + ".tscn").instance()
		
	elif mesh_name[mesh_name.length() - 1] == 'B':
		# Change the last letter to 'A'
		mesh_name = mesh_name.substr(0, mesh_name.length() - 1) + 'A'
		
		other_mesh_instance = load("res://Objects/" + mesh_name + ".tscn").instance()
	
	var static_body = get_node("static_cube")
	static_body.set_collision_layer(0)
	static_body.set_collision_mask(0)
	

func _on_body_entered(body):
	print("Entered!!!")


func _on_body_exited(body):
	var coll = get_node("collision_shape")
	var size_coll = coll.shape.extents * 4.3
	var pos = coll.global_transform.origin
	print("this shit: ", pos)
	var new_mesh = MeshInstance3D.new()
	new_mesh.mesh = BoxMesh.new()
	new_mesh.mesh.size = size_coll
	var local_pos = coll.to_local(pos)
	new_mesh.set_global_transform(Transform3D(Basis(), local_pos))
	add_child(new_mesh) 
	
	print("Exited!!!!")
	
	var static_body = get_node("static_cube")
	static_body.set_collision_layer(1)
	static_body.set_collision_mask(1)
	
	var static_body_of_neighbour_object = other_mesh_instance.get_node("static_cube")
	static_body.set_collision_layer(1)
	static_body.set_collision_mask(1)
