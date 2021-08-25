//
//  HomeNextViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/25.
//

import UIKit

final class HomeNextViewController: UIViewController {
        
    private lazy var sideMenuTransitionDelegate: SideMenuTransitionDelegate = {
        return .init()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        self.view.backgroundColor = .systemBackground

        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "HomeNextVC"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = menuButton
    }
    
    @objc private func didTapMenuButton() {
        let sideMenu: MenuViewController = .init()
        sideMenu.transitioningDelegate = self.sideMenuTransitionDelegate
        //sideMenu.delegate = self
        sideMenu.modalPresentationStyle = .custom
        present(sideMenu, animated: true, completion: nil)
    }
}
