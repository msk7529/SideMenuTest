//
//  HomeCollectionViewCell.swift
//  SideMenuTest
//
//  Created by kakao on 2021/10/18.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
