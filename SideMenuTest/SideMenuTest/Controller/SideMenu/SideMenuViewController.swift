//
//  SideMenuViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/23.
//

import UIKit

final class SideMenuViewController: UIViewController {
    // MARK: - Properties
    private let containerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        //stackView.backgroundColor = .systemOrange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topVC: SideMenuTopViewController = .init()
    
    var isExpanded: Bool = false    // ContainerVC에서만 사용
    
    // panGesture
    private var isPanGestureActivated: Bool = false
    private var originX: CGFloat = 0
    
    override var shouldAutorotate: Bool {
        get {
            return isPanGestureActivated ? false : true
        }
    }
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        configureBasicUI()
        addTopVC()
        addPanGesture()
    }
    
    // MARK: - Helpers
    private func configureBasicUI() {
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        containerView.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        //mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true  -> 주석처리 안하면 UI깨짐
    }
    
    private func addTopVC() {
        addChild(topVC)
        mainStackView.addArrangedSubview(topVC.view)
        topVC.didMove(toParent: self)
    }
    
    private func addPanGesture() {
        let gesture: UIPanGestureRecognizer = .init(target: self, action: #selector(hideMenu(_:)))
        view.addGestureRecognizer(gesture)
    }

    // MARK: - Actions
    @objc private func hideMenu(_ sender: UIPanGestureRecognizer) {
        let viewTranslation = sender.translation(in: view)
 
        switch sender.state {
        case .began:
            originX = view.frame.origin.x
            isPanGestureActivated = true
        case .changed:
            // 사이드메뉴가 왼쪽으로 이탈하는 것을 방지
            view.frame.origin.x = max(originX ,viewTranslation.x + originX)
        case .ended:
            isPanGestureActivated = false
            
            if originX..<originX + 50 ~= view.frame.origin.x {
                UIView.animate(withDuration: 0.2) {
                    self.view.frame.origin.x = self.originX
                }
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
}
