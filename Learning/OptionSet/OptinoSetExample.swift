struct PizzaToppings: OptionSet {
    let rawValue: Int

    static let pepperoni = PizzaToppings(rawValue: 1 << 0)
    static let mushrooms = PizzaToppings(rawValue: 1 << 1)
    static let onions = PizzaToppings(rawValue: 1 << 2)
    static let extraCheese = PizzaToppings(rawValue: 1 << 3)

    static let vegetarian: PizzaToppings = [.mushrooms, .onions]
    static let supreme: PizzaToppings = [.pepperoni, .mushrooms, .onions, .extraCheese]
}

class PizzaMaker {
    func order(toppings: PizzaToppings) -> String {
        var price = 10
        var selectedToppings: [String] = []

        let toppingsList: [(PizzaToppings, String)] = [
            (.pepperoni, "Pepperoni"),
            (.mushrooms, "Mushrooms"),
            (.onions, "Onions"),
            (.extraCheese, "Extra Cheese")
        ]

        for (option, name) in toppingsList where toppings.contains(option) {
            selectedToppings.append(name)
            price += 2
        }

        return "Pizza with: \(selectedToppings.joined(separator: ", "))\nPrice: $\(price)"
    }
}
