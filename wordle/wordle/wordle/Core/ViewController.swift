//
//  ViewController.swift
//  wordle
//
//  Created by Son Jungin on 2024/06/07.
//

import UIKit

class ViewController: UIViewController {

    let answers = [
        "AFTER", "LATER", "BLOKE", "THERE", "ULTRA"
    ]

    var answer = ""

    private var guesses: [[String?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6)

    private var currentGuessIndex = 0

    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
//        answer = answers.randomElement() ?? "AFTER"
        answer = "AFTER"
        view.backgroundColor = UIColor(red: 7/255, green: 33/255, blue: 75/255, alpha: 1.0)
        addChildren()
    }

    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)

        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)

        addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func isGuessComplete() -> Bool {
        return guesses[currentGuessIndex].allSatisfy { $0 != nil }
    }
    
    func showConfetti() {
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: view.bounds.width, height: 1)
        confettiLayer.emitterCells = generateConfettiCells()

        view.layer.addSublayer(confettiLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            confettiLayer.birthRate = 0
        }
    }
    
    func generateConfettiCells() -> [CAEmitterCell] {
        var confettiCells: [CAEmitterCell] = []
        for _ in 0..<10 {
            let cell = CAEmitterCell()
            cell.birthRate = 3
            cell.lifetime = 10.0
            cell.velocity = CGFloat(350)
            cell.velocityRange = CGFloat(80)
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin = 3.5
            cell.spinRange = 1.0
            cell.scale = 0.1
            cell.scaleRange = 0.25
            cell.color = randomColor().cgColor
            cell.contents = UIImage(named: "confetti")?.cgImage
            confettiCells.append(cell)
        }
        return confettiCells
    }

    func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red, .green, .blue, .yellow, .purple, .orange, .cyan, .magenta
        ]
        return colors.randomElement() ?? .white
    }
}

extension ViewController: KeyBoardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: String) {
        guard currentGuessIndex < guesses.count else { return }

        for j in 0..<guesses[currentGuessIndex].count {
            if guesses[currentGuessIndex][j] == nil {
                guesses[currentGuessIndex][j] = letter
                break
            }
        }

        boardVC.reloadData()
    }

    func keyboardViewControllerDidTapDelete(_ vc: KeyboardViewController) {
        guard currentGuessIndex < guesses.count else { return }

        for j in stride(from: guesses[currentGuessIndex].count - 1, through: 0, by: -1) {
            if guesses[currentGuessIndex][j] != nil {
                guesses[currentGuessIndex][j] = nil
                boardVC.reloadData()
                return
            }
        }
    }

