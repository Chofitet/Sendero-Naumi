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
		ControlLabel("[center]VAYA...
¡PARECE QUE HAS ENCONTRADO ALGO ESPECIAL![/center]", false,5.5)
	if  position.y <= (-view_port_size_y - 1200) && !once2:
		once2 = true
		ControlLabel("[center]ESTO ES [b]SENDERO NAUMI[/b]
UNA NUEVA FORMA DE RECORRER EL MUSEO[/center]",false,7.5)
	if position.y <= (-view_port_size_y - 3000) && !once3:
		once3 = true
		ControlLabel("[center]CUANDO ENCUENTRES
ALGUNO DE ESTOS LUGARES EN EL MUSEO
APRETALO EN EL MAPA PARA EMPEZAR A JUGAR[/center]",true,10000)
		
	
func ControlLabel(txt,adjust,time):
	var control = get_parent().get_node("LabelControl")
	control.visible = true
	control.get_node("Panel/RichTextLabel").text = txt
	#if adjust:
	#	control.get_node("Panel/RichTextLabel").position.y = 37
	#	control.get_node("Panel/RichTextLabel").size.y = 155
	await  get_tree().create_timer(time).timeout
	control.visible = false

	
func ScrollStop():
	stopscroll.emit()
