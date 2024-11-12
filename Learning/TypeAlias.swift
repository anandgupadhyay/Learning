//example where function return value but we are not using it
enum APIProvider {
    static func updateName(_ name: String) -> Result<User, Error> {
        // .. Handle API endpoint, example result:
        return .success(User(name: name))
    }
}

final class UpdateNameViewController {
    func didEnterName(_ name: String) {
        /// The underscore makes the warning go away.
        _ = APIProvider.updateName(name)
    }
}
//However, having lots of underscore property names throughout your projects isn’t really clean too. Therefore, it’s better to use the @discardableResult keyword in front of your method definition:

enum APIProvider {
    @discardableResult static func updateName(_ name: String) -> Result<User, Error> {
        // .. Handle API endpoint, example result:
        return .success(User(name: name))
    }
}

/*    Swift Typealias is used to provide a new name for an existing data type in the program. Once you create a typealias, you can use the aliased name instead of the exsisting name throughout the program.
 Typealias doesn't create a new data type, it simply provides a new name to the existing data type.

 Purpose of using Typealias
 The main purpose of using typealias is make our code clearer and human readable.

 Create a typealias
 Typealias is declared using the keyword typealias:
 

 Typealias for Built-in Types
 Typealias can be used for all built-in data types i.e. String, Int, Float etc.

 For example:
 typealias BusinessName = String
 let name:BusinessName = "Simmy's Cacke Plaza"

 */


//    typealias Square = (h:Int,w:Int)

//    let pillow = Square(h: 10, w:10)
//    let tv = Square(h: 42.5, w:52.5)//Cannot convert value of type '(h: Double, w: Double)' to specified type 'NewPocketView.Square' (aka '(h: Int, w: Int)')


   typealias Square<T> = (h:T,w:T) // Generic Type with typealias
   let pillow = Square(h: 10, w:10)
   let tv = Square(h: 42.5, w:52.5)