//    func keyboardViewControllerDidTapEnter(_ vc: KeyboardViewController) {
//        guard currentGuessIndex < guesses.count else { return }
//
//        if isGuessComplete() {
//            let guess = guesses[currentGuessIndex].compactMap { $0 }
//            checkGuess(guess: guess)
//        }
//    }
    
    func keyboardViewControllerDidTapEnter(_ vc: KeyboardViewController) {
        guard currentGuessIndex < guesses.count else { return }

        if isGuessComplete() {
            let guess = guesses[currentGuessIndex].compactMap { $0 }.joined()
            DictionaryAPI.shared.isValidWord(guess) { [weak self] isValid in
                DispatchQueue.main.async {
                    if isValid {
                        self?.checkGuess(guess: Array(guess).map { String($0) })  // 여기서 Array(guess).map { String($0) } 사용
                    } else {
//                        self?.showInvalidWordAlert()
                        self?.shakeCurrentRow()
                    }
                }
            }
        }
    }
    
    func shakeCurrentRow() {
       guard currentGuessIndex < guesses.count else { return }
       
       for col in 0..<5 {
           let indexPath = IndexPath(item: col, section: currentGuessIndex)
           if let cell = boardVC.collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
               cell.contentView.shake()
           }
       }
   }
    
    func showInvalidWordAlert() {
        let alert = UIAlertController(title: "Invalid Word", message: "The word you entered is not valid. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkGuess(guess: [String]) {
        guard guess.count == answer.count else { return }

        var correctPositions: [Int] = []
        var correctLetters: [Int] = []
        var letterCount = [Character: Int]()

        for (index, char) in answer.enumerated() {
            letterCount[char, default: 0] += 1
        }

        for i in 0..<guess.count {
            let guessChar = guess[i]
            let answerIndex = answer.index(answer.startIndex, offsetBy: i)
            let answerChar = String(answer[answerIndex])
            
            if guessChar == answerChar {
                correctPositions.append(i)
                letterCount[Character(answerChar)]! -= 1
            }
        }

        // Check for correct letters in wrong positions
        for i in 0..<guess.count {
            if !correctPositions.contains(i) {
                let guessChar = guess[i]
                if let count = letterCount[Character(guessChar)], count > 0 {
                    correctLetters.append(i)
                    letterCount[Character(guessChar)]! -= 1
                }
            }
        }

        // Update board colors
        for i in 0..<guess.count {
            let indexPath = IndexPath(item: i, section: currentGuessIndex)
            if correctPositions.contains(i) {
                boardVC.updateBoxColor(at: indexPath, color: .systemGreen)
                keyboardVC.updateKeyColor(letter: guess[i], color: .systemGreen)
            } else if correctLetters.contains(i) {
                boardVC.updateBoxColor(at: indexPath, color: .systemYellow)
                keyboardVC.updateKeyColor(letter: guess[i], color: .systemYellow)
            } else {
                boardVC.updateBoxColor(at: indexPath, color: .systemGray3)
                keyboardVC.updateKeyColor(letter: guess[i], color: .systemGray2)
            }
        }

//        currentGuessIndex += 1
//        boardVC.reloadData()
        
        if correctPositions.count == answer.count {
//                showResult(isWin: true)
            showConfetti()
        } else if currentGuessIndex == guesses.count - 1 {
            showResult(isWin: false)
        } else {
            currentGuessIndex += 1
            boardVC.reloadData()
        }
    }

}

extension ViewController: BoardViewControllerDataSource {
    var currentGuesses: [[String?]] {
        return guesses
    }

    func boxColor(at indexPath: IndexPath) -> UIColor? {
        return nil
    }
}

extension ViewController {
    func showResult(isWin: Bool) {
        let title = isWin ? "You Win!" : "Game Over"
        let message = isWin ? "Congratulations! You've guessed the word." : "The correct word was \(answer)."
        let image = isWin ? "checkmark.circle" : "xmark.circle"
        let imageColor: UIColor = isWin ? .systemGreen : .systemRed

        let secondaryLabelText = NSAttributedString(string: message, attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.tertiaryLabel
        ])
        
        let resultVC = ResultViewController(
            titleLabelText: title,
            secondaryLabelText: secondaryLabelText,
            retryButtonTitle: "Play Again",
            image: image,
            imageColor: imageColor,
            delegate: self
        )
        
        resultVC.modalPresentationStyle = .overFullScreen
        resultVC.modalTransitionStyle = .crossDissolve
        present(resultVC, animated: true, completion: nil)
    }
}


//extension ViewController: ResultViewControllerDelegate {
//    func resetGameboard() {
//        answer = answers.randomElement() ?? "AFTER"
//        guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
//        currentGuessIndex = 0
//        boardVC.cellColors.removeAll()
//        boardVC.reloadData()
//        keyboardVC.keyColors.removeAll()
//        keyboardVC.reloadData()
//    }
//}


extension ViewController: ResultViewControllerDelegate {
    func resetGameboard() {
        answer = answers.randomElement() ?? "AFTER"
        guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
        currentGuessIndex = 0
        boardVC.cellColors.removeAll()
        boardVC.reloadData()
        keyboardVC.keyColors.removeAll()
        keyboardVC.reloadData()
    }
}

extension UIView {
    func shake(duration: CFTimeInterval = 0.5, pathLength: CGFloat = 10) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = [-pathLength, pathLength, -pathLength * 0.7, pathLength * 0.7, -pathLength * 0.4, pathLength * 0.4, -pathLength * 0.1, pathLength * 0.1, 0]
        layer.add(animation, forKey: "shake")
    }
}
