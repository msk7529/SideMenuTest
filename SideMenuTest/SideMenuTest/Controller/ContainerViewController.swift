//
//  ContainerViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/23.
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
    private var menuViewController: SideMenuViewController!
    private var centerController: UIViewController!
    
    private var isMenuExpanded: Bool {
        get {
            return menuViewController == nil ? false : menuViewController.isExpanded
        } set {
            guard menuViewController != nil else { return }
            menuViewController.isExpanded = newValue
        }
    }
    
    internal override var interfaceOrientation: UIInterfaceOrientation {
        get {
            guard let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation else {
                return .portrait
            }
            return interfaceOrientation
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init & Life Cycles
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard isMenuExpanded else { return }
        
        if interfaceOrientation == .portrait {
            menuViewController.view.frame.origin.x = centerController.view.frame.width / 4
        } else {
            menuViewController.view.frame.origin.x = centerController.view.frame.width / 2 + 60
        }
    }

    // MARK: - Helpers
    
    private func readyDimmedView() {
        // CenterVC 세팅 후 호출해주어야 함.
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
        
        menuViewController = SideMenuViewController()
        
        view.addSubview(menuViewController.view)
        addChild(menuViewController)
        menuViewController.didMove(toParent: self)
        print("Did add menu Controller")
    }
    
    private func showOrHideMenuController(show: Bool) {
        if show {
            // show menu
            self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.dimmedView.isHidden = false
                
                if self.interfaceOrientation == .portrait {
                    self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width / 4
                } else {
                    self.menuViewController.view.frame.origin.x = self.centerController.view.frame.width / 2 + 60
                }
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
        guard isMenuExpanded else { return }
        
        isMenuExpanded.toggle()
        showOrHideMenuController(show: false)
    }
}

// MARK: - SideMenuActionDelegate

extension ContainerViewController {
    
    func didTapMenuButton() {
        if !isMenuExpanded {
            configureMenuViewController()
        }
        
        isMenuExpanded.toggle()
        showOrHideMenuController(show: isMenuExpanded)
    }
}
