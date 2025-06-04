//
//  RiskTImeLineView1.swift
//  eBoard
//
//  Created by Anand Upadhyay on 30/07/24.
//

import Foundation
import UIKit


enum AppConfiguration {
  case Debug
  case TestFlight
  case AppStore
}

//let SWIFT_API_URL = "https://v3.stl-horizon.com/v25/user/create"
func generateSimpleAlert(title:String,message:String,doneAction:String) -> UIAlertController{
    let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
    if !doneAction.isEmpty{
        alert.addAction(UIAlertAction(title: doneAction, style: .default))
    }
    return alert
}

func convertTimeStampToDate(timestamp: String) -> String{
    
    if timestamp.isEmpty {
        return ""
    }
    
    let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp) ?? 0))

     let formatter = DateFormatter()
     formatter.timeZone = TimeZone(abbreviation: "UTC") // Set to UTC
     formatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent format
     formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
     let dateString = formatter.string(from: date)
    return dateString
}

func dataToJsonString(data: Data) -> String? {
    do {
        // Try to parse the data into a JSON object
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        if (try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)) != nil {
            // Convert the JSON object to a data representation with pretty printing
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted){
                // Convert the data back to a string
                return String(data: jsonData, encoding: .utf8)
            }
        }
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
    return nil // Return nil if parsing or conversion fails
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Config {
  // This is private because the use of 'appConfiguration' is preferred.
  private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
  
  // This can be used to add debug statements.
  static var isDebug: Bool {
    #if DEBUG
      return true
    #else
      return false
    #endif
  }

  static var appConfiguration: AppConfiguration {
    if isDebug {
      return .Debug
    } else if isTestFlight {
      return .TestFlight
    } else {
      return .AppStore
    }
  }
}

struct PizzaToppings: OptionSet {
    let rawValue: Int

    static let pepperoni = PizzaToppings(rawValue: 1)
    static let mushrooms = PizzaToppings(rawValue: 2)
    static let onions = PizzaToppings(rawValue: 3)
    static let extraCheese = PizzaToppings(rawValue: 4)

    static let vegetarian: PizzaToppings = [.mushrooms, .onions]
    static let supreme: PizzaToppings = [.pepperoni, .mushrooms, .onions, .extraCheese]
}

class PizzaMaker {
    func order(toppings: PizzaToppings) -> String {
        var price = 10
        var selectedToppings: [String] = []

        let toppingsList: [(PizzaToppings, String)] = [
            (.pepperoni, "Pepperoni"),
            (.mushrooms, "Mushrooms"),
            (.onions, "Onions"),
            (.extraCheese, "Extra Cheese")
        ]

        for (option, name) in toppingsList where toppings.contains(option) {
            selectedToppings.append(name)
            price += 2
        }

        return "Pizza with: \(selectedToppings.joined(separator: ", "))\nPrice: $\(price)"
    }
}

//extension UIApplication {
//    // Function to get risk impact description using ranges
//    @objc func getRiskImpactFrom(_ impact: Double) -> String {
//        switch impact {
//        case 0...2:
//            return NSLocalizedString("riskTitleImpLow", comment: "Low Impact")
//        case 2.1...4:
//            return NSLocalizedString("riskTitleImpModerate", comment: "Moderate Impact")
//        case 4.1...6:
//            return NSLocalizedString("riskTitleImpSignificant", comment: "Significant Impact")
//        case 6.1...8:
//            return NSLocalizedString("riskTitleImpHigh", comment: "High Impact")
//        case 8.1...10:
//            return NSLocalizedString("riskTitleImpCatastrophic", comment: "Catastrophic Impact")
//        default:
//            return NSLocalizedString("UnKnown", comment: "Unknown Impact")
//        }
//    }
//
//    // Function to get risk probability description using ranges
//    @objc func getRiskProbabilityFrom(_ prob: Double) -> String {
//        switch prob {
//        case 0...2:
//            return NSLocalizedString("riskTitleProbUnlikely", comment: "Unlikely Probability")
//        case 2.1...4:
//            return NSLocalizedString("riskTitleProbSeldom", comment: "Seldom Probability")
//        case 4.1...6:
//            return NSLocalizedString("riskTitleProbOccasional", comment: "Occasional Probability")
//        case 6.1...8:
//            return NSLocalizedString("riskTitleProbLikely", comment: "Likely Probability")
//        case 8.1...10:
//            return NSLocalizedString("riskTitleProbFrequent", comment: "Frequent Probability")
//        default:
//            return NSLocalizedString("UnKnown", comment: "Unknown Probability")
//        }
//    }
//}

//class RiskTImeLineView1: UIView {
//    var theme: UIColor = .systemPink
//    override init(frame: CGRect){
//        super.init(frame: frame)
//        self.theme = .systemPink
//        self.configureTimeLine()
//    }
//    
//    init (frame: CGRect,themeColor: UIColor){
//        super.init(frame: frame)
//        self.theme = themeColor
//        self.configureTimeLine()
//    }
//    
//    required init?(coder aDecoder: NSCoder){
//        super.init(coder: aDecoder)
//        self.configureTimeLine()
//    }
//    
//    func configureTimeLine(){
//        self.backgroundColor = .clear
//        self.layer.borderColor = theme.cgColor
//        self.layer.borderWidth = 1
//    }
//    
//}
