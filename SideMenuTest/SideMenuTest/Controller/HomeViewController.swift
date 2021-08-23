//
//  HomeViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

final class HomeViewController: UIViewController, SideMenuSuportable {

    // MARK: - Properties
    
    weak var delegate: SideMenuActionDelegate?
    
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
        navigationItem.title = "HomeVC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "closeIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapMenuButton))
    }
    
    // MARK: - Actions
    
    @objc private func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
