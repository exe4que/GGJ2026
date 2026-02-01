extends Area3D

func _ready() -> void:
	self.area_entered.connect(_on_area_body_entered)
	self.area_exited.connect(_on_area_body_exited)
	print("holaaa")
	

func _on_area_body_entered(body):
	print(str(body.name, " detectadoooooo!!!!!!"))

func _on_area_body_exited(body):
	print(str(body.name, " chauuuuuuuu!!!!!!"))
