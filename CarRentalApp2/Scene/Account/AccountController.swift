//
//  AccountController.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit
import RealmSwift

class AccountController: UIViewController {
    private let viewModel = AccountViewModel()
    private let realm = try? Realm()
    
    //MARK: UI elements
    
    private let imagePicker = UIImagePickerController()
    
    private lazy var topView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let profileImage: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.image = UIImage(systemName: "person.circle")
        i.tintColor = .lightGray
        i.layer.cornerRadius = 70
        i.clipsToBounds = true
        i.layer.borderWidth = 1
        i.layer.borderColor = UIColor.black.cgColor
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var changeProfileImageButton: UIButton = {
        let i = UIButton()
        i.setImage(UIImage(systemName: "plus"), for: .normal)
        i.tintColor = .white
        i.layer.cornerRadius = 14
        i.backgroundColor = .black
        i.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var accountInfoStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [fullnameView, birthdateView, phoneView, emailView])
        s.axis = .vertical
        s.distribution = .fillEqually
        s.spacing = 32
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    //    Fullname
    private let fullnameView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let nameImage: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.image = UIImage(systemName: "person.crop.square")
        i.tintColor = .black
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.text = "Fullname"
        l.textColor = .black
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let usernameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //    BirthDate
    private let birthdateView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let dateImage: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.image = UIImage(systemName: "calendar")
        i.tintColor = .black
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private let birthdayLabel: UILabel = {
        let l = UILabel()
        l.text = "Birthday"
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let userBirthday: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //    PhoneNumber
    private let phoneView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let phoneImage: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.image = UIImage(systemName: "phone")
        i.tintColor = .black
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private let phoneLabel: UILabel = {
        let l = UILabel()
        l.text = "Phone Number"
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let userPhone: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //    Email
    private let emailView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let emailImage: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.image = UIImage(systemName: "envelope.fill")
        i.tintColor = .black
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private let emailLabel: UILabel = {
        let l = UILabel()
        l.text = "Email"
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let userEmail: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //    MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        viewModel.fetchData(realm: realm)
        configureUserInfo()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        [topView,
         accountInfoStack].forEach { view.addSubview($0) }
        
        [profileImage,
         changeProfileImageButton].forEach { topView.addSubview($0) }
        
        [nameImage,
         nameLabel,
         usernameLabel].forEach { fullnameView.addSubview($0) }
        
        [dateImage,
         birthdayLabel,
         userBirthday].forEach { birthdateView.addSubview($0) }
        
        [phoneImage,
         phoneLabel,
         userPhone].forEach { phoneView.addSubview($0) }
        
        [emailImage,
         emailLabel,
         userEmail].forEach { emailView.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            topView.heightAnchor.constraint(equalToConstant: 140),
            topView.widthAnchor.constraint(equalToConstant: 140),
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            changeProfileImageButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            changeProfileImageButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            changeProfileImageButton.heightAnchor.constraint(equalToConstant: 28),
            changeProfileImageButton.widthAnchor.constraint(equalToConstant: 28),
            
            profileImage.heightAnchor.constraint(equalToConstant: 140),
            profileImage.widthAnchor.constraint(equalToConstant: 140),
            
            accountInfoStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40),
            accountInfoStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            accountInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            fullnameView.heightAnchor.constraint(equalToConstant: 60),
            birthdateView.heightAnchor.constraint(equalToConstant: 60),
            phoneView.heightAnchor.constraint(equalToConstant: 60),
            emailView.heightAnchor.constraint(equalToConstant: 60),
            
            nameImage.widthAnchor.constraint(equalToConstant: 32),
            nameImage.heightAnchor.constraint(equalToConstant: 32),
            nameImage.centerYAnchor.constraint(equalTo: fullnameView.centerYAnchor),
            nameImage.leadingAnchor.constraint(equalTo: fullnameView.leadingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor, constant: 40),
            nameLabel.topAnchor.constraint(equalTo: fullnameView.topAnchor, constant: 10),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            dateImage.widthAnchor.constraint(equalToConstant: 32),
            dateImage.heightAnchor.constraint(equalToConstant: 32),
            dateImage.centerYAnchor.constraint(equalTo: birthdateView.centerYAnchor),
            dateImage.leadingAnchor.constraint(equalTo: birthdateView.leadingAnchor),
            
            birthdayLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 40),
            birthdayLabel.topAnchor.constraint(equalTo: birthdateView.topAnchor, constant: 10),
            
            userBirthday.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 4),
            userBirthday.leadingAnchor.constraint(equalTo: birthdayLabel.leadingAnchor),
            
            phoneImage.widthAnchor.constraint(equalToConstant: 32),
            phoneImage.heightAnchor.constraint(equalToConstant: 32),
            phoneImage.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor),
            phoneImage.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor),
            
            phoneLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 40),
            phoneLabel.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 10),
            
            userPhone.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            userPhone.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor),
            
            emailImage.widthAnchor.constraint(equalToConstant: 32),
            emailImage.heightAnchor.constraint(equalToConstant: 32),
            emailImage.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
            emailImage.leadingAnchor.constraint(equalTo: emailView.leadingAnchor),
            
            emailLabel.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 40),
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 10),
            
            userEmail.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            userEmail.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor)
        ])
    }
    
    private func configureUserInfo() {
        usernameLabel.text = viewModel.users[self.viewModel.manager.getUserIndex(key: .getUserIndex)].fullname
        userBirthday.text = viewModel.users[self.viewModel.manager.getUserIndex(key: .getUserIndex)].birthdate
        userPhone.text = viewModel.users[self.viewModel.manager.getUserIndex(key: .getUserIndex)].phone
        userEmail.text = viewModel.users[self.viewModel.manager.getUserIndex(key: .getUserIndex)].email
    }
    
    @objc private func didTapButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension AccountController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImage.image = pickedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
