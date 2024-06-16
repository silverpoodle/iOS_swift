//
//  BoardCell.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/08.
//

import UIKit

class BoardCell: UICollectionViewCell  {
    static let identifier = "GameboardCell"

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor(red: 55/255, green: 130/255, blue: 143/255, alpha: 1.0).cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(with letter: String) {
        label.text = letter.uppercased()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
