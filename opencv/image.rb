require 'opencv'
include OpenCV

image = OpenCV::IplImage.load("baboon.jpg")
template = OpenCV::IplImage.load("baboon.jpg")
result = image.match_template(template)

min_score, max_score, min_point, max_point = result.min_max_loc

from = min_point
to = OpenCV::CvPoint.new(from.x + template.width, from.y + template.height)
image.rectangle!(from, to, :color => OpenCV::CvColor::Black, :thickness => 1)

window = GUI::Window.new('Display window')
window.show(image)
GUI::wait_key # Wait for a keystroke in the window.

image.save_image("otuput.png")
