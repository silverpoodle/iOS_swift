//
//  MyWords.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import Foundation

class MyWords {
    static let shared = MyWords()
    private init() {}

    var words: [(word: String, meaning: String)] = []

    func addWord(_ word: String, meaning: String) {
        words.append((word, meaning))
    }
}
