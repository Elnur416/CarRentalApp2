//
//  RegisterController.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import UIKit
import RealmSwift

class RegisterController: UIViewController {
    private let viewModel = RegisterViewModel()
    var callBackAction: ((String, String) -> Void)?
    private let realm = try? Realm()
    
//    MARK: UI elements
    private let datePicker = UIDatePicker()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [fullnameField,birthdateField, phoneNumberField, emailField, passwordView])
        s.axis = .vertical
        s.spacing = 32
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let fullnameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Fullname"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var birthdateField: UITextField = {
        let field = UITextField()
        field.placeholder = "Date of birth"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.addTarget(self, action: #selector(pickDateOfBirth), for: .touchDown)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        field.placeholder = "Phone number"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passwordSwitch: UISwitch = {
        let s = UISwitch()
        s.isOn = false
        s.onTintColor = .white
        s.thumbTintColor = UIColor(named: "maincolour")
        s.backgroundColor = .black
        s.layer.cornerRadius = 16
        s.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var passwordView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(named: "maincolour")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
//        viewModel.readData()
        viewModel.getPath(realm: realm)
        viewModel.fetchItems(realm: realm)
        errorHandler()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "maincolour")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Register"
        self.navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        backgroundImage.frame = view.bounds
        [backgroundImage,
         mainStack,
         registerButton].forEach { view.addSubview($0) }
        
        [passwordField,
         passwordSwitch].forEach({ passwordView.addSubview($0) })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            fullnameField.heightAnchor.constraint(equalToConstant: 60),
            birthdateField.heightAnchor.constraint(equalToConstant: 60),
            phoneNumberField.heightAnchor.constraint(equalToConstant: 60),
            emailField.heightAnchor.constraint(equalToConstant: 60),
            passwordView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordField.heightAnchor.constraint(equalToConstant: 60),
            passwordField.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: passwordSwitch.leadingAnchor, constant: -16),
            
            passwordSwitch.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordSwitch.leadingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: 16),
            passwordSwitch.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func pickDateOfBirth() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClicked))
        toolBar.items = [doneButton]
        birthdateField.inputAccessoryView = toolBar
        birthdateField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        birthdateField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func handleRegister() {
        guard let fullname = fullnameField.text, !fullname.isEmpty,
              let birthdate = birthdateField.text, !birthdate.isEmpty,
              let phone = phoneNumberField.text, !phone.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            present(alert, animated: true)
            return
        }
        
        let user = Users()
        user.fullname = fullname
        user.birthdate = birthdate
        user.phone = phone
        user.email = email
        user.password = password
        viewModel.saveData(realm: realm, user: user)
        callBackAction?(email, password)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSwitch() {
        if passwordSwitch.isOn {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    func errorHandler() {
        viewModel.error = {
            let alert = UIAlertController(title: "Error", message: "Account already exists", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self.present(alert, animated: true)
        }
    }
}
