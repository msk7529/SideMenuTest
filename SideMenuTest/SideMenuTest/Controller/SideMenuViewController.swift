//
//  SideMenuViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/23.
//

import UIKit

final class SideMenuViewController: UIViewController {
    // MARK: - Properties

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
        
        self.view.backgroundColor = .systemBlue
        
        addPanGesture()
    }
    
    // MARK: - Helpers
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
