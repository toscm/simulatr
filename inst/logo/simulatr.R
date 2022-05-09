library(ggplot2)
library(hexSticker)

rect <- function(
	xmin = 1, xmax = 3, ymin = 10, ymax = 15, fill = "blue", color = "black",
	alpha = 0.4
) {
    geom_rect(
        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
        fill = fill,
        color = color,
        alpha = alpha
    )
}

p <- sticker(
	subplot = {
		ggplot() +
		rect(1, 3, 10, 15, "blue", "black", 0.4) +
		rect(2, 5, 3, 10, "orange", "black", 1) +
		theme_void()
	},
	package = "simulatr",
	p_size = 20,
	s_x = 1,
	s_y = .75,
	s_width = .6,
	filename = "C:/Users/tobi/Downloads/simulatr.png",
	h_fill = "#ffdb99",
	h_color = "#000000b0",
	p_color = "#000000b0"
)
plot(p)
