extends Control

@onready var http: HTTPRequest = $HTTPRequest


const URL = "https://api.hypixel.net/v2/skyblock/bazaar"

const HEADERS = ["application: json"]

func _on_button_pressed() -> void:
	request_update()

func _ready() -> void:
	#http.get_http_client_status().
	request_update()

func request_update() -> void:
	for p in [%SinglePrice, %StackPrice, %FMPrice]:
		p.text = "$ Loading"

	%Stock.text = "Loading"
	http.request(URL, HEADERS, HTTPClient.METHOD_GET)


func _on_http_request_request_completed(_r, _r_code, _h, body: PackedByteArray) -> void:
	var mushroom = JSON.parse_string(body.get_string_from_utf8())["products"]["BROWN_MUSHROOM"]
	#FileAccess.open("user://data.json", FileAccess.WRITE).store_string(str(mushroom))
	var price = mushroom["quick_status"]["buyPrice"]
	%SinglePrice.text = "$ " + split_big(price)
	%StackPrice.text = "$ " + split_big(price * 64)
	%FMPrice.text = "$ " + split_big(price * 4_000_000)
	%Stock.text = split_big(mushroom["quick_status"]["buyVolume"], true)

func split_big(number: float, is_int = false) -> String:

	if number < 1000:
		return str(number).pad_decimals(1)

	var t = str(roundi(number * 10))
	if is_int:
		t = str(number)
	for i in ceil(t.length() / 3.0):

		if i == 0:
			continue

		var index_offset = i * 3 - (1 if is_int else 0)
		t = t.insert(t.length() - i - index_offset, ",")
	return t.insert(t.length() - 1, ".") if !is_int else t



