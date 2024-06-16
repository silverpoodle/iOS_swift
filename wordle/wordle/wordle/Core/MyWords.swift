//
//  MyWords.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import Foundation

class MyWords {
    static let shared = MyWords()
    private var words: [[String: String]] = []

    private init() {}

    func addWord(_ word: String, translation: String, sentence: String, sentenceTranslation: String) {
        let wordDetails: [String: String] = [
            "word": word,
            "translation": translation,
            "sentence": sentence,
            "sentenceTranslation": sentenceTranslation
        ]
        words.append(wordDetails)
    }

    func getAllWords() -> [[String: String]] {
        return words
    }
}

