//
//  MyWordsViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/16.
//

import UIKit

class MyWordsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "내 단어장"

        let label = UILabel()
        label.text = "내 단어장 화면"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
