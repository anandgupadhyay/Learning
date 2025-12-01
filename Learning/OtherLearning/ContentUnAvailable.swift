import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "No Data Available",
            systemImage: "tray",
            description: Text("There’s nothing here right now. Please try again later.")
        )
    }
}

//Using it inside a list or screen
struct MyListView: View {
    @State private var items: [String] = []

    var body: some View {
        if items.isEmpty {
            ContentUnavailableView(
                "No Items",
                systemImage: "list.bullet",
                description: Text("Add new items to see them here.")
            )
        } else {
            List(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}
