extends Control

@onready var skillIcon = preload("res://resource/skillIcon.tscn")

@export var classNameLabel : Label
@export var classIdLabel : Label
@export var classDescriptionLabel : Label
@export var classSkillBoxContainer : Control
@export var classAnim : AnimatedSprite2D
const ANIMPATH : String = "res://resource/sprite/"
signal classIDChoosen(classID)
var className : String
var classId : String
var classDescription : String
var classSkills : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	initUI()
	pass # Replace with function body.

func initUI():
	classIdLabel.text = classId
	classNameLabel.text = className
	classDescriptionLabel.text = classDescription
	for skill in classSkills:
		var icon = skillIcon.instantiate()
		icon.skillName = skill
		classSkillBoxContainer.add_child(icon)
	if ResourceLoader.exists(ANIMPATH + className + "Anim.tres"):
		classAnim.sprite_frames = load("res://resource/sprite/" + className + "Anim.tres")
		classAnim.play("sit")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_panel_mouse_entered():
	if ResourceLoader.exists(ANIMPATH + className + "Anim.tres"):
		classAnim.play("idle")
		pass
	pass # Replace with function body.


func _on_panel_mouse_exited():
	if ResourceLoader.exists(ANIMPATH + className + "Anim.tres"):
		classAnim.play("sit")
		pass
	pass # Replace with function body.


func _on_choose_class_button_pressed():
	classIDChoosen.emit(classId)
	pass # Replace with function body.
