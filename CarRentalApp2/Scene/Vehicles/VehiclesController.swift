//
//  VehiclesController.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit

class VehiclesController: UIViewController {
    private let viewModel = VehiclesViewModel()
    
//  MARK: UI elements
    private lazy var searchField: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 30
        txt.backgroundColor = .white
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        txt.leftViewMode = .always
        txt.placeholder = "Search for a car"
        txt.tintColor = .black
        let rightIcon = UIImageView(frame: CGRect(x: 10, y: 12.5, width: 24, height: 24))
        rightIcon.tintColor = .black
        rightIcon.image = UIImage(systemName: "magnifyingglass")
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView.addSubview(rightIcon)
        txt.rightViewMode = .always
        txt.rightView = rightView
        txt.addTarget(self, action: #selector(searchTextDidChange), for: .editingChanged)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 40, bottom: 20, right: 40)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .systemGray6
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
        c.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
//  MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        loadData()
        viewModel.fetchDataForCar()
        viewModel.fetchDataForCategory()
    }
    
    private func configureUI() {
        title = "Car Rental"
        view.backgroundColor = .systemGray6
        [searchField,
         collection].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchField.heightAnchor.constraint(equalToConstant: 60),
            
            collection.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 0),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadData() {
        if viewModel.manager.getBool(key: .isDataLoaded) {
            return
        } else {
            viewModel.loadData()
        }
    }
    
    @objc private func searchTextDidChange() {
        viewModel.isSearchActive = true
        if let text = searchField.text, !text.isEmpty {
            viewModel.searchedCars = viewModel.cars.filter ({ $0.brand?.lowercased().contains(text.lowercased()) ?? false })
            collection.reloadData()
        } else {
            viewModel.isSearchActive = false
            collection.reloadData()
        }
    }
}

extension VehiclesController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isSearchActive {
            viewModel.searchedCars.count
        } else {
            if viewModel.selectedCategory == nil {
                viewModel.cars.count
            } else {
                viewModel.carsForSelectedCategory.count
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        if viewModel.isSearchActive {
            cell.configure(model: viewModel.searchedCars[indexPath.row])
        } else {
            if viewModel.selectedCategory == nil {
                cell.configure(model: viewModel.cars[indexPath.row])
            } else {
                cell.configure(model: viewModel.carsForSelectedCategory[indexPath.row])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        header.configureData(data: viewModel.categories)
        header.categoryAction = { category in
            self.viewModel.selectedCategory = category
            self.viewModel.carsForSelectedCategory = self.viewModel.cars.filter ({ $0.category?.contains(self.viewModel.selectedCategory ?? "") ?? false})
            self.collection.reloadData()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.size.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width / 1 - 80, height: 330)
    }
}
