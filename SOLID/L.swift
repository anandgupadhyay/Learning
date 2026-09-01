//If Student is a subclass of Person, then wherever your code expects Person, you should be able to use Student without unexpected behavior.

//
class Bird {
    func fly() {
        print("Flying...")
    }
}

class Sparrow: Bird {
    // Sparrow can fly
}

class Penguin: Bird {
    override func fly() {
        fatalError("Penguins cannot fly!")
    }
}

Now suppose we have a function:

func makeBirdFly(_ bird: Bird) {
    bird.fly()
}

We can pass a Sparrow:

let sparrow = Sparrow()
makeBirdFly(sparrow)

This works:

Flying...

But if we pass a Penguin:

let penguin = Penguin()
makeBirdFly(penguin)

The application crashes because:

fatalError("Penguins cannot fly!")
Why is this an LSP violation?

Penguin is a Bird, but it cannot satisfy the behavior expected from Bird.

The superclass says:

Bird → can fly

But the subclass says:

Penguin → cannot fly

So replacing Bird with Penguin breaks the program.
