//
//  ContainerController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

final class ContainerController: UIViewController {
    // MARK: - Properties
    private lazy var dimmedView: UIView = {
        let view: UIView = .init(frame: .zero)
        let tapGesture: UITapGestureRecognizer = .init(target: self, action: #selector(didTapDimmedView))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHomeController()
        self.readyDimmedView()
    }

    // MARK: - Helpers
    
    private func readyDimmedView() {
        // homeVC 세팅 후 호출해주어야 함.
        view.addSubview(dimmedView)
        
        dimmedView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dimmedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dimmedView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        dimmedView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    private func configureHomeController() {
        let homeVC = HomeController()
        homeVC.delegate = self
        centerController = UINavigationController(rootViewController: homeVC)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    private func configureMenuController() {
        if menuController == nil {
            // add our menu controller here
            menuController = MenuController()
            
            view.addSubview(menuController.view)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menu Controller")
        }
    }
    
    private func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            // show menu
            self.menuController.view.frame.origin.x = self.centerController.view.frame.width
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                //self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                self.dimmedView.isHidden = false
                self.menuController.view.frame.origin.x = self.centerController.view.frame.width / 3
            }, completion: nil)

        } else {
            // hide menu
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.dimmedView.isHidden = true
                self.menuController.view.frame.origin.x = self.centerController.view.frame.width
            }, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapDimmedView() {
        guard isExpanded else { return }
        
        isExpanded.toggle()
        showMenuController(shouldExpand: false)
    }
}

extension ContainerController: HomeControllerDelegate {
    
    func didTapMenuButton() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded.toggle()
        showMenuController(shouldExpand: isExpanded)
    }
}
