//
//  KeyboardViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/07.
//

import UIKit

protocol KeyBoardViewControllerDelegate: AnyObject {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: String)
    func keyboardViewControllerDidTapDelete(_ vc: KeyboardViewController)
    func keyboardViewControllerDidTapEnter(_ vc: KeyboardViewController)
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: KeyBoardViewControllerDelegate?

    var letters: [[String]] = [
            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
            ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
            ["DEL", "Z", "X", "C", "V", "B", "N", "M", "ENTER"]
        ]
    var keys: [[String]] = []

    var keyColors: [String: UIColor] = [:]

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .clear

        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self


        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func updateKeyColor(letter: String, color: UIColor) {
            keyColors[letter] = color
            reloadData()
    }




}


extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }

        let letter = keys[indexPath.section][indexPath.row]
        let isDelete = (letter == "DEL")
        let isEnter = (letter == "ENTER")
        let color = keyColors[letter] ?? UIColor(red: 55/255, green: 130/255, blue: 143/255, alpha: 1.0)

        cell.configure(with: letter, isDelete: isDelete, isEnter: isEnter, color: color)
        cell.layer.cornerRadius = 5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10

        if indexPath.section == 2 {
            if indexPath.row == 0 || indexPath.row == 8 {
                return CGSize(width: size*1.55, height: size*1.3)
            } else{
                return CGSize(width: size, height: size*1.3)
            }

        }

        return CGSize(width: size, height: size*1.3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var left: CGFloat = 1
        var right: CGFloat = 1

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10

        var count: CGFloat

        switch section {
            case 0:
                count = 10
            case 1:
                count = 9
            case 2:
                count = 10
            default:
                count = 10
            }

        let inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count))/2

        left = inset
        right = inset

        return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]

        if String(letter) == "DEL" {
                delegate?.keyboardViewControllerDidTapDelete(self)
        } else if String(letter) == "ENTER" {
                delegate?.keyboardViewControllerDidTapEnter(self)
        } else {
                delegate?.keyboardViewController(self, didTapKey: letter)
        }
    }
}
