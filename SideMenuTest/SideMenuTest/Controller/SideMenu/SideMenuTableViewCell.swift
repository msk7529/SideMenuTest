//
//  SideMenuTableViewCell.swift
//  SideMenuTest
//
//  Created by kakao on 2021/09/07.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {
    static let identifier = "SideMenuTableViewCell"
    
    private let label: UILabel = {
        let label: UILabel = .init()
        label.backgroundColor = .clear
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        contentView.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
}
