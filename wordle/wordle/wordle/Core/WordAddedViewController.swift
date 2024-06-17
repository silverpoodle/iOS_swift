import UIKit

class WordAddedViewController: UIViewController {

    var word: String
    var meaning: String

    init(word: String, meaning: String) {
        self.word = word
        self.meaning = meaning
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve

        let details = meaning.split(separator: "\n").map { String($0) }
        if details.count == 3 {
            MyWords.shared.addWord(word, translation: details[0], sentence: details[1], sentenceTranslation: details[2])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemGray4
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let translationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .customBackground
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 여러 줄을 표시하도록 설정
        label.textColor = .customDarkPurple
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let sentenceTranslationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 여러 줄을 표시하도록 설정
        label.textColor = .customDarkPurple
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle("닫기", for: .normal)
        button.backgroundColor = .customPink
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(containerView)
        containerView.addSubview(wordLabel)
        containerView.addSubview(translationLabel)
        containerView.addSubview(sentenceLabel)
        containerView.addSubview(sentenceTranslationLabel)
        containerView.addSubview(closeButton)

        let details = meaning.split(separator: "\n").map { String($0) }
        wordLabel.text = "단어: \(word)"
        translationLabel.text = "\(details[0])"
        sentenceLabel.text = "\(details[1])"
        sentenceTranslationLabel.text = "\(details[2])"

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 350),
            containerView.heightAnchor.constraint(equalToConstant: 400),

            wordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            wordLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            translationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            translationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            translationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            sentenceLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 20),
            sentenceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            sentenceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            sentenceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            sentenceTranslationLabel.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 20),
            sentenceTranslationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            sentenceTranslationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            sentenceTranslationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
