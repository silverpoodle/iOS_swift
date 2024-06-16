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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 246/255, green: 220/255, blue: 172/255, alpha: 1.0)
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let meaningLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
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
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitle("닫기", for: .normal)
        button.backgroundColor = .systemGray4
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
        containerView.addSubview(meaningLabel)
        containerView.addSubview(closeButton)

        wordLabel.text = "단어: \(word)"
        meaningLabel.text = "뜻: \(meaning)"

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 200),

            wordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            wordLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            meaningLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            meaningLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            meaningLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

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
