//
//  WordCell.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/17.
//

import UIKit

class WordCell: UITableViewCell {
    static let identifier = "WordCell"
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let translationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sentenceTranslationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(wordLabel)
        contentView.addSubview(translationLabel)
        contentView.addSubview(sentenceLabel)
        contentView.addSubview(sentenceTranslationLabel)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            wordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 5),
            translationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            translationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            sentenceLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 10),
            sentenceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sentenceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            sentenceTranslationLabel.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 5),
            sentenceTranslationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sentenceTranslationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            sentenceTranslationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(word: String, translation: String, sentence: String, sentenceTranslation: String) {
        wordLabel.text = word
        translationLabel.text = translation
        sentenceLabel.text = sentence
        sentenceTranslationLabel.text = sentenceTranslation
    }
}
