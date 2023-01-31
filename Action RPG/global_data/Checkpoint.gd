extends CollisionShape2D

export var checkpoint_num = 0

func _on_Checkpoint_body_entered(body):
	GlobalData.current_data["checkpoint"] = checkpoint_num
	GlobalData.save_data(GlobalData.player_file_path)
	print("Game Saved")
