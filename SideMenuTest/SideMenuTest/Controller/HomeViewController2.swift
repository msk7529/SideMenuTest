//
//  HomeViewController2.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/25.
//

import UIKit

final class HomeViewController2: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    private let bgStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bgView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init(frame: .zero)
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        //scrollView.contentInsetAdjustmentBehavior = .never    // 이거 설정하니까 상단바운스가 안되네 ..
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let floatingStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        //stackView.backgroundColor = .systemOrange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let footerStackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let footerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    
    private lazy var topBannerView: HomeTopBannerView = {
        let bannerView: HomeTopBannerView = .init()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    private let bannerTestVC: HomeTopBannerTestViewController = .init()
    private let bannerTestVC2: HomeTopBannerTestViewController = .init()
    private let verticalVC: HomeSecondTapVerticalViewController = .init()
    
    private lazy var sideMenuTransitionDelegate: SideMenuTransitionDelegate = {
        return .init()
    }()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        initView()
    }
    
    // MARK: - Helpers

    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "HomeVC2"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "closeIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapCloseButton))
        
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refreshIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapRefreshButton))
        let menuButton = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItems = [menuButton, refreshButton]
    }
    
    private func initView() {
        configureBasicUI()
        addFloatingBannerView()
        addBannerView()
        addVerticalView()
        addFooterView()
        moveFloatingBannerViewToFront()
    }
    
    private func configureBasicUI() {
        view.addSubview(bgStackView)
        
        bgStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        bgStackView.addArrangedSubview(UIView())
        bgStackView.addArrangedSubview(bgView)
        
        view.addSubview(floatingStackView)

        floatingStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        floatingStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        floatingStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(containerView)
        // 스크롤영역을 설정해주기 위해 보통 이런식으로 뷰를 하나 넣고 아래와 같이 오토레이아웃을 설정해준다. 주의할 점이 contentLayoutGuide, frameLayoutGuide을 이용해야 한다는거...
        
        containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        containerView.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addFloatingBannerView() {
        self.addChild(bannerTestVC2)
        floatingStackView.addArrangedSubview(bannerTestVC2.view)
        bannerTestVC2.view.backgroundColor = .systemRed
        bannerTestVC2.didMove(toParent: self)
    }
    
    private func addBannerView() {
        topBannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true  // 반드시 높이를 지정해주어야 정상동작
        
        mainStackView.addArrangedSubview(topBannerView)
        
        self.addChild(bannerTestVC)
        mainStackView.addArrangedSubview(bannerTestVC.view) // VC로 하면 높이를 지정하지 않아도 됨. 그러나 VC에서 스택뷰를 구성해야함
        bannerTestVC.didMove(toParent: self)
        
        mainStackView.setCustomSpacing(50, after: bannerTestVC.view)
    }
    
    private func addVerticalView() {
        self.addChild(verticalVC)
        mainStackView.addArrangedSubview(verticalVC.view)
        verticalVC.didMove(toParent: self)
    }
    
    private func addFooterView() {
        containerView.addSubview(footerStackView)
        
        footerStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 50).isActive = true
        footerStackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        footerStackView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        footerStackView.addArrangedSubview(footerView)
        
        footerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        footerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        // 컨테이너뷰에 들어가는 마지막 요소에서는 이렇게 bottomAnchor를 컨테이너뷰에 맞춰줘야 스크롤뷰가 스크롤영역을 제대로 인식하고 UI가 안깨질수 있다.
        // containerView의 safeArea에 맞출지는 UI보고 판단.
    }
    
    private func moveFloatingBannerViewToFront() {
        self.view.bringSubviewToFront(floatingStackView)
    }
    
    // MARK: - Actions
    
    @objc private func didTapMenuButton() {
        let sideMenu: SideMenuViewController = .init()
        sideMenu.transitioningDelegate = self.sideMenuTransitionDelegate
        //sideMenu.delegate = self
        sideMenu.modalPresentationStyle = .custom
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRefreshButton() {
        self.children.compactMap { $0 as? Refreshable }.forEach { $0.refreshItem() }
        self.mainStackView.arrangedSubviews.compactMap { $0 as? Refreshable }.forEach { $0.refreshItem() }
        
        UIView.animate(withDuration: 0.3) {
            self.bannerTestVC.view.isHidden = true
        } completion: { _ in
            self.mainStackView.removeArrangedSubview(self.bannerTestVC.view)
            self.bannerTestVC.view.removeFromSuperview()
        }

    }
}
