import Foundation

class MyWords {
    static let shared = MyWords()
    private let wordsKey = "myWordsKey"
    private var words: [[String: String]] = []

    private init() {
        loadWords()
    }

    func addWord(_ word: String, translation: String, sentence: String, sentenceTranslation: String) {
        let wordDetails: [String: String] = [
            "word": word,
            "translation": translation,
            "sentence": sentence,
            "sentenceTranslation": sentenceTranslation
        ]
        words.insert(wordDetails, at: 0)
        saveWords()
    }

    func getAllWords() -> [[String: String]] {
        return words
    }

    func removeWord(at index: Int) {
        words.remove(at: index)
        saveWords()
    }

    private func saveWords() {
        UserDefaults.standard.set(words, forKey: wordsKey)
    }

    private func loadWords() {
        if let savedWords = UserDefaults.standard.array(forKey: wordsKey) as? [[String: String]] {
            words = savedWords
        }
    }
}
