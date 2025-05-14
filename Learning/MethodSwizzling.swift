extension UIView {
    static let classInit: Void = {
       guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(layoutSubviews),
             let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(swizzled_layoutSubviews))
       else { return }
       method_exchangeImplementations(originalMethod, swizzledMethod)
    }()

    @objc func swizzled_layoutSubviews() {
        swizzled_layoutSubviews()
        print("Custom logging after each layoutSubviews call.")
    }
}
// Make sure to call `UIView.classInit` somewhere early, e.g. in the app delegate.
