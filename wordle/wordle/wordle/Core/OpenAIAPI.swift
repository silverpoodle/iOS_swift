//
//  OpenAIAPI.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import Foundation

struct OpenAIAPI {
    static let shared = OpenAIAPI()

    private let apiKey = ""
    private let baseURL = "https://api.openai.com/v1/chat/completions"

    func fetchWordDetails(for word: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let systemPrompt = """
        Follow the steps below for word:
        1. translate in Korean (less than 10 words)
        2. write example sentence in English (less than 30 words)
        3. translate sentence in Korean

        return response in list [1,2,3]
        """
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "system",
                    "content": systemPrompt
                ],
                [
                    "role": "user",
                    "content": "word: \(word)"
                ]
            ]
        ]

        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                let choices = jsonResponse?["choices"] as? [[String: Any]]
                let message = choices?.first?["message"] as? [String: Any]
                let content = message?["content"] as? String ?? "No response found"
                print(content)

                // JSON 파싱
                let trimmedContent = content.trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
                let responseList = trimmedContent.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                completion(.success(responseList))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
