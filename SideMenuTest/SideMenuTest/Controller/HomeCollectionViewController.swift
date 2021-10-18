//
//  HomeCollectionViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/10/18.
//

import UIKit

final class HomeCollectionViewController: UIViewController {
    
    private let containerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private let vStackView: UIStackView = {
//        let stackView: UIStackView = .init()
//        stackView.axis = .vertical
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainLayout()
    }
    
    private func setMainLayout() {
        view.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85).isActive = true
        
        containerView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
//        containerView.addSubview(vStackView)
//
//        vStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//        vStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//        vStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        vStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
//
//        vStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//
//        vStackView.addArrangedSubview(collectionView)
    }
}

extension HomeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

