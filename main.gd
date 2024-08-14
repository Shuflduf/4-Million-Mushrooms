extends Control

@onready var http: HTTPRequest = $HTTPRequest

const URL = "https://api.hypixel.net/v2/skyblock/bazaar"

const HEADERS = ["application: json"]

func _on_button_pressed() -> void:
	request_update()

func _ready() -> void:
	request_update()

func request_update() -> void:
	for p in [%SinglePrice, %StackPrice, %FMPrice]:
		p.text = "$ Loading"

	http.request(URL, HEADERS, HTTPClient.METHOD_GET)


func _on_http_request_request_completed(_r, _r_code, _h, body: PackedByteArray) -> void:
	var mushroom = JSON.parse_string(body.get_string_from_utf8())["products"]["BROWN_MUSHROOM"]
	FileAccess.open("data.json", FileAccess.WRITE).store_string(str(mushroom))
	var price = mushroom["quick_status"]["buyPrice"]
	%SinglePrice.text = "$ " + split_big(price)
	%StackPrice.text = "$ " + split_big(price * 64)
	%FMPrice.text = "$ " + split_big(price * 4_000_000)

func split_big(number: float) -> String:

	var t = str(roundi(number * 10))
	for i in ceil(t.length() / 3.0):
		if i == 0:
			continue
		t = t.insert(t.length() - i - i * 3, ",")
	return str(t.insert(t.length() - 1, "."))



