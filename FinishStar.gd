extends Area2D

export(String, FILE, "*tscn") var world_scene

func _on_FinishStar_body_entered(body):
	get_tree().change_scene(world_scene)
