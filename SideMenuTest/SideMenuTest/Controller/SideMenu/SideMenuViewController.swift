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
    
    private let secondSectionContainerStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let secondSectionTitleLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "두번째 섹션"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondSectionLabelsContainerStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var importantStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImportantStackView)))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let label: UILabel = .init(frame: .zero)
        label.text = "중요"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView = .init(frame: .zero)  // label 높이를 기준으로 가운데 정렬하기 위해 이미지뷰를 한 번 감싸는 용도. 중요
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView: UIImageView = .init(frame: .zero)
        imageView.image = UIImage(named: "importantIcon")
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(imageView)
        view.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(view)
        stackView.addArrangedSubview(UIView())
        
        return stackView
    }()
    
    private lazy var naverLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "네이버"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNaverLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var kakaoStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView: UIStackView = .init(frame: .zero)
        hStackView.axis = .horizontal
        hStackView.backgroundColor = .clear
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let label: UILabel = .init(frame: .zero)
        label.text = "카카오"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView = .init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(foldButton)
        view.centerYAnchor.constraint(equalTo: foldButton.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: foldButton.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: foldButton.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(label)
        hStackView.addArrangedSubview(view)
                
        return stackView
    }()
    
    private lazy var foldButton: UIButton = {
        let button: UIButton = .init(frame: .zero)
        button.setImage(UIImage(named: "downArrowIcon"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapFoldButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    private let kakaoItemStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstItemLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "가나다"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFirstItemLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondItemLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "라마바"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSecondItemLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var thirdItemLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "사아자"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapThirdItemLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fourthItemLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "차카타"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFourthItemLabel)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fifthItemLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "파하"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFifthItemLabel)))
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
        setSecondSectionLayout()
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
    
    private func setSecondSectionLayout() {
        mainStackView.addArrangedSubview(secondSectionContainerStackView)
        
        secondSectionContainerStackView.addArrangedSubview(secondSectionTitleLabel)
        secondSectionContainerStackView.addArrangedSubview(secondSectionLabelsContainerStackView)
    
        secondSectionLabelsContainerStackView.addArrangedSubview(importantStackView)
        secondSectionLabelsContainerStackView.addArrangedSubview(naverLabel)
        secondSectionLabelsContainerStackView.addArrangedSubview(kakaoStackView)
        
        kakaoStackView.addArrangedSubview(kakaoItemStackView)
        
        kakaoItemStackView.addArrangedSubview(firstItemLabel)
        kakaoItemStackView.addArrangedSubview(secondItemLabel)
        kakaoItemStackView.addArrangedSubview(thirdItemLabel)
        kakaoItemStackView.addArrangedSubview(fourthItemLabel)
        kakaoItemStackView.addArrangedSubview(fifthItemLabel)
        
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
    
    @objc private func didTapImportantStackView() {
        print("did Tap importantLabel!")
    }
    
    @objc private func didTapNaverLabel() {
        print("did Tap naverLabel!")
    }
    
    @objc private func didTapFoldButton() {
        UIView.animate(withDuration: 0.3) {
            let isShowing = self.kakaoItemStackView.isHidden
            self.kakaoItemStackView.isHidden = !isShowing
        }
    }
    
    @objc private func didTapFirstItemLabel() {
        print("did Tap firstItemLabel!")
    }
    
    @objc private func didTapSecondItemLabel() {
        print("did Tap secondItemLabel!")
    }
    
    @objc private func didTapThirdItemLabel() {
        print("did Tap thirdItemLabel!")
    }
    
    @objc private func didTapFourthItemLabel() {
        print("did Tap fourthItemLabel!")

    }
    
    @objc private func didTapFifthItemLabel() {
        print("did Tap fifthItemLabel!")
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
