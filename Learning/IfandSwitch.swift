I’m certain you’ve already used the keyword if or the keyword switch.


But you might have noticed that when you want to use one of them to set the value of a variable, the syntax can be a bit cumbersome.


You have to declare the variable before hand and then assign it a value in every branch of the code.

That works nice, but it requires you to repeat the name of the variable every time.

And you also need to explicitly declare the type of the variable, even though it could have been inferred.

Of course, you can try to improve a bit, and move the if or the switch to a closure that you will immediately call:


It’s arguably a bit better, but it still requires some extra syntax.

The good news is that since Swift 5.9, there’s an even better solution!

Because Swift 5.9 introduces the possibility of using an if or a switch as an expression!

Thanks to this new addition, the syntax now becomes much simpler!


Since we are now allowed to treat the if or the switch block as an expression, we just need to assign it to the variable, and that’s it!

We’ve got the result we wanted and it no longer requires any unnecessary boilerplate 👌


That’s all for this article, I hope you’ve enjoyed discovering this new feature!

Here’s the code if you want to experiment with it:

import Foundation

let comment = if Int.random(in: 0...3).isMultiple(of: 2) {
        "It's an even integer"
    } else {
        "It's an odd integer"
    }

let spelledOut = switch Int.random(in: 0...3) {
    case 0:
        "Zero"
    case 1:
        "One"
    case 2:
        "Two"
    case 3:
        "Three"
    default:
        "Out of range"
    }
