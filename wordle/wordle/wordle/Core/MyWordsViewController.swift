//
//  MyWordsViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import UIKit

class MyWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = "나의 단어장"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyWords.shared.getAllWords().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as? WordCell else {
            return UITableViewCell()
        }
        
        let wordDetails = MyWords.shared.getAllWords()[indexPath.row]
        if let word = wordDetails["word"],
           let translation = wordDetails["translation"],
           let sentence = wordDetails["sentence"],
           let sentenceTranslation = wordDetails["sentenceTranslation"] {
            cell.configure(word: word, translation: translation, sentence: sentence, sentenceTranslation: sentenceTranslation)
        }

        // 배경색을 번갈아가며 설정
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemGray5
            cell.wordLabel.textColor = .customBackground
            cell.translationLabel.textColor = .customBackground
            cell.sentenceLabel.textColor = .customBackground
            cell.sentenceTranslationLabel.textColor = .customBackground
        } else {
            cell.backgroundColor = .customBackground
            cell.wordLabel.textColor = .systemGray5
            cell.translationLabel.textColor = .systemGray5
            cell.sentenceLabel.textColor = .systemGray5
            cell.sentenceTranslationLabel.textColor = .systemGray5
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MyWords.shared.removeWord(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
