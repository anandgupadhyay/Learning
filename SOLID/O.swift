/*
By introducing a PaymentMethod protocol, you make the system open for extension but closed for modification. 
You can add infinite payment methods without ever touching PaymentProcessor again.
*/

// 1. Create a stable abstraction
protocol PaymentMethod {
    func process()
}

// 2. Conform new types to the protocol (Open for Extension)
struct ApplePay: PaymentMethod {
    func process() {
        print("Processing Apple Pay...")
    }
}

struct CreditCard: PaymentMethod {
    func process() {
        print("Processing Credit Card...")
    }
}

struct Bitcoin: PaymentMethod { // Added seamlessly!
    func process() {
        print("Processing Bitcoin...")
    }
}

// 3. Keep this class unchanged (Closed for Modification)
class PaymentProcessor {
    func execute(payment: PaymentMethod) {
        payment.process() 
    }
}
