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
        contentView.backgroundColor = .clear
        contentView.transform = .identity
    }
    
    func configure(with letter: String, color: UIColor, isSelected: Bool = false) {
        label.text = letter.uppercased()
        if isSelected {
            contentView.backgroundColor = UIColor(red: 254/255, green: 174/255, blue: 111/255, alpha: 1.0)
//            animateSelection(to: UIColor(red: 254/255, green: 174/255, blue: 111/255, alpha: 1.0))
        } else {
            contentView.backgroundColor = color
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func animateSelection(to color: UIColor) {
        UIView.animate(withDuration: 1.0) {
            self.contentView.backgroundColor = color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            animate(isHighlighted: isHighlighted)
        }
    }
    
    private func animate(isHighlighted: Bool) {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentView.transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        })
    }
}
