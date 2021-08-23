//
//  FirstViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button: UIButton = .init(frame: .zero)
        button.backgroundColor = .systemGreen
        button.setTitle("Move", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc private func didTapButton() {
        self.present(ContainerViewController(rootViewController: HomeViewController()), animated: true, completion: nil)
    }
}
