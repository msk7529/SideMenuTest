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
    }
    
    @objc private func didTapMenuButton() {
        let sideMenu: MenuViewController = .init()
        sideMenu.transitioningDelegate = self.transitionDelegate
        //sideMenu.delegate = self
        sideMenu.modalPresentationStyle = .custom
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc private func didTapSwitch() {
        print("switch value changed!")
    }
}
