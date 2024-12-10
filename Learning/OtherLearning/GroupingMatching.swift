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
// Using
let risks = [
    Risk(name: "Risk One", probability: 5, impact: 4, id: 1),
    Risk(name: "Risk Two", probability: 4, impact: 2, id: 2),
    Risk(name: "Risk Three", probability: 4, impact: 2, id: 3),
    Risk(name: "Risk Four", probability: 5, impact: 4, id: 4)
]

let groupedRisks = groupRisks(risks: risks)
print(groupedRisks)
