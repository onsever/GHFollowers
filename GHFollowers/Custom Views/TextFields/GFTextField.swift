//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissKeyboard() {
        self.resignFirstResponder()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Black in light mode, white in dark mode.
        self.textColor = .label
        // Blinking cursor color.
        self.tintColor = .label
        self.textAlignment = .center
        self.font = .preferredFont(forTextStyle: .title2)
        // If text is long, it will shrink automatically to fit in the TextField.
        self.adjustsFontSizeToFitWidth = true
        // Keep minimum font size 12, even it shrinks automatically.
        self.minimumFontSize = 12
        
        self.backgroundColor = .tertiarySystemBackground
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.smartDashesType = .no
        self.smartInsertDeleteType = .no
        self.smartQuotesType = .no
        self.spellCheckingType = .no
        self.keyboardType = .default
        self.returnKeyType = .go
        
        self.placeholder = "Enter a username"
        
        self.inputAccessoryView = self.configureToolbar()
    }
    
    private func configureToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.sizeToFit()
        
        return toolbar
    }

}
