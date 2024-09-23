
extension UIApplication {
    // Function to get risk impact description using ranges
    @objc func getRiskImpact(_ impact: Double) -> String {
        switch impact {
        case 0...2:
            return NSLocalizedString("riskTitleImpLow", comment: "Low Impact")
        case 2.1...4:
            return NSLocalizedString("riskTitleImpModerate", comment: "Moderate Impact")
        case 4.1...6:
            return NSLocalizedString("riskTitleImpSignificant", comment: "Significant Impact")
        case 6.1...8:
            return NSLocalizedString("riskTitleImpHigh", comment: "High Impact")
        case 8.1...10:
            return NSLocalizedString("riskTitleImpCatastrophic", comment: "Catastrophic Impact")
        default:
            return NSLocalizedString("UnKnown", comment: "Unknown Impact")
        }
    }

    // Function to get risk probability description using ranges
    @objc func getRiskProbability(_ prob: Double) -> String {
        switch prob {
        case 0...2:
            return NSLocalizedString("riskTitleProbUnlikely", comment: "Unlikely Probability")
        case 2.1...4:
            return NSLocalizedString("riskTitleProbSeldom", comment: "Seldom Probability")
        case 4.1...6:
            return NSLocalizedString("riskTitleProbOccasional", comment: "Occasional Probability")
        case 6.1...8:
            return NSLocalizedString("riskTitleProbLikely", comment: "Likely Probability")
        case 8.1...10:
            return NSLocalizedString("riskTitleProbFrequent", comment: "Frequent Probability")
        default:
            return NSLocalizedString("UnKnown", comment: "Unknown Probability")
        }
    }
}
