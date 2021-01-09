//
//  RegisterScreenViewController.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class RegisterScreenViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    let viewModel: RegisterScreenViewModel = RegisterScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
    }

    @IBAction func onCreateAccountClick(_ sender: Any) {
        guard usernameTextField.text != "", passwordTextField.text != "", confirmPasswordTextField.text != "", countryTextField.text != "" else {
            CTUserExplorerUtils.showGenericOkAlert(title: nil, message: Messages.FILL_UP_REQUIRED_FIELDS)
            return
        }
        guard passwordTextField.text == confirmPasswordTextField.text else {
            CTUserExplorerUtils.showGenericOkAlert(title: nil, message: Messages.PASSWORDS_DO_NOT_MATCH)
            return
        }
        viewModel.registerUser(username: usernameTextField.text!, password: passwordTextField.text!, country: countryTextField.text!) { (success, message) in
            CTUserExplorerUtils.showGenericOkAlert(title: nil, message: message, handler: { (action) in
                if success {
                    //push to dashboard
                }
            })
        }
        
    }
    
}

extension RegisterScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        countryTextField.inputView = pickerView
        addDismissPickerViewButton()
    }
    
    func addDismissPickerViewButton() {
       let toolbar = UIToolbar()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
       toolbar.sizeToFit()
       toolbar.setItems([doneButton], animated: true)
       toolbar.isUserInteractionEnabled = true
       countryTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissAction() {
        countryTextField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = viewModel.countries[row]
        countryTextField.text = selectedCountry
    }
}
