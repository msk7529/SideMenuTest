//
//  HomeTopBannerTestViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/24.
//

import UIKit

final class HomeTopBannerTestViewController: UIViewController, Refreshable {
    
    // MARK: - Properties
    private let containerView: UIView = .init(frame: .zero)
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .clear
//        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
//        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .zero)
        imageView.image = UIImage(named: "giftIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "홈 상단 배너입니다.(VC)"
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGreen
        
        initView()
        setUpViewStyle()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBannerView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpViewStyle()
    }
    
    // MARK: - Helpers
    private func initView() {
        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
                        
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func initView2() {
        // 제대로 동작하지 않는 코드.
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(descriptionLabel)
        
        iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
    }
    
    private func setUpViewStyle() {
        view.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath    // viewDidLoad에서 setUpViewStyle()을 호출하면 이 라인이 수행이 안됨. view.bounds가 비정상
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.7  // HomeTopBannerView 에서와 같은 값을 주었는데 그림자가 눈에 띄게 차이가 난다. 뭔가 있는듯 ..

        view.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12).cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = false
    }
    
    // MARK: - Actions
    @objc private func didTapBannerView() {
        let nextVC = HomeNextViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - Refreshable
    func refreshItem() {
        descriptionLabel.text = "홈 상단 배너입니다.(VC) (refresh 완료)"
        descriptionLabel.textColor = .systemRed
    }
}
