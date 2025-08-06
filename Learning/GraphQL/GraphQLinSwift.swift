/*
1. Constructing the GraphQL Request:
Define the Query/Mutation: Write your GraphQL query or mutation string.
Create the Request Body: Encapsulate the query/mutation string and any variables in a JSON object, following the GraphQL request specification. This typically includes a query field and an optional variables field.
2. Sending the HTTP Request:
Use URLSession: Leverage Swift's built-in URLSession to send an HTTP POST request to your GraphQL endpoint.
Set Headers: Ensure the Content-Type header is set to application/json.
Attach the Request Body: Convert your JSON request body into Data and set it as the httpBody of your URLRequest.
3. Handling the Response:
Parse the JSON Response:
Upon receiving a response, parse the JSON data using JSONSerialization or Codable to extract the data and errors fields.
Error Handling:
Check for the presence of the errors field in the response and handle any GraphQL errors accordingly.
Data Extraction:
Extract the relevant data from the data field and map it to your Swift models.
*/

import Foundation

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
