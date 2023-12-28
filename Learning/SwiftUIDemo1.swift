ForEach(0 ..‹ 6) { item in

Circle ()

•frame(width: 150, height: 150,

alignment: .center)

•foregroundColor (flowerColor)

•offset(y: -80)

•rotationEffect (

•degrees(Double(item)) * angle)

•scaleEffect (CGFloat (scale))

•blendMode (. sourceAto)

•animation(easeInOut (duration:

4). delay (0.75)

•repeatForever(autoreverses:

true), value: scale)

•onAppear() {

angle = 60.0

scale = 1

}
｝
}
Spacer ()
