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

    func isValidWord(_ word: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
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
}
