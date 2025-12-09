struct KeyboardHandlingModifier: ViewModifier {
    @FocusState private var isFocused: Bool
    @State private var keyboardHeight: CGFloat = 0.0
    @State private var keyboardShowObserver: NSObjectProtocol?
    @State private var keyboardHideObserver: NSObjectProtocol?

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .padding(.bottom, keyboardHeight)
            .onAppear {
                keyboardShowObserver = NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil,
                    queue: .main
                ) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        withAnimation {
                            keyboardHeight = keyboardFrame.height
                        }
                    }
                }

                keyboardHideObserver = NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    withAnimation {
                        keyboardHeight = 0
                    }
                }
            }
            .onDisappear {
                if let showObserver = keyboardShowObserver {
                    NotificationCenter.default.removeObserver(showObserver)
                }
                if let hideObserver = keyboardHideObserver {
                    NotificationCenter.default.removeObserver(hideObserver)
                }
            }
    }
}

//Now Create an View Extension
extension View {
    func keyboardHandling() -> some View {
        self.modifier(KeyboardHandlingModifier())
    }
}
