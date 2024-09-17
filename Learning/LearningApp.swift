//
//  LearningApp.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/10/23.
//

import SwiftUI

//Extension to get string from double if the number has decimal points then it will display numbers if not then plain number
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView()
        }
    }
}

/*
 let string1 = "Fußball"
 let string2 = "FUSSBALL"

 // Prints `false`
 print(string1.lowercased() == string2.lowercased())
 ======
 let result = string1.compare(string2, options: [.caseInsensitive, .diacriticInsensitive])
 if result == .orderedSame {
     print("The strings are considered equal.")
 }
 =====
 let filenames = ["File10.txt", "file2.txt", "FILE1.txt"]
 let sortedFilenames = filenames.sorted(
     by: { $0.localizedStandardCompare($1) == .orderedAscending }
 )

 // Prints `["FILE1.txt", "file2.txt", "File10.txt"]`
 print(sortedFilenames)
 */
