
// let array = ["a","b","c"]
// I want an resultarray which adds index of the element as suffix to each string
// Expected Result = ["a-0","b-1","c-2"]


let array = ["a", "b", "c"]
let resultArray = array.enumerated().map { "\($0.element)-\($0.offset)" }
