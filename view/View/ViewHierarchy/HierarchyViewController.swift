//
//  HierarchyViewController.swift
//  ViewHierarchy
//
//  Created by Son Jungin on 2024/04/16.
//

import UIKit

class HierarchyViewController: UIViewController {
    
    // 화씨 입력 필드와 섭씨 표시 라벨에 대한 아웃렛
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celciusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰에 탭 제스처를 추가하여 키보드가 나타난 상태에서 빈 공간을 터치할 때 키보드를 숨김
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // 화씨 입력 필드의 delegate self로 설정
        // delegate는 객체의 특정 기능을 다른 객체에게 위임하는 데 사용
        // 여기서는 UITextFieldDelegate의 메소드를 이용하여 텍스트 필드의 동작을 관리
        fahrenheitTextField.delegate = self
    }
    
    // 화씨 입력 필드의 편집이 변경될 때 호출되는 액션 메소드

    @IBAction func ahrenheitEditingChanged(_ sender: UITextField) {
        
        if let text = sender.text {
            if let fahrenheitValue = Double(text){
                let celsiusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                celciusLabel.text=String(format:"%.2f",celsiusValue)
            }else{
                celciusLabel.text = "???"
            }
        }
        
    }
}

extension HierarchyViewController {
    // 탭 제스처에 의해 호출되어 키보드를 숨기는 메소드
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        // 현재 화면에서 화씨 입력 필드의 포커스를 해제하여 키보드를 숨김
        fahrenheitTextField.resignFirstResponder()
    }
}

extension HierarchyViewController: UITextFieldDelegate {
    // 소수점이 이미 존재하는지 확인하고 새로운 소수점 입력을 막는 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existing = textField.text?.range(of: ".")
        let coming = string.range(of: ".")
        if existing != nil, coming != nil {
            // 이미 소수점이 있고 새로운 입력이 소수점인 경우 입력을 막음
            return false
        }
        // 그 외의 경우에는 입력을 허용
        return true
    }
}
