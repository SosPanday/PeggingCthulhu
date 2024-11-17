extends StaticBody2D

@export var life = 2


# Called when the node enters the scene tree for the first time.

	
func damage():
	if(life >= 1):
		life -= 1
		print("-1 Leben")
	elif(life < 1):
		deleteMe()
func deleteMe():
	queue_free()
