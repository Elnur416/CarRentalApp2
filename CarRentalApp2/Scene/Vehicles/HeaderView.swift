//
//  HeaderView.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit

class HeaderView: UICollectionReusableView {
    private var categories = [CategoryList]()
    var categoryAction: ((String) -> Void)?
    
//    MARK: UI elements
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Available vehicles"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .systemGray6
        c.dataSource = self
        c.delegate = self
        c.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
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
        [bottomLabel,
        collection].forEach { addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            bottomLabel.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 16),
            
            collection.topAnchor.constraint(equalTo: topAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureData(data: [CategoryList]) {
        self.categories = data
    }
}

//MARK: - CollectionView setup
extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
        cell.configure(model: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width / 2.5, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, _) in categories.enumerated() {
            categories[index].isSelected = index == indexPath.item ? true : false
        }
        collection.reloadData()
        let selectedCategory = categories[indexPath.item].name
        categoryAction?(selectedCategory ?? "")
    }
}
