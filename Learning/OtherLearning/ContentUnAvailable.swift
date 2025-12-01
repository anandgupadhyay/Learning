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
