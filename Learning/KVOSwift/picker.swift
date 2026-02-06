import SwiftUI

struct ContentView: View {
    // 1. Define the possible options. The type must be Hashable.
    let options = ["Option 1", "Option 2", "Option 3"]

    // 2. Create a @State variable to store the user's selection.
    @State private var selectedOption = "Option 1" // Default value

    var body: some View {
        VStack(spacing: 20) {
            // 3. Create the Picker.
            Picker("Select an Option", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
            // 4. Apply the menu picker style to display it as a dropdown menu.
            .pickerStyle(.menu)

            // 5. Display the selected option.
            Text("Selected option: \(selectedOption)")
                .font(.headline)
                .padding()
        }
        .padding()
    }
}
