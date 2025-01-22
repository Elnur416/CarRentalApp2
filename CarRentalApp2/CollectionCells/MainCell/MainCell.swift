//
//  MainCell.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit

class MainCell: UICollectionViewCell {
//    MARK: UI elements
    private lazy var mainStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [leftSatck, rightStack])
        s.axis = .horizontal
//        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var leftSatck: UIStackView = {
        let s = UIStackView(arrangedSubviews: [brandName, modelName, leftLabel])
        s.axis = .vertical
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var rightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [price, rightLabel, engineModel])
        s.axis = .vertical
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let brandName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.text = "Toyota"
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let modelName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.text = "Yaris"
        l.textColor = .lightGray
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let leftLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.text = "Engine"
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let price: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 28, weight: .thin)
        l.text = "$350"
        l.textColor = UIColor(named: "maincolour")
        l.numberOfLines = 0
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let rightLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.text = "/ month"
        l.textColor = .lightGray
        l.numberOfLines = 0
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let engineModel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.text = "4-Cyl 1.5 Liter"
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let carImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 30
        carImage.image = UIImage(named: "camry")
        [mainStack,
         carImage].forEach { addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            mainStack.bottomAnchor.constraint(equalTo: carImage.topAnchor, constant: -8),
            
            carImage.widthAnchor.constraint(equalToConstant: 320),
            carImage.heightAnchor.constraint(equalToConstant: 160),
            carImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            carImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
//    MARK: - Configure Data
    func configure(model: CarList) {
        brandName.text = model.brand
        modelName.text = model.name
        price.text = "$\(Int(model.price))"
        engineModel.text = model.engine
        carImage.image = UIImage(named: model.image ?? "")
    }
}
