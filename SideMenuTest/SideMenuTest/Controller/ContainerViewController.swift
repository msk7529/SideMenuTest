//
//  ContainerViewController.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/23.
//

import UIKit

protocol SideMenuActionDelegate: AnyObject {
    func didTapMenuButton()
}

protocol SideMenuSuportable: AnyObject {
    var delegate: SideMenuActionDelegate? { get set }
}

final class ContainerViewController: UIViewController, SideMenuActionDelegate {
    // MARK: - Properties
    private lazy var dimmedView: UIView = {
        let view: UIView = .init(frame: .zero)
        let tapGesture: UITapGestureRecognizer = .init(target: self, action: #selector(didTapDimmedView))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var rootViewController: (UIViewController & SideMenuSuportable)?
    private var menuViewController: UIViewController!
    private var centerController: UIViewController!
    private var isExpanded: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    init(rootViewController: UIViewController & SideMenuSuportable) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCenterViewController()
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
    
    private func configureCenterViewController() {
        guard let rootVC = rootViewController else { return }
        
        rootVC.delegate = self
        centerController = UINavigationController(rootViewController: rootVC)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    private func configureMenuViewController() {
        // add our menu controller here
        guard menuViewController == nil else { return }
        
        menuViewController = MenuController()
        
        view.addSubview(menuViewController.view)
        addChild(menuViewController)
        menuViewController.didMove(toParent: self)
        print("Did add menu Controller")
    }
    
    private func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            // show menu
            self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                //self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                self.dimmedView.isHidden = false
                self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width / 3
            }, completion: nil)

        } else {
            // hide menu
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.dimmedView.isHidden = true
                self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width
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

// MARK: - SideMenuActionDelegate

extension ContainerViewController {
    
    func didTapMenuButton() {
        if !isExpanded {
            configureMenuViewController()
        }
        
        isExpanded.toggle()
        showMenuController(shouldExpand: isExpanded)
    }
}
