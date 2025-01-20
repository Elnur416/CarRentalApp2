//
//  ViewController.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit
import RealmSwift

class LoginController: UIViewController {
    private let viewModel = LoginViewModel()
    private let realm = try? Realm()
    
//MARK: UI elements
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "driveit"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.layer.cornerRadius = 30
        field.textAlignment = .center
        field.isSecureTextEntry = true
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: 16, weight: .regular)
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
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don't have an account?"
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var signUpLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Sign Up"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .left
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUp)))
        lbl.isUserInteractionEnabled = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var bottomStack: UIStackView  = {
        let stc = UIStackView(arrangedSubviews: [bottomLabel, signUpLabel])
        stc.axis = .horizontal
        stc.spacing = 4
        stc.alignment = .center
        stc.translatesAutoresizingMaskIntoConstraints = false
        return stc
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        viewModel.fetchData(realm: realm)
        successHandler()
        errorHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData(realm: realm)
    }
    
    private func configureUI()  {
        view.backgroundColor = UIColor(named: "maincolour")
        backgroundImage.frame = view.bounds
        [backgroundImage,
         imageView,
         logoLabel,
         emailField,
         passwordView,
         forgotPasswordLabel,
         loginButton,
         bottomStack].forEach { view.addSubview($0) }
        
        [passwordField,
         passwordSwitch].forEach({ passwordView.addSubview($0) })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 122),
            imageView.heightAnchor.constraint(equalToConstant: 146),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordView.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
            passwordView.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordField.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: passwordSwitch.leadingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordSwitch.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordSwitch.leadingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: 16),
            passwordSwitch.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func signUp() {
        let controller = RegisterController()
        controller.callBackAction = { email, password in
            self.emailField.text = email
            self.passwordField.text = password
        }
        navigationController?.show(controller, sender: nil)
    }
    
    @objc private func handleSwitch() {
        if passwordSwitch.isOn {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    @objc func handleLogin() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            present(alert, animated: true)
            return
        }
        viewModel.checkuser(email: email, password: password)
        viewModel.manager.setValue(value: true, key: .isLoggedIn)
        
    }
    
    private func successHandler() {
        viewModel.success = {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
            sceneDelegate.tabRoot()
        }
    }
    
    private func errorHandler() {
        viewModel.error = {
            let alert = UIAlertController(title: "Error", message: "Account not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self.present(alert, animated: true)
        }
    }
}

