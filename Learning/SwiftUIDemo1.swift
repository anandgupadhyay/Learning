// Security Settigns for Text Field
class CustomTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponder.paste(_:)) {
            return false // Disable paste
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

// In your view controller:
let textField = CustomTextField()
textField.textContentType = .password // Example: Setting content type for privacy

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
