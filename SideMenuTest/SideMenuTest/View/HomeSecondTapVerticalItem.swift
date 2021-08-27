//
//  HomeSecondTapVerticalItem.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/26.
//

import UIKit

final class HomeSecondTapVerticalItem: UIStackView {
    
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .zero)
        imageView.image = UIImage(named: "giftIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "첫번째"
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "100"
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subjectText: String = "" {
        didSet {
            descriptionLabel.text = subjectText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setUpViewStyle()
    }
    
    private func initView() {
        self.backgroundColor = .green
        self.axis = .horizontal
        self.spacing = 10
        self.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
        self.isLayoutMarginsRelativeArrangement = true
        
        addArrangedSubview(iconImageView)
        addArrangedSubview(descriptionLabel)
        addArrangedSubview(UIView())
        addArrangedSubview(countLabel)

        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpViewStyle() {
        layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7

        layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12).cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
