//
//  ConversionViewController.swift
//  ProgrammingView
//
//  Created by Son Jungin on 2024/04/23.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet weak var birdImageView: UIImageView!
    
    @IBOutlet weak var birdLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var birdTopContraint: NSLayoutConstraint!
    
    var timer: Timer!
    var direction = 1
    
    @objc func timerAction() {
        birdLeadingConstraint.constant += CGFloat(direction*10)
        
        if birdLeadingConstraint.constant + birdImageView.frame.size.width >= view.frame.size.width{
        direction = -1
        birdImageView.transform = .init(scaleX: -1, y: 1) }
        else if birdLeadingConstraint.constant < 0{
        direction = 1
        birdImageView.transform = .init(scaleX: 1, y: 1) }
    }

    @objc func buttonPressed(_ sender: UIButton){
        if let text = sender.titleLabel?.text{
            if text == "start"{
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                selector: #selector(timerAction),
                userInfo: nil, repeats: true)
            }else{
                timer.invalidate()
            }
            sender.setTitle((text == "Start") ? "Stop" : "Start", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setTitle("start", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ]);
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
    }
}

