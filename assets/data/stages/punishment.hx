import funkin.game.ComboRating;

importScript("data/scripts/easteregg/paintings");

function create() {
    comboRatings = [
		new ComboRating(0, "F", 0xFF941616),
		new ComboRating(0.5, "E", 0xFFCF1414),
		new ComboRating(0.7, "D", 0xFFFFAA44),
		new ComboRating(0.8, "C", 0xFFFFA02D),
		new ComboRating(0.85, "B", 0xFFFE8503),
		new ComboRating(0.9, "A", 0xFFAEFF9C),
		new ComboRating(0.95, "S", 0xFF6BF04D),
		new ComboRating(1, "S++", 0xFF26D000),
	];

    __script__.didLoad = __script__.active = false;
}