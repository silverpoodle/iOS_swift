//
//  WordAddedViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import UIKit

class WordAddedViewController: UIViewController {
    var word: String
    var meaning: String

    init(word: String, meaning: String) {
        self.word = word
        self.meaning = meaning
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/225, green: 220/225, blue: 172/225, alpha: 1.0)
        view.layer.cornerRadius = 10

        let wordLabel = UILabel()
        wordLabel.text = "단어: \(word)"
        wordLabel.font = .systemFont(ofSize: 18)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false

        let meaningLabel = UILabel()
        meaningLabel.text = "뜻: \(meaning)"
        meaningLabel.font = .systemFont(ofSize: 18)
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(wordLabel)
        view.addSubview(meaningLabel)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),

            meaningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),

            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 20),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

