//
//  BoardViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/07.
//
//

import UIKit

protocol BoardViewControllerDataSource: AnyObject {
    var currentGuesses: [[String?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var datasource: BoardViewControllerDataSource?
    var selectedRow: Int? {
        didSet {
            updateAddButtonState()
        }
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()

    let myWordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "memo"), for: .normal)
        button.tintColor = .systemGray4
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(myWordsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let spacerImageView: UIImageView = {
         let imageView = UIImageView(image: UIImage(named: "image")) // "spacerImage"는 버튼 사이에 추가할 이미지 이름입니다.
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()

//    private(set) var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 4
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        collectionView.backgroundColor = .clear
//
//        collectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.identifier)
//        return collectionView
//    }()
    
    
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .clear

        collectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.identifier)
        return collectionView
    }()

    public var cellColors: [IndexPath: UIColor] = [:]
    
    func updateBoxColor(at indexPath: IndexPath, color: UIColor) {
        cellColors[indexPath] = color
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let buttonStackView = UIStackView(arrangedSubviews: [myWordsButton, spacerImageView, addButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fill
//        buttonStackView.distribution = .fill
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
//        view.addSubview(myWordsButton)
//        view.addSubview(addButton)
        view.addSubview(logoImageView)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 270),

            buttonStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),

            myWordsButton.heightAnchor.constraint(equalToConstant: 40),
            myWordsButton.widthAnchor.constraint(equalToConstant: 40),

            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),

            spacerImageView.heightAnchor.constraint(equalToConstant: 40),
            spacerImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250), // 이미지 너비 제한

//            spacerImageView.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 1.0, constant: -90), // 이미지 너비 설정

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
    }

    func reloadData() {
        collectionView.reloadData()
    }
    
    @objc func myWordsButtonTapped() {
        let myWordsVC = MyWordsViewController()
        navigationController?.pushViewController(myWordsVC, animated: true)
    }
    
    @objc func addButtonTapped() {
        guard let selectedRow = selectedRow, let currentGuesses = datasource?.currentGuesses else { return }
        let selectedGuess = currentGuesses[selectedRow].compactMap { $0 }.joined()
        if !selectedGuess.isEmpty {
            OpenAIAPI.shared.fetchWordDetails(for: selectedGuess) { result in
                switch result {
                case .success(let details):
                    DispatchQueue.main.async {
                        let meaning = details.joined(separator: "\n")
                        let wordAddedVC = WordAddedViewController(word: selectedGuess, meaning: meaning)
                        wordAddedVC.modalPresentationStyle = .overFullScreen
                        self.present(wordAddedVC, animated: true, completion: nil)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let wordAddedVC = WordAddedViewController(word: selectedGuess, meaning: "Error fetching details")
                        wordAddedVC.modalPresentationStyle = .overFullScreen
                        self.present(wordAddedVC, animated: true, completion: nil)
                    }
                    print("Error fetching details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateAddButtonState() {
        if selectedRow != nil {
            addButton.isEnabled = true
            addButton.backgroundColor = .customPink
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .clear
        }
    }

}

extension BoardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = datasource?.currentGuesses ?? []
        return guesses[section].count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.identifier, for: indexPath) as? BoardCell else {
            fatalError()
        }

        let isSelected = (indexPath.section == selectedRow)
        let color = cellColors[indexPath] ?? .clear
        cell.configure(with: datasource?.currentGuesses[indexPath.section][indexPath.row] ?? "", color: color, isSelected: isSelected)
        cell.layer.borderWidth = 1
//        cell.layer.borderColor = .customDarkPurple.cgColor()

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/5
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.section
        collectionView.reloadData()
    }

}
