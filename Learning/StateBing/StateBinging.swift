import SwiftUI

struct CounterExample: View {
    @State private var count: Int = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
            
            Button("Increment") {
                count += 1
            }
        }
        .padding()
    }
}

// Usage
// let contentView = CounterExample()
// ContentView()


struct ChildView: View {
    @Binding var value: Int

    var body: some View {
        VStack {
            Text("Value in ChildView: \(value)")
            
            Button("Increment") {
                value += 1
            }
        }
        .padding()
    }
}

struct ParentView: View {
    @State private var parentValue: Int = 0

    var body: some View {
        VStack {
            Text("Value in ParentView: \(parentValue)")
            
            ChildView(value: $parentValue)
        }
        .padding()
    }
}

// Usage
// let contentView = ParentView()
// ContentView()
