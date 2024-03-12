//
//  AttributedString.swift
//  Learning
//
//  Created by Anand Upadhyay on 29/02/24.
//

import Foundation
import UIKit



//struct Cube {
//    let initialVolume: Int
//    private var dimensions: Int = 3
//    
//    init(_ side: Int) {
//        initialVolume = volume(for: side)
//    }
//    
//    func volume(for side: Int) -> Int {
//        return 0
////        return Int(pow(side, dimensions))
//    }
//}

    
// Dynamic Type feature
//What is the Dynamic Type feature?
//The Dynamic Type feature allows users to adjust the size of textual content on both the app and system levels. It’s part of the accessibility features family and accommodates users requiring larger text for readability. It also offers smaller text sizes for those users that can handle it, allowing for more content to be visible on screen.
//You can find the setting by going into the Settings app → Accessibility → Display & Text Size → Larger Text:


//https:www.avanderlee.com/workflow/third-party-libraries-acknowledgments-swift-packages/
//How To Add Third Party Library acknowledgement
//Third-party libraries acknowledgments using a Settings bundle
//Third-party libraries help developers build apps faster but often come with a license. The MIT license is likely the most common, but there are many others that, together, require you to acknowledge the usage of the library in return for getting free access.
//
//I’m not going to dive deep into the details of each license type, but I will explain how you can add acknowledgments inside your app without much effort. We will use a Settings bundle to move all acknowledgments to the system settings level, not distracting regular usage inside your app.

/*
The general form for making and setting an attributed string is like this. You can find other common options below.
// create attributed string
let myString = "Swift Attributed String"
let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)

// set attributed text on a UILabel
myLabel.attributedText = myAttrString
￼
let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
￼
let myAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.yellow ]
￼
let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ]
￼
let myAttribute = [ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]
￼
let myShadow = NSShadow()
myShadow.shadowBlurRadius = 3
myShadow.shadowOffset = CGSize(width: 3, height: 3)
myShadow.shadowColor = UIColor.gray

let myAttribute = [ NSAttributedString.Key.shadow: myShadow ]
The rest of this post gives more detail for those who are interested.

Attributes
String attributes are just a dictionary in the form of [NSAttributedString.Key: Any], where NSAttributedString.Key is the key name of the attribute and Any is the value of some Type. The value could be a font, a color, an integer, or something else. There are many standard attributes in Swift that have already been predefined. For example:
* key name: NSAttributedString.Key.font, value: a UIFont
* key name: NSAttributedString.Key.foregroundColor, value: a UIColor
* key name: NSAttributedString.Key.link, value: an NSURL or NSString
There are many others. See this link for more. You can even make your own custom attributes like:
* key name: NSAttributedString.Key.myName, value: some Type. if you make an extension: extension NSAttributedString.Key {
*     static let myName = NSAttributedString.Key(rawValue: "myCustomAttributeKey")
* }
*
Creating attributes in Swift
You can declare attributes just like declaring any other dictionary.
// single attributes declared one at a time
let singleAttribute1 = [ NSAttributedString.Key.foregroundColor: UIColor.green ]
let singleAttribute2 = [ NSAttributedString.Key.backgroundColor: UIColor.yellow ]
let singleAttribute3 = [ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue ]

// multiple attributes declared at once
let multipleAttributes: [NSAttributedString.Key : Any] = [
    NSAttributedString.Key.foregroundColor: UIColor.green,
    NSAttributedString.Key.backgroundColor: UIColor.yellow,
    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue ]

// custom attribute
let customAttribute = [ NSAttributedString.Key.myName: "Some value" ]
Note the rawValue that was needed for the underline style value.
Because attributes are just Dictionaries, you can also create them by making an empty Dictionary and then adding key-value pairs to it. If the value will contain multiple types, then you have to use Any as the type. Here is the multipleAttributes example from above, recreated in this fashion:
var multipleAttributes = [NSAttributedString.Key : Any]()
multipleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.green
multipleAttributes[NSAttributedString.Key.backgroundColor] = UIColor.yellow
multipleAttributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.double.rawValue
Attributed Strings
Now that you understand attributes, you can make attributed strings.
Initialization
There are a few ways to create attributed strings. If you just need a read-only string you can use NSAttributedString. Here are some ways to initialize it:
// Initialize with a string only
let attrString1 = NSAttributedString(string: "Hello.")

// Initialize with a string and inline attribute(s)
let attrString2 = NSAttributedString(string: "Hello.", attributes: [NSAttributedString.Key.myName: "A value"])

// Initialize with a string and separately declared attribute(s)
let myAttributes1 = [ NSAttributedString.Key.foregroundColor: UIColor.green ]
let attrString3 = NSAttributedString(string: "Hello.", attributes: myAttributes1)
If you will need to change the attributes or the string content later, you should use NSMutableAttributedString. The declarations are very similar:
// Create a blank attributed string
let mutableAttrString1 = NSMutableAttributedString()

// Initialize with a string only
let mutableAttrString2 = NSMutableAttributedString(string: "Hello.")

// Initialize with a string and inline attribute(s)
let mutableAttrString3 = NSMutableAttributedString(string: "Hello.", attributes: [NSAttributedString.Key.myName: "A value"])

// Initialize with a string and separately declared attribute(s)
let myAttributes2 = [ NSAttributedString.Key.foregroundColor: UIColor.green ]
let mutableAttrString4 = NSMutableAttributedString(string: "Hello.", attributes: myAttributes2)
Changing an Attributed String
As an example, let's create the attributed string at the top of this post.
First create an NSMutableAttributedString with a new font attribute.
let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ]
let myString = NSMutableAttributedString(string: "Swift", attributes: myAttribute )
If you are working along, set the attributed string to a UITextView (or UILabel) like this:
textView.attributedText = myString
You don't use textView.text.
Here is the result:
￼
Then append another attributed string that doesn't have any attributes set. (Notice that even though I used let to declare myString above, I can still modify it because it is an NSMutableAttributedString. This seems rather unSwiftlike to me and I wouldn't be surprised if this changes in the future. Leave me a comment when that happens.)
let attrString = NSAttributedString(string: " Attributed Strings")
myString.append(attrString)
￼
Next we'll just select the "Strings" word, which starts at index 17 and has a length of 7. Notice that this is an NSRange and not a Swift Range. (See this answer for more about Ranges.) The addAttribute method lets us put the attribute key name in the first spot, the attribute value in the second spot, and the range in the third spot.
var myRange = NSRange(location: 17, length: 7) // range starting at location 17 with a lenth of 7: "Strings"
myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
￼
Finally, let's add a background color. For variety, let's use the addAttributes method (note the s). I could add multiple attributes at once with this method, but I will just add one again.
myRange = NSRange(location: 3, length: 17)
let anotherAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.yellow ]
myString.addAttributes(anotherAttribute, range: myRange)
￼
Notice that the attributes are overlapping in some places. Adding an attribute doesn't overwrite an attribute that is already there.
Related
* How to change the text of an NSMutableAttributedString but keep the attributes
Further Reading
* How to retrieve the attributes from a tap location
* Attributed String Programming Guide (very informative but unfortunately only in Objective-C)
*/
