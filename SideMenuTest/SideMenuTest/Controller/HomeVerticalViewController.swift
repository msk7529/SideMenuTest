//
//  HomeVerticalViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/26.
//

import UIKit

final class HomeVerticalViewController: UIViewController, Refreshable {
    
    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .clear
//        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
//        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let hStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
//        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
//        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let secondTapStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    
    private lazy var importantButton: UIButton = {
        let button: UIButton = .init(type: .custom)
        button.setTitle(" 중요", for: .normal)
        button.setImage(UIImage(named: "importantIcon"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBackground
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 0)
        button.adjustsImageWhenHighlighted = false
        button.layer.cornerRadius = 35 / 2
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapImportantButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
        
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        
        initView()
    }
    
    // MARK: - Helpers
    private func initView() {
        view.addSubview(mainStackView)

        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(customSwitch)
        hStackView.addArrangedSubview(UIView())
        hStackView.addArrangedSubview(importantButton)
        
        customSwitch.widthAnchor.constraint(equalToConstant: 160).isActive = true
        customSwitch.heightAnchor.constraint(equalToConstant: 35).isActive = true
        importantButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        mainStackView.setCustomSpacing(50, after: hStackView)
        mainStackView.addArrangedSubview(secondTapStackView)
        
        configureSecondTapStackView()
        
        secondTapStackView.isHidden = true
    }
    
    private func configureSecondTapStackView() {
        for i in 0..<10 {
            let item: HomeSecondTapVerticalItem = .init(frame: .zero)
            item.subjectText = "\(i)번째"
            secondTapStackView.addArrangedSubview(item)
        }
    }

    // MARK: - Refreshable
    func refreshItem() {
        
    }
    
    // MARK: - Actions
    @objc private func didTapSwitch() {
        if customSwitch.selectedIndex == 0 {
            secondTapStackView.isHidden = true
        } else {
            UIView.animate(withDuration: 0.1) {
                self.secondTapStackView.isHidden = false
            }
        }
        print("switch value changed!")
    }
    
    @objc private func didTapImportantButton() {
        print("did Tap importantButton!")
    }
}

