extends VBoxContainer
var view_port_size_x 
var view_port_size_y
@export var scrollDuration : float
@export var LastMarginConteiner : MarginContainer
var once1 
var once2
var once3
signal stopscroll

func _ready():
	view_port_size_x = get_viewport_rect().size.x
	view_port_size_y = get_viewport_rect().size.y
	add_theme_constant_override("Separation", view_port_size_y/2) 
	position.x = view_port_size_x/2
	if view_port_size_y > 1280:
		LastMarginConteiner.add_theme_constant_override("margin_top", get_viewport_rect().size.y - 1280) 


func ScrollScreen():
	var tween = get_tree().create_tween()
	tween.finished.connect(ScrollStop)
	tween.tween_property(self,"position", Vector2(position.x,-view_port_size_y - 4000),scrollDuration).set_ease(Tween.EASE_IN_OUT)
	

func _process(delta):
	if position.y <= (-view_port_size_y + (view_port_size_y/4)) && !once1:
		once1 = true
		ControlLabel("¡HOLA!
		ESTO ES SENDERO NAUMI. 
		UN LUGAR PARA APRENDER EXPLORANDO Y DIVERTIRSE.")
	if  position.y <= (-view_port_size_y - 2000) && !once2:
		once2 = true
		ControlLabel("COMO VERAS
		HAY MUCHO POR EXPLORAR")
	if position.y <= (-view_port_size_y - 3500) && !once3:
		once3 = true
		ControlLabel("CUANDO ENCUENTRES ALGUNO DE ESTOS LUGARES EN EL MUSEO APRETALO EN EL MAPA PARA EMPEZAR A JUGAR")
		
	
func ControlLabel(txt):
	var control = get_parent().get_node("LabelControl")
	control.visible = true
	control.get_node("Label").text = txt

func ScrollStop():
	stopscroll.emit()
