//
//  HeaderCell.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit

class HeaderCell: UICollectionViewCell {
//    MARK: UI elements
    private lazy var cellView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 30
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let cellImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categorySizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundColor = .systemGray6
        [cellView,
         cellImage].forEach { addSubview($0) }
        [categoryNameLabel,
         categorySizeLabel].forEach { cellView.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cellImage.widthAnchor.constraint(equalToConstant: 150),
            cellImage.heightAnchor.constraint(equalToConstant: 86),
            cellImage.topAnchor.constraint(equalTo: topAnchor, constant: 8 ),
            cellImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            categorySizeLabel.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 8),
            categorySizeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            categorySizeLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            
            categoryNameLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            categoryNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            categoryNameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0)
            ])
    }
//    MARK: - Configure Data
    func configure(model: CategoryList) {
        cellImage.image = UIImage(named: model.image ?? "")
        categoryNameLabel.text = model.name
        categorySizeLabel.text = String(model.size)
        configureView(isSelected: model.isSelected)
    }
    
    func configureView(isSelected: Bool) {
        cellView.backgroundColor = isSelected ? .maincolour : .white
        categoryNameLabel.textColor = isSelected ? .white : .black
        categorySizeLabel.textColor = isSelected ? .white : .darkGray
    }
}
