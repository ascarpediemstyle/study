require 'rubygems'
require 'opencv'
include OpenCV

# windowの作成
window = GUI::Window.new('detect face')
# 画像の読み込み
img = IplImage.load('araki.jpg')

# 学習データの読み込み
faces = CvHaarClassifierCascade::load('haarcascade_frontalface_default.xml')

# 顔認識→四角による描画
faces.detect_objects(img.to_CvMat) {|rect|
  img.rectangle!(rect.top_left, rect.bottom_right, :color => CvColor::Red)
}
# windowに画像を表示
window.show img
# 画像を保存
img.save_image('conv.jpg')
# キー入力待ち
GUI::wait_key
window.destroy