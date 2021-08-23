//
//  HomeController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

final class HomeController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    // MARK: - Helpers

    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Home ViewController"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapMenuButton))
    }
    
    // MARK: - Actions
    
    @objc private func didTapMenuButton() {
        
    }
}
