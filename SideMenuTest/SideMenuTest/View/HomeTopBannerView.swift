//
//  HomeTopBannerView.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/24.
//

import UIKit

final class HomeTopBannerView: UIView, Refreshable {
    
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 16
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
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "홈 상단 배너입니다."
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        setUpViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setUpViewStyle()
    }
        
    // MARK: - Helpers
    private func initView() {
        self.backgroundColor = .systemGreen
        
        addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)

        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpViewStyle() {
        layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath    // init에서 setUpViewStyle()을 호출하면 이 라인이 수행이 안됨. bounds가 비정상일듯.
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7

        layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12).cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
        layer.masksToBounds = false
    }
    
    // MARK: - Refreshable
    func refreshItem() {
        descriptionLabel.text = "홈 상단 배너입니다.(refresh 완료)"
        descriptionLabel.textColor = .systemRed
    }
}
