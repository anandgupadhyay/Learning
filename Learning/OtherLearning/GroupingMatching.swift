struct Risk {
    let name: String
    let probability: Int
    let impact: Int
    let id: Int
}

func groupRisks(risks: [Risk]) -> [[Risk]] {
    var groupedRisks: [[Risk]] = []

    for risk in risks {
        var foundGroup = false
        for group in groupedRisks {
            if group.first?.probability == risk.probability && group.first?.impact == risk.impact {
                group.append(risk)
                foundGroup = true
                break
            }
        }

        if !foundGroup {
            groupedRisks.append([risk])
        }
    }

    return groupedRisks
}
