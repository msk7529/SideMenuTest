//
//  HomeViewController2.swift
//  SideMenuTest
//
//  Created by kakao on 2021/08/25.
//

import UIKit

final class HomeViewController2: UIViewController {

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
    
    private lazy var topBannerView: HomeTopBannerView = {
        let bannerView: HomeTopBannerView = .init()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    private let bannerTestVC: HomeTopBannerTestViewController = .init()
    
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
        addBannerView()
    }
    
    private func addBannerView() {
        view.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        topBannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true  // 반드시 높이를 지정해주어야 정상동작
        
        mainStackView.addArrangedSubview(topBannerView)
        
        self.addChild(bannerTestVC)
        mainStackView.addArrangedSubview(bannerTestVC.view) // VC로 하면 높이를 지정하지 않아도 됨. 그러나 VC에서 스택뷰를 구성해야함
        bannerTestVC.didMove(toParent: self)
    }
    
    // MARK: - Actions
    
    @objc private func didTapMenuButton() {
        let sideMenu: MenuViewController = .init()
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
    }
}
