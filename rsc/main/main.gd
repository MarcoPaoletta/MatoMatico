extends Control

var numero1 = null
var numero2 = null
var resultado = 0
var operacion = ""
onready var res = $Resultado

func _on_0_pressed():
	res.set_text(res.get_text() + "0")

func _on_3_pressed():
	res.set_text(res.get_text() + "3")

func _on_2_pressed():
	res.set_text(res.get_text() + "2")

func _on_1_pressed():
	res.set_text(res.get_text() + "1")

func _on_6_pressed():
	res.set_text(res.get_text() + "6")

func _on_5_pressed():
	res.set_text(res.get_text() + "5")

func _on_4_pressed():
	res.set_text(res.get_text() + "4")

func _on_9_pressed():
	res.set_text(res.get_text() + "9")

func _on_8_pressed():
	res.set_text(res.get_text() + "8")

func _on_7_pressed():
	res.set_text(res.get_text() + "7")

func _on_punto_pressed():
	var punto = false
	for i in res.get_text():
		if i == ".":
			punto = true
	if !punto:
		res.set_text(res.get_text() + ".")

func _on_borrarTodo_pressed():
	numero1 = null
	numero2 = null
	res.set_text("")

func _on_borrar_pressed():
	var text = []
	for i in res.get_text():
		text.append(i)
	text.remove(text.size() - 1)
	res.set_text("")
	for i in text:
		res.set_text(res.get_text() + i)

func _on_dividir_pressed():
	operacion = "dividir"
	if numero1 == null:
		numero1 = float(res.get_text())
		res.set_text("")
	else:
		numero2 = float(res.get_text())
		realizar_operacion(operacion)

func _on_multiplicar_pressed():
	operacion = "multiplicar"
	if numero1 == null:
		numero1 = float(res.get_text())
		res.set_text("")
	else:
		numero2 = float(res.get_text())
		realizar_operacion(operacion)

func _on_restar_pressed():
	operacion = "restar"
	if numero1 == null:
		numero1 = float(res.get_text())
		res.set_text("")
	else:
		numero2 = float(res.get_text())
		realizar_operacion(operacion)

func _on_sumar_pressed():
	operacion = "sumar"
	if numero1 == null:
		numero1 = float(res.get_text())
		res.set_text("")
	else:
		numero2 = float(res.get_text())
		realizar_operacion(operacion)

func _on_calcular_pressed():
	realizar_operacion(operacion)

func realizar_operacion(op):
	if numero2 == null:
		numero2 = float(res.get_text())
	if numero1 != null:
		match op:
			"dividir":
				resultado = numero1 / numero2
				res.set_text(str(resultado))
			"multiplicar":
				resultado = numero1 * numero2
				res.set_text(str(resultado))
			"restar":
				resultado = numero1 - numero2
				res.set_text(str(resultado))
			"sumar":
				resultado = numero1 + numero2
				res.set_text(str(resultado))
	numero1 = null
	numero2 = null

################################################################################

var show_settings : bool= false

func _ready():
	print(100000)
	OS.center_window()
	g.load_data()
	update_buttons_color(g["game"]["colors"]["buttons"])
	update_background_color(g["game"]["colors"]["background"])
	update_borders_color(g["game"]["colors"]["borders"])
	update_borders_blend_mode(g["game"]["modes"]["blend"])
	update_circular_mode_button_state(g["game"]["modes"]["circular"]["circular_state"])
	update_borders_circular_mode(g["game"]["modes"]["circular"]["circular_radius"])

func update_buttons_color(color_passed):
	for i in range($calculator_buttons.get_child_count()):
		var buttons = $calculator_buttons.get_child(i)
		buttons["custom_styles/normal"].bg_color = color_passed
		
func update_background_color(color_passed):
	$background.color = color_passed

func update_borders_color(color_passed):
	for i in range($calculator_buttons.get_child_count()):
		var buttons = $calculator_buttons.get_child(i)
		buttons["custom_styles/normal"].border_color = color_passed

