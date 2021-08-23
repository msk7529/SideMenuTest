//
//  ContainerController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

final class ContainerController: UIViewController {
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHomeController()
    }

    // MARK: - Handlers
    
    private func configureHomeController() {
        let homeVC = HomeController()
        let controller = UINavigationController(rootViewController: homeVC)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    private func configureMenuController() {
        
    }

}
