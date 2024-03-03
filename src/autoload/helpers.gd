class_name Utils
extends Node2D


static func alignment_to_color(alignment: Structure.Alignment) -> Color:
	match alignment:
		Structure.Alignment.Blue:
			return Color.CADET_BLUE
		Structure.Alignment.Yellow:
			return Color.YELLOW
		Structure.Alignment.Red:
			return Color.INDIAN_RED
		Structure.Alignment.Green:
			return Color.PALE_GREEN
		Structure.Alignment.Orange:
			return Color.CORAL
		Structure.Alignment.Purple:
			return Color.MEDIUM_PURPLE
	
	return Color.DARK_TURQUOISE
