class PersonObservable: ObservableObject {
    @Published var name = ""
    private var socialSecurityNumber = 
}




@Observable class PersonObservable { var name = "" private var socialSecurityNumber = }
struct ContentView: View { @StateObject private var person = PersonObservable() var body: some View { VStack { TextField("Name", text: $person.name) // ... other UI elements } } }
