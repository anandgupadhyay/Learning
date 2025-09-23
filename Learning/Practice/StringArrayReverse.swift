
// let array = ["a","b","c"]
// I want an resultarray which adds index of the element as suffix to each string
// Expected Result = ["a-0","b-1","c-2"]


let array = ["a", "b", "c"]
let resultArray = array.enumerated().map { "\($0.element)-\($0.offset)" }


//What will be output 

let array: [Any] = ["string", 12, 23.45, true, Date(), ["name": "anand"], "string2", 54.54, 6, false, Date()]

var typeDictionary: [String: [Any]] = [:]

for item in array {
    switch item {
    case is String:
        typeDictionary["String", default: []].append(item)
    case is Int:
        typeDictionary["Int", default: []].append(item)
    case is Double:
        typeDictionary["Double", default: []].append(item)
    case is Bool:
        typeDictionary["Bool", default: []].append(item)
    case is Date:
        typeDictionary["Date", default: []].append(item)
    case is [String:Any]:
        typeDictionary["Dictionary", default: []].append(item)
    default:
        typeDictionary["Other", default: []].append(item)
    }
}

print(typeDictionary)


👉 Given an array of strings, transform it into a new array:
Input → ["a", "b", "c"]
Output → ["c-0", "b-1", "a-2"]
