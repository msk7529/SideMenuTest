//
//  SideMenuTopViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/28.
//

import UIKit

final class SideMenuTopViewController: UIViewController {
    
    // MARK: - Properteis
    private let containerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = .systemBlue  // shadow 효과를 줄 때 반드시 해당 뷰에 bgColor를 지정해주어야 함. 그렇지 않으면(.clear) 쉐도우컬러가 뷰에 입혀짐
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let hStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let vStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally    // 이거 개선할 방법이 없나 ..
        stackView.spacing = 0
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .zero)
        imageView.image = UIImage(named: "giftIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "김민섭"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "서울시 오금동"
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        setUpViewStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpViewStyle()
    }
    
    // MARK: - Helpers
    private func initView() {
        view.backgroundColor = .clear

        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.addSubview(hStackView)
        
        hStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        hStackView.addArrangedSubview(iconImageView)
                
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        hStackView.addArrangedSubview(vStackView)
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(addressLabel)
    }
    
    private func setUpViewStyle() {
        containerView.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 0.7

        containerView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12).cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = false
    }
}
