import Foundation

// ============================================================
// LISKOV SUBSTITUTION PRINCIPLE (LSP)
// ============================================================
//
// Definition:
// "Objects of a superclass should be replaceable with objects
//  of its subclasses without breaking the functionality."
//
// In simple words:
//
// If CreditCardPayment is a type of Payment,
// then code that works with Payment should also work correctly
// when CreditCardPayment is provided.
//
// The problem starts when a subclass cannot fulfill the
// behavior promised by its parent class.
// ============================================================


// ============================================================
// ❌ BAD DESIGN — LSP VIOLATION
// ============================================================

// Imagine that our base Payment class says:
//
// "Every payment supports payment AND refund."

class BadPayment {

    func pay(amount: Double) {
        print("Payment of ₹\(amount) completed.")
    }

    func refund(amount: Double) {
        print("Refund of ₹\(amount) processed.")
    }
}


// ------------------------------------------------------------
// Credit Card Payment
// ------------------------------------------------------------

class BadCreditCardPayment: BadPayment {

    // Credit cards support both payment and refund.
    // Therefore, this subclass works perfectly with BadPayment.

    override func pay(amount: Double) {
        print("₹\(amount) paid using Credit Card.")
    }

    override func refund(amount: Double) {
        print("₹\(amount) refunded to Credit Card.")
    }
}


// ------------------------------------------------------------
// Cash Payment
// ------------------------------------------------------------

class BadCashPayment: BadPayment {

    override func pay(amount: Double) {
        print("₹\(amount) paid using Cash.")
    }

    // ❌ PROBLEM:
    //
    // Cash payment may not support the same refund mechanism
    // as an online/card payment.
    //
    // We are forced to override refund() because the parent
    // class requires it.

    override func refund(amount: Double) {

        // This is a very bad design.
        //
        // The parent class promises that refund() can be called,
        // but this subclass cannot actually fulfill that promise.

        fatalError("Cash payment cannot be refunded through this system.")
    }
}


// ------------------------------------------------------------
// A function that accepts the parent type
// ------------------------------------------------------------

func processRefund(payment: BadPayment) {

    // According to the BadPayment contract,
    // this should always be safe.

    payment.refund(amount: 500)
}


// ------------------------------------------------------------
// Let's test it
// ------------------------------------------------------------

let creditCardPayment = BadCreditCardPayment()

processRefund(payment: creditCardPayment)

// Output:
// ₹500 refunded to Credit Card.
//
// Everything works correctly.


let cashPayment = BadCashPayment()

// ❌ This compiles because BadCashPayment IS-A BadPayment.
//
// But at runtime, it crashes because CashPayment cannot
// fulfill the behavior promised by BadPayment.

processRefund(payment: cashPayment)


// ============================================================
// WHY IS THIS AN LSP VIOLATION?
// ============================================================
//
// The function:
//
//     processRefund(payment: BadPayment)
//
// expects ANY BadPayment to support refund().
//
// But:
//
//     BadCashPayment
//
// cannot safely replace:
//
//     BadPayment
//
// because calling refund() causes a crash.
//
// Therefore:
//
//     BadCashPayment ❌ cannot substitute BadPayment
//
// This violates the Liskov Substitution Principle.
// ============================================================


// ============================================================
// ✅ GOOD DESIGN — FOLLOWING LSP
// ============================================================
//
// Instead of saying:
//
// "Every Payment can be refunded."
//
// We separate the responsibilities:
//
// Payment
//     → Can make a payment
//
// Refundable
//     → Can process a refund
//
// This means a payment type only needs to implement the
// behavior it actually supports.
// ============================================================


// ------------------------------------------------------------
// Payment Protocol
// ------------------------------------------------------------
//
// Every payment method must be able to make a payment.
//
// Notice that refund() is NOT here.
//

protocol Payment {

    func pay(amount: Double)
}


// ------------------------------------------------------------
// Refundable Protocol
// ------------------------------------------------------------
//
// Only payment methods that support refunds should conform
// to this protocol.
//

protocol Refundable {

    func refund(amount: Double)
}


// ============================================================
// CREDIT CARD PAYMENT
// ============================================================
//
// Credit card supports:
//      1. Payment
//      2. Refund
//
// Therefore, it conforms to BOTH protocols.
//

class CreditCardPayment: Payment, Refundable {

    func pay(amount: Double) {

        print("💳 Credit Card Payment")
        print("Paid ₹\(amount) using Credit Card.")
    }

    func refund(amount: Double) {

        print("↩️ Credit Card Refund")
        print("Refunded ₹\(amount) to Credit Card.")
    }
}


