mport Foundation

func performGraphQLQuery(query: String, variables: [String: Any]?, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    guard let url = URL(string: "YOUR_GRAPHQL_ENDPOINT") else {
        completion(.failure(URLError(.badURL)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    var requestBody: [String: Any] = ["query": query]
    if let variables = variables {
        requestBody["variables"] = variables
    }

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
    } catch {
        completion(.failure(error))
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }

        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let errors = jsonResponse["errors"] {
                    // Handle GraphQL errors
                    print("GraphQL Errors: \(errors)")
                }
                if let data = jsonResponse["data"] as? [String: Any] {
                    completion(.success(data))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } else {
                completion(.failure(URLError(.cannotParseResponse)))
            }
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

// Example Usage
let myQuery = """
query {
  hero {
    name
    appearsIn
  }
}
"""

performGraphQLQuery(query: myQuery, variables: nil) { result in
    switch result {
    case .success(let data):
        print("GraphQL Data: \(data)")
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}