func update_borders_blend_mode(state):
	for i in range($calculator_buttons.get_child_count()):
		var buttons = $calculator_buttons.get_child(i)
		buttons["custom_styles/normal"].border_blend = state
		g["game"]["modes"]["blend"] = state

func update_blend_mode_button_state():
	match g["game"]["modes"]["blend"]:
		true:
			$settings/panel/borders_color_picker/blend_mode_button.pressed = true
		false:
			$settings/panel/borders_color_picker/blend_mode_button.pressed = false
			
func update_borders_circular_mode(radius):
	for i in range($calculator_buttons.get_child_count()):
		var buttons = $calculator_buttons.get_child(i)
		buttons["custom_styles/normal"].corner_radius_top_left = radius
		buttons["custom_styles/normal"].corner_radius_top_right = radius
		buttons["custom_styles/normal"].corner_radius_bottom_right = radius
		buttons["custom_styles/normal"].corner_radius_bottom_left = radius
		g["game"]["modes"]["circular"]["circular_radius"] = radius
			
func update_circular_mode_button_state(state):
	match state:
		true:
			$settings/panel/borders_color_picker/circular_mode_button.pressed = true
		false:
			$settings/panel/borders_color_picker/circular_mode_button.pressed = false

func _on_settings_button_pressed() -> void:
	show_settings = !show_settings
	match show_settings:
		true:
			$settings.show()
		false:
			$settings.hide()
			$settings/panel/color_changer.hide()

func _on_buttons_pressed() -> void:
	$settings/panel/buttons_color_picker.show()
	$settings/panel/buttons_color_picker.color = g["game"]["colors"]["buttons"]
	$settings/panel/close_button.hide()
	$settings/panel/delete_button.hide()

func _on_buttons_color_picker_color_changed(color: Color) -> void:
	update_buttons_color(color)
	g["game"]["colors"]["buttons"] = color

func _on_close_color_picker_pressed() -> void:
	$settings/panel/buttons_color_picker.hide()
	$settings/panel/background_color_picker.hide()
	$settings/panel/borders_color_picker.hide()
	$settings/panel/close_button.show()
	$settings/panel/delete_button.show()

func _on_background_pressed() -> void:
	$settings/panel/background_color_picker.show()
	$settings/panel/background_color_picker.color = g["game"]["colors"]["background"]
	$settings/panel/close_button.hide()
	$settings/panel/delete_button.hide()

func _on_background_color_picker_color_changed(color: Color) -> void:
	update_background_color(color)
	g["game"]["colors"]["background"] = color

func _on_close_button_pressed() -> void:
	$settings.hide()
	show_settings = false

func _on_save_timer_timeout() -> void:
	g.save_data()

func _on_borders_pressed() -> void:
	$settings/panel/borders_color_picker.show()
	$settings/panel/borders_color_picker.color = g["game"]["colors"]["borders"]
	$settings/panel/close_button.hide()
	$settings/panel/delete_button.hide()
	update_blend_mode_button_state()

func _on_borders_color_picker_color_changed(color: Color) -> void:
	update_borders_color(color)
	g["game"]["colors"]["borders"] = color

func _on_blend_mode_button_pressed() -> void:
	g["game"]["modes"]["blend"] =! g["game"]["modes"]["blend"]
	match g["game"]["modes"]["blend"]:
		true:
			update_borders_blend_mode(true)
		false:
			update_borders_blend_mode(false)

func _on_circular_mode_button_pressed() -> void:
	g["game"]["modes"]["circular"]["circular_state"] =! g["game"]["modes"]["circular"]["circular_state"]
	match g["game"]["modes"]["circular"]["circular_state"]:
		true:
			update_borders_circular_mode(20)
		false:
			update_borders_circular_mode(0)

func _on_delete_button_pressed() -> void:
	$settings/delete_confirmation.popup()

func _on_delete_confirmation_confirmed() -> void:
	var file = File.new()
	if file.file_exists(g.path):
		Directory.new().remove(g.path)
		get_tree().quit()