// ============================================================
// CASH PAYMENT
// ============================================================
//
// Cash supports payment.
//
// But our system does NOT provide an online refund operation
// for cash.
//
// Therefore, CashPayment only conforms to Payment.
//
// It does NOT need to implement refund().
//
// This is the important part of the LSP-friendly design.
//

class CashPayment: Payment {

    func pay(amount: Double) {

        print("💵 Cash Payment")
        print("Paid ₹\(amount) using Cash.")
    }
}


// ============================================================
// UPI PAYMENT
// ============================================================
//
// UPI supports both payment and refund.
//

class UPIPayment: Payment, Refundable {

    func pay(amount: Double) {

        print("📱 UPI Payment")
        print("Paid ₹\(amount) using UPI.")
    }

    func refund(amount: Double) {

        print("↩️ UPI Refund")
        print("Refunded ₹\(amount) to UPI account.")
    }
}


// ============================================================
// PAYMENT PROCESSING
// ============================================================
//
// This function only cares about the Payment behavior.
//
// It does NOT care whether the payment is:
//
//     Credit Card
//     Cash
//     UPI
//     PayPal
//     Apple Pay
//
// Any object conforming to Payment can safely be substituted.
//
// This is the idea behind LSP.
// ============================================================

func processPayment(payment: Payment, amount: Double) {

    payment.pay(amount: amount)
}


// ============================================================
// REFUND PROCESSING
// ============================================================
//
// Notice that this function does NOT accept Payment.
//
// It accepts Refundable.
//
// Why?
//
// Because not every payment supports refund.
//
// This prevents us from passing CashPayment accidentally.
// ============================================================

func processRefund(payment: Refundable, amount: Double) {

    payment.refund(amount: amount)
}


// ============================================================
// TESTING THE GOOD DESIGN
// ============================================================


// ------------------------------------------------------------
// 1. Credit Card
// ------------------------------------------------------------

let creditCard = CreditCardPayment()

processPayment(
    payment: creditCard,
    amount: 1000
)

processRefund(
    payment: creditCard,
    amount: 300
)


// Output:
//
// 💳 Credit Card Payment
// Paid ₹1000.0 using Credit Card.
//
// ↩️ Credit Card Refund
// Refunded ₹300.0 to Credit Card.


// ------------------------------------------------------------
// 2. UPI
// ------------------------------------------------------------

let upi = UPIPayment()

processPayment(
    payment: upi,
    amount: 2000
)

processRefund(
    payment: upi,
    amount: 500
)


// Output:
//
// 📱 UPI Payment
// Paid ₹2000.0 using UPI.
//
// ↩️ UPI Refund
// Refunded ₹500.0 to UPI account.


// ------------------------------------------------------------
// 3. Cash
// ------------------------------------------------------------

let cash = CashPayment()

processPayment(
    payment: cash,
    amount: 500
)


// Output:
//
// 💵 Cash Payment
// Paid ₹500.0 using Cash.


// ------------------------------------------------------------
// IMPORTANT:
//
// We cannot do:
//
// processRefund(payment: cash, amount: 100)
//
// because CashPayment does not conform to Refundable.
//
// Swift will give us a compile-time error.
//
// This is GOOD.
//
// We have prevented an invalid operation before the program
// even runs.
// ============================================================


// ============================================================
// LSP IN THIS EXAMPLE
// ============================================================
//
// Payment
//    │
//    ├── CreditCardPayment
//    ├── CashPayment
//    └── UPIPayment
//
// Any of these can safely replace Payment:
//
// processPayment(payment: creditCard, amount: 1000)
// processPayment(payment: cash, amount: 1000)
// processPayment(payment: upi, amount: 1000)
//
// None of them breaks processPayment().
//
//
// Refundable
//    │
//    ├── CreditCardPayment
//    └── UPIPayment
//
// Only objects that genuinely support refund can be used
// with processRefund().
//
// ============================================================


// ============================================================
// THE KEY LESSON
// ============================================================
//
// ❌ BAD:
//
// class Payment {
//     func pay()
//     func refund()
// }
//
// class CashPayment: Payment {
//     func refund() {
//         fatalError()
//     }
// }
//
// The subclass cannot honor the parent's contract.
//
//
// ✅ GOOD:
//
// protocol Payment {
//     func pay()
// }
//
// protocol Refundable {
//     func refund()
// }
//
// class CashPayment: Payment
//
// class CreditCardPayment: Payment, Refundable
//
//
// Now every type can safely be substituted wherever its
// abstraction is expected.
//
// ============================================================
//
// In one sentence:
//
// LSP means:
//
// "Don't make a subclass pretend to support behavior that it
//  cannot actually provide."
//
// ============================================================
