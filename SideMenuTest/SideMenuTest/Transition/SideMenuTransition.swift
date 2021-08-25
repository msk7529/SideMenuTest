//
//  SideMenuTransition.swift.swift
//
//

import UIKit


class SideMenuTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitionAnimator(isPresent: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitionAnimator(isPresent: false)
    }
}

class SideMenuPresentationController: UIPresentationController {
    private let dimmedView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        if UIApplication.shared.statusBarOrientation != .portrait {
            frame.origin.x = 40
        }
        frame.origin.x = containerView.frame.width - frame.size.width
        //frame.origin.y = containerView.frame.height - frame.size.height
        return frame
    }
        
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        let recognizer: UITapGestureRecognizer = .init(target: self, action: #selector(dismissPresentingVC))
        dimmedView.addGestureRecognizer(recognizer)
        
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        containerView.insertSubview(dimmedView, at: 0)
                
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.dimmedView.alpha = 1.0
            }, completion: nil)
        } else {
            self.dimmedView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.dimmedView.alpha = 0.0
            }, completion: nil)
        } else {
            self.dimmedView.alpha = 0.0
        }
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }
        super.containerViewWillLayoutSubviews()
        
        presentedView.frame = frameOfPresentedViewInContainerView
        dimmedView.frame = containerView.frame
    }
    
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if UIApplication.shared.statusBarOrientation == .portrait {
            return CGSize(width: parentSize.width / 4 * 3, height: parentSize.height)
        } else {
            return CGSize(width: parentSize.width - 80, height: 250)
        }
    }
    
    @objc private func dismissPresentingVC() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}

class SideMenuTransitionAnimator: NSObject {
    var isPresent: Bool
    
    init(isPresent: Bool) {
        self.isPresent = isPresent
        super.init()
    }
}

extension SideMenuTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = isPresent ? .to : .from

        guard let controller = transitionContext.viewController(forKey: key) else { return}
        
        if isPresent {
            transitionContext.containerView.addSubview(controller.view)
        }

        let presentFrame: CGRect = transitionContext.finalFrame(for: controller)
        var dismissFrame: CGRect = presentFrame
        dismissFrame.origin.x += presentFrame.width


        let initialFrame: CGRect = isPresent ? dismissFrame : presentFrame
        let finalFrame: CGRect = isPresent ? presentFrame : dismissFrame

        controller.view.frame = initialFrame

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            controller.view.frame = finalFrame
        }) { finished in
            if !self.isPresent {
                controller.view.removeFromSuperview()
            }
            transitionContext.completeTransition(finished)
        }
    }
}

public extension UIView {
    func add(roundedCorners: UIRectCorner, with radii: CGSize) {
        layer.mask = mask(for: roundedCorners, with: radii)
    }
    
    func mask(for roundedCorners: UIRectCorner, with radii: CGSize) -> CALayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.fillColor = UIColor.white.cgColor
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.path = UIBezierPath(roundedRect: maskLayer.bounds, byRoundingCorners: roundedCorners, cornerRadii: radii).cgPath
        return maskLayer
    }
}
