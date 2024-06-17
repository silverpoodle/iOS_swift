//
//  KeyCell.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/07.
//

import UIKit

class KeyCell: UICollectionViewCell {

    static let identifier = "KeyCell"

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 5
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(with letter: String, isDelete: Bool = false, isEnter: Bool = false, color: UIColor) {
        label.text = String(letter).uppercased()
        if isDelete {
            contentView.backgroundColor = .customRed
        } else if isEnter {
            contentView.backgroundColor = .customGreen
        } else {
            contentView.backgroundColor = color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            animate(isHighlighted: isHighlighted)
        }
    }

    private func animate(isHighlighted: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            self.contentView.backgroundColor = isHighlighted ? self.contentView.backgroundColor?.withAlphaComponent(0.7) : self.contentView.backgroundColor?.withAlphaComponent(1.0)
        })
    }
}
