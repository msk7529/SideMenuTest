//
//  HomeNextViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/25.
//

import UIKit

final class HomeNextViewController: UIViewController, SideMenuTranstionSuportable {
    
    private lazy var customSwitch: HomeCustomSwitch = {
        let customSwitch: HomeCustomSwitch = .init(titles: ["도레미파", "솔라시도"])
        customSwitch.backgroundColor = .white
        customSwitch.selectedBackgroundColor = .darkGray
        customSwitch.selectedTitleColor = .white
        customSwitch.titleColor = .darkGray
        customSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        customSwitch.layer.borderWidth = 0.3
        customSwitch.layer.borderColor = UIColor.darkGray.cgColor
        customSwitch.layer.masksToBounds = true
        customSwitch.addTarget(self, action: #selector(didTapSwitch), for: .valueChanged)
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        return customSwitch
    }()
    
    private let containerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .zero)
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let testLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "1231231123412341234"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal lazy var transitionDelegate: SideMenuTransitionDelegate = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        initView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "HomeNextVC"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = menuButton
    }
    
    private func initView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(customSwitch)
        
        customSwitch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        customSwitch.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        customSwitch.widthAnchor.constraint(equalToConstant: 130).isActive = true
        customSwitch.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: customSwitch.bottomAnchor, constant: 20).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.containerView.addSubview(containerStackView)
        
//        containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerStackView.addArrangedSubview(imageContainerView)
        containerStackView.addArrangedSubview(testLabel)

        imageContainerView.addSubview(imageView)
        
        imageContainerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        imageContainerView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
                
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //testLabel.setContentHuggingPriority(UILayoutPriority(999), for: .horizontal)
    }
    
    @objc private func didTapMenuButton() {
        let sideMenu: SideMenuViewController = .init()
        sideMenu.transitioningDelegate = self.transitionDelegate
        //sideMenu.delegate = self
        sideMenu.modalPresentationStyle = .custom
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc private func didTapSwitch() {
        print("switch value changed!")
    }
}
