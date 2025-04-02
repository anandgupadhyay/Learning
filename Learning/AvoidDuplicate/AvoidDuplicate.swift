//Problmem Statement
/*
 class Outlet: NSObject {
    var OutletName: String
    var OutletID: String
    
    init(OutletName: String, OutletID: String) {
        self.OutletName = OutletName
        self.OutletID = OutletID
    }
}
let outlet1 = Outlet(OutletName: "Outlet A", OutletID: "001")
let outlet2 = Outlet(OutletName: "Outlet B", OutletID: "002")
let outlet3 = Outlet(OutletName: "Outlet A", OutletID: "001")  // Duplicate
let outlet4 = Outlet(OutletName: "Outlet C", OutletID: "003")

let outlets = [outlet1, outlet2, outlet3, outlet4]

This outlets need to be unique values
*/

//Solution
class Outlet: NSObject, Equatable, Hashable {
    var OutletName: String
    var OutletID: String
    
    init(OutletName: String, OutletID: String) {
        self.OutletName = OutletName
        self.OutletID = OutletID
    }
    
    static func == (lhs: Outlet, rhs: Outlet) -> Bool {
        return lhs.OutletID == rhs.OutletID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(OutletID) // Use OutletID for hashing
    }
}

// Following are objects
let outlet1 = Outlet(OutletName: "Outlet A", OutletID: "001")
let outlet2 = Outlet(OutletName: "Outlet B", OutletID: "002")
let outlet3 = Outlet(OutletName: "Outlet A", OutletID: "001")  // Duplicate
let outlet4 = Outlet(OutletName: "Outlet C", OutletID: "003")

// Create an array with potential duplicates
let outlets = [outlet1, outlet2, outlet3, outlet4]

// Use a Set to filter out duplicates
var uniqueOutlets = Set<Outlet>(outlets)

// Convert the Set back to an Array if needed
let uniqueOutletsArray = Array(uniqueOutlets)

// Print unique outlets
for outlet in uniqueOutletsArray {
    print("Outlet Name: \(outlet.OutletName), Outlet ID: \(outlet.OutletID)")
}
