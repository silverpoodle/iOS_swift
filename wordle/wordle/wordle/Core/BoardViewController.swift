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
    var selectedRow: Int?

    let myWordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" 나의 단어장 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(myWordsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" + ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

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

        view.addSubview(collectionView)
        view.addSubview(myWordsButton)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            myWordsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            myWordsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myWordsButton.heightAnchor.constraint(equalToConstant: 40),

            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor), // 정사각형 설정

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: myWordsButton.bottomAnchor, constant: 20),
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
    
//    @objc func addButtonTapped() {
//        guard let selectedRow = selectedRow, let currentGuesses = datasource?.currentGuesses else { return }
//        let selectedGuess = currentGuesses[selectedRow].compactMap { $0 }.joined()
//        if !selectedGuess.isEmpty {
//            let meaning = "Example meaning for \(selectedGuess)"
//            MyWords.shared.addWord(selectedGuess, meaning: meaning)
//
//            let wordAddedVC = WordAddedViewController(word: selectedGuess, meaning: meaning)
//            wordAddedVC.modalPresentationStyle = .overFullScreen
//            present(wordAddedVC, animated: true, completion: nil)
//        }
//    }
    @objc func addButtonTapped() {
        guard let selectedRow = selectedRow, let currentGuesses = datasource?.currentGuesses else { return }
        let selectedGuess = currentGuesses[selectedRow].compactMap { $0 }.joined()
        if !selectedGuess.isEmpty {
            DictionaryAPI.shared.fetchMeaning(for: selectedGuess) { result in
                switch result {
                case .success(let meaning):
                    DispatchQueue.main.async {
                        let wordAddedVC = WordAddedViewController(word: selectedGuess, meaning: meaning)
                        MyWords.shared.addWord(selectedGuess, meaning: meaning)
                        wordAddedVC.modalPresentationStyle = .overFullScreen
                        self.present(wordAddedVC, animated: true, completion: nil)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let wordAddedVC = WordAddedViewController(word: selectedGuess, meaning: "No definition found")
                        wordAddedVC.modalPresentationStyle = .overFullScreen
                        self.present(wordAddedVC, animated: true, completion: nil)
                    }
                    print("Error fetching meaning: \(error.localizedDescription)")
                }
            }
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
        cell.layer.borderColor = UIColor.systemGray3.cgColor

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
