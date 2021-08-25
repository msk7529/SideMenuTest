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
    
    private lazy var button2: UIButton = {
        let button: UIButton = .init(frame: .zero)
        button.backgroundColor = .systemGreen
        button.setTitle("Move", for: .normal)
        button.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(button)
        self.view.addSubview(button2)
        
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        button2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        button2.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 50).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc private func didTapButton() {
        // ContainerVC를 이용한 사이드메뉴 노출방식
        self.present(ContainerViewController(rootViewController: HomeViewController()), animated: true, completion: nil)
    }
    
    @objc private func didTapButton2() {
        // 트랜지션을 이용한 사이드메뉴 노출방식
        let naviVC = UINavigationController(rootViewController: HomeViewController2())
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
    }
}
