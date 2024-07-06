extends TextureRect

var skillName : String
const SKILLPATH : String = "res://resource/skillIcon/"
@export var skillNameLabel : Label
# Called when the node enters the scene tree for the first time.
func _ready():
	#texture = load("res://resource/skillIcon/Break Shield.png")
	skillNameLabel.text = skillName
	if ResourceLoader.exists(SKILLPATH + skillName + ".png"):
		texture = load(SKILLPATH + skillName + ".png")
	else:
		texture = load("res://icon.svg")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	skillNameLabel.show()
	pass # Replace with function body.


func _on_mouse_exited():
	skillNameLabel.hide()
	
	pass # Replace with function body.
