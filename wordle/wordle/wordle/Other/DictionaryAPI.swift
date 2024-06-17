//
//  DictionaryAPI.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/15.
//

import Foundation

class DictionaryAPI {
    static let shared = DictionaryAPI()
    private init() {}
    
    private let baseURL = "https://api.dictionaryapi.dev/api/v2/entries"

    func isValidWord(_ word: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/en/\(word)") else {
            completion(false)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                if let _ = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }
        task.resume()
    }
    
    func fetchMeaning(for word: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "\(baseURL)/en/\(word)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                let meanings = json?.first?["meanings"] as? [[String: Any]]
                let definitions = meanings?.first?["definitions"] as? [[String: Any]]
                let definition = definitions?.first?["definition"] as? String ?? "No definition found"
                completion(.success(definition))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
