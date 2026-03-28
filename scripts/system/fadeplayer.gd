extends AnimatedSprite2D


@export var fadetoblack : AnimatedSprite2D
var fshow : bool

func _ready():
	Fade.connect("fade", fading)
	$Timer.start()
	fshow = true
	fadetoblack.show()

func fading():
	if fshow == true:
		fadetoblack.show()
		fadetoblack.play("fadein")
		_on_timer_timeout()

func _on_timer_timeout():
	fadetoblack.hide()
	fshow = false
