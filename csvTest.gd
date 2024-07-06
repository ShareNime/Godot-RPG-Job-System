extends Control

var path = "res://resource/class.csv"
@onready var cardClass = preload("res://resource/class_card_scene.tscn")
@onready var skillIcon = preload("res://resource/skillIcon.tscn")
@export var classCardContainer : Control
@export var mainPanel : Control

@export var choosenPanel : Control
@export var chooseLabel : Label
@export var chooseDescriptionLabel : Label
@export var resetChooseButton : Button
@export var choosenSkillContainer : BoxContainer
@export var choosenClassSpriteLeft : AnimatedSprite2D
@export var choosenClassSpriteRight : AnimatedSprite2D


var classes = {

}
# Called when the node enters the scene tree for the first time.
func _ready():
	var data = getData()
	loadClasses(data)
	print(classes)
	#print(classes[1].JOBNAME)
	pass # Replace with function body.
	parseSkill()
	print(classes)
	instantiateClassCards()
	$Label.text = str(1)
	
	$Label.text = str(data.size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func instantiateClassCards():
	for key in classes.keys():
		var card = cardClass.instantiate()
		card.className = classes[key]["JOBNAME"]
		card.classId = key
		card.classDescription = classes[key]["DESCRIPTION"]
		card.classSkills = classes[key]["SKILLS"]
		classCardContainer.add_child(card)
		card.connect("classIDChoosen",getChoosenClass)		

func getChoosenClass(value):
	choosenPanel.show()
	#$Panel/Control2.show()
	mainPanel.hide()
	#$Panel/Control.hide()
	print(classes[value])
	chooseLabel.text = classes[value]["JOBNAME"]
	chooseDescriptionLabel.text = classes[value]["DESCRIPTION"]
	for skill in classes[value]["SKILLS"]:
		var icon = skillIcon.instantiate()
		icon.skillName = skill
		choosenSkillContainer.add_child(icon)
		
	if ResourceLoader.exists("res://resource/sprite/" + classes[value]["JOBNAME"] + "Anim.tres"):
		choosenClassSpriteLeft.sprite_frames = load("res://resource/sprite/" + classes[value]["JOBNAME"] + "Anim.tres")
		choosenClassSpriteRight.sprite_frames = load("res://resource/sprite/" + classes[value]["JOBNAME"] + "Anim.tres")	
		choosenClassSpriteLeft.play("sit")
		choosenClassSpriteRight.play("idle")
	
	pass

func loadClasses(data):
	var header = data[0]
	for i in range(1, data.size()):
		classes[data[i][0]] = {}
		for j in range(header.size()):
			classes[data[i][0]][header[j]] = data[i][j]

func parseSkill():
	for key in classes.keys():
		var skills = classes[key]["SKILLS"].strip_edges().split(";")
		var temp_skill_filter = []
		for skill in skills:
			if skill != "":
				temp_skill_filter.append(skill)
		classes[key]["SKILLS"] = temp_skill_filter

func getData():
	var mainData = {}
	var file = FileAccess.open(path, FileAccess.READ)
	while !file.eof_reached():
		var dataset = Array(file.get_csv_line())
		mainData[mainData.size()] = dataset
	file.close()
	#print(mainData)
	return mainData


func _on_reset_choose_pressed():
	
	for child in choosenSkillContainer.get_children():
		child.queue_free()
	print(choosenSkillContainer.position)
	
	mainPanel.show()
	choosenPanel.hide()
	#$Panel/Control.show()
	#$Panel/Control2.hide()
	
	pass # Replace with function body.
