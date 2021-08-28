//
//  SideMenuViewController.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/23.
//

import UIKit

final class SideMenuViewController: UIViewController {
    // MARK: - Properties
    private lazy var settingButton: UIButton = {
        let button: UIButton = .init(frame: .zero)
        button.setImage(UIImage(named: "settingIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    private let homeLabelContainerView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var homeLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "홈"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHomeLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setFirstSectionLayout()
        addPanGesture()
    }
    
    // MARK: - Helpers
    private func configureBasicUI() {
        view.addSubview(containerView)
        view.addSubview(settingButton)
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        containerView.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        //mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true  -> 주석처리 안하면 UI깨짐
        
        settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setFirstSectionLayout() {
        addChild(topVC)
        mainStackView.addArrangedSubview(topVC.view)
        topVC.didMove(toParent: self)
        
        homeLabelContainerView.addArrangedSubview(homeLabel)
        homeLabelContainerView.layoutMargins = .init(top: 0, left: 30, bottom: 0, right: 10)
        homeLabelContainerView.isLayoutMarginsRelativeArrangement = true
        
        mainStackView.addArrangedSubview(homeLabelContainerView)
        mainStackView.addArrangedSubview(getSeperatorLine())
    }
    
    private func getSeperatorLine() -> UIView {
        let line: UIView = .init(frame: .zero)
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return line
    }
    
    private func addPanGesture() {
        let gesture: UIPanGestureRecognizer = .init(target: self, action: #selector(hideMenu(_:)))
        view.addGestureRecognizer(gesture)
    }

    // MARK: - Actions
    @objc private func didTapSettingButton() {
        print("did Tap setting Button!")
    }
    
    @objc private func didTapHomeLabel() {
        print("did Tap HomeLabel!")
    }
    
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
