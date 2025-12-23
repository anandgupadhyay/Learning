class CounterModel: ObservableObject {
    @Published var count = 0
}

struct ParentView: View {
    @StateObject var model = CounterModel()

    var body: some View {
        ChildView(model: model)
    }
}

struct ChildView: View {
    @ObservedObject var model: CounterModel

    var body: some View {
        Button("Count: \(model.count)") {
            model.count += 1
        }
    }
}
