Bad practice: not using UIAction
You’re more of a video kind of person? I’ve got you covered! Here’s a video with the same content than this article 🍿


Can you guess what’s the problem with this code?


If you’ve been doing iOS for sometime, you’re definitely familiar with this kind of code: we’re configuring a UIButton using the target-action pattern.

And while this code is perfectly correct, we can see that it involves some language features that we probably wouldn’t use by ourselves.

Namely, we’re using #selector() and annotating our method with @IBAction.


The reason we have to use these features is because the target-action pattern dates back to the days of Objective-C!

And so in order to use it in Swift, we need to make our code compatible with the Objective-C runtime environment.

However, there’s a more modern alternative we can use!

Because since iOS 14 we can use a new method called addAction():


This method serves the same purpose than addTarget(), but instead of working with Objective-C selectors, it uses Swift closures.


And as you can see, when we use this new method, we no longer need to introduce any Objective-C compatibility to our code!

But that’s not the only improvement we can make here!

Notice how the action of the button has been registered for the event .touchUpInside.


If your code only runs on iPhone, this is totally fine.

But if you plan to support other platforms, it’s actually better to use the event .primaryActionTriggered instead.


The reason is that .touchUpInside is only triggered in response to touch interaction, and so it won’t be triggered if the user interacts with the button through an AppleTV remote or an iPad keyboard.


That’s all for this article, I hope you’ve enjoyed discovering this new API of UIButton!

Here’s the code if you want to experiment with it:

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let action = UIAction { [weak self] _ in
            self?.buttonTapped()
        }

        button.addAction(action, for: .primaryActionTriggered)
    }

   func buttonTapped() {
       print("Button was tapped!")
    }
}
