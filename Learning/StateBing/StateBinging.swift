import SwiftUI
//https://elamir.medium.com/reactive-swift-exploring-the-wonders-of-observables-db7bd6e75bf7
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


import SwiftUI
import Combine

class CounterViewModel: ObservableObject {
    @Published var count: Int = 0
}

struct CounterView: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")

            Button("Increment") {
                viewModel.count += 1
            }
        }
        .padding()
    }
}

// Usage
// let viewModel = CounterViewModel()
// let contentView = CounterView(viewModel: viewModel)
// ContentView()
