extends RichTextLabel

@export_multiline var Texts : Array[String]




func SetLabel(string : String, lineNum : int = 0):
	Texts[lineNum] = string
	SetCombinedText()
	

func SetCombinedText():
	var combinedText = "[center]"
	for t in Texts:
		combinedText += t + " "
	text = combinedText
