//
//  HomeCustomSwitch.swift
//  SideMenuTest
//
//  Created by Minseop on 2021/08/25.
//

import UIKit

final class HomeCustomSwitch: UIControl {
    
    // MARK: - Properties
    
    var titles: [String] {
        set {
            (titleLabels + selectedTitleLabels).forEach { $0.removeFromSuperview() }
            
            titleLabels = newValue.map { title in
                let label: UILabel = .init(frame: .zero)
                label.text = title
                label.textColor = titleColor
                label.font = titleFont
                label.textAlignment = .center
                label.lineBreakMode = .byTruncatingTail
                titleLabelsContentView.addSubview(label)
                return label
            }
            
            selectedTitleLabels = newValue.map { title in
                let label: UILabel = .init(frame: .zero)
                label.text = title
                label.textColor = selectedTitleColor
                label.font = titleFont
                label.textAlignment = .center
                label.lineBreakMode = .byTruncatingTail
                selectedTitleLabelsContentView.addSubview(label)
                return label
            }
        }
        get {
            return titleLabels.map { $0.text ?? "" }
        }
    }
    
    var selectedIndex: Int = 0
    
    var selectedBackgroundColor: UIColor {
        set {
            selectedBackgroundView.backgroundColor = newValue
        }
        get {
            return selectedBackgroundView.backgroundColor ?? .white
        }
    }
    
    var titleColor: UIColor! {
        didSet {
            titleLabels.forEach { $0.textColor = titleColor }
        }
    }
    
    var selectedTitleColor: UIColor! {
        didSet {
            selectedTitleLabels.forEach { $0.textColor = selectedTitleColor }
        }
    }
    
    var titleFont: UIFont! {
        didSet {
            (titleLabels + selectedTitleLabels).forEach { $0.font = titleFont }
        }
    }
        
    private let titleLabelsContentView: UIView = .init(frame: .zero)
    private var titleLabels: [UILabel] = []
    
    private let selectedTitleLabelsContentView: UIView = .init(frame: .zero)
    private var selectedTitleLabels: [UILabel] = []
    
    @objc private dynamic var selectedBackgroundView: UIView = .init(frame: .zero)
    
    private let titleMaskView: UIView = UIView()
    
    private var tapGesture: UITapGestureRecognizer?
    private var panGesture: UIPanGestureRecognizer?
    
    private var initialSelectedBackgroundViewFrame: CGRect?
    
    // MARK: - Init
    
    init(titles: [String]) {
        super.init(frame: .zero)
        
        self.titles = titles
        
        initView()
        addGesture()
        addObserver()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        initView()
        addGesture()
        addObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = bounds.height / 2
        
        let selectedBackgroundWidth = bounds.width / CGFloat(titleLabels.count)
        selectedBackgroundView.frame = CGRect(x: CGFloat(selectedIndex) * selectedBackgroundWidth, y: 0, width: selectedBackgroundWidth, height: bounds.height)
        selectedBackgroundView.layer.cornerRadius = bounds.height / 2
        
        titleLabelsContentView.frame = bounds
        selectedTitleLabelsContentView.frame = bounds
        
        let titleLabelMaxWidth = selectedBackgroundWidth
        let titleLabelMaxHeight = bounds.height
        
        for index in 0..<titleLabels.count {
            var size = titleLabels[index].sizeThatFits(CGSize(width: titleLabelMaxWidth, height: titleLabelMaxHeight))
            size.width = min(size.width, titleLabelMaxWidth)
          
            let xxx = floor((bounds.width / CGFloat(titleLabels.count)) * CGFloat(index) + (bounds.width / CGFloat(titleLabels.count) - size.width) / 2.0)
            let yyy = floor((bounds.height - size.height) / 2.0)
            let origin = CGPoint(x: xxx, y: yyy)
            
            let frame = CGRect(origin: origin, size: size)
            titleLabels[index].frame = frame
            selectedTitleLabels[index].frame = frame
        }
    }
    
    private func initView() {
        addSubview(titleLabelsContentView)
        addSubview(selectedBackgroundView)
        addSubview(selectedTitleLabelsContentView)
        
        titleMaskView.backgroundColor = .black
        
        selectedTitleLabelsContentView.layer.frame = titleMaskView.frame
        selectedTitleLabelsContentView.layer.mask = titleMaskView.layer
    }
    
    private func addGesture() {
        let tapGesture: UITapGestureRecognizer = .init(target: self, action: #selector(didTapSwitch(_:)))
        addGestureRecognizer(tapGesture)
        self.tapGesture = tapGesture
        
        let panGesture: UIPanGestureRecognizer = .init(target: self, action: #selector(didPanSwitch(_:)))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }
        
    deinit {
        removeObserver(self, forKeyPath: "selectedBackgroundView.frame")
    }
    
    // MARK: - Observer
    private func addObserver() {
        addObserver(self, forKeyPath: "selectedBackgroundView.frame", options: .new, context: nil)
    }
    
    override internal func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selectedBackgroundView.frame" {
            titleMaskView.frame = selectedBackgroundView.frame
        }
    }
    
    // MARK: - Helpers
    
    @objc func didTapSwitch(_ gesture: UITapGestureRecognizer) {
        guard !titleLabels.isEmpty else { return }
        
        let location = gesture.location(in: self)
        let index = Int(location.x / (bounds.width / CGFloat(titleLabels.count)))
        
        setSelectedIndex(index)
    }
    
    @objc func didPanSwitch(_ gesture: UIPanGestureRecognizer) {
        guard !titleLabels.isEmpty else { return }

        if gesture.state == .began {
            initialSelectedBackgroundViewFrame = selectedBackgroundView.frame
        } else if gesture.state == .changed {
            guard var frame = initialSelectedBackgroundViewFrame else { return }
            
            frame.origin.x += gesture.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - frame.width), 0)
            selectedBackgroundView.frame = frame
        } else if gesture.state == .ended || gesture.state == .failed || gesture.state == .cancelled {
            let index = max(0, min(titleLabels.count - 1, Int(selectedBackgroundView.center.x / (bounds.width / CGFloat(titleLabels.count)))))
            setSelectedIndex(index)
        }
    }
    
    private func setSelectedIndex(_ selectedIndex: Int) {
        guard 0..<titleLabels.count ~= selectedIndex else { return }
        
        var didSelectSameSwitch = false
        if self.selectedIndex == selectedIndex {
            didSelectSameSwitch = true
        }
        
        self.selectedIndex = selectedIndex
        
        if !didSelectSameSwitch {
            self.sendActions(for: .valueChanged)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.beginFromCurrentState,  .curveEaseOut]) {
            self.layoutSubviews()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension HomeCustomSwitch: UIGestureRecognizerDelegate {
    
    override internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = panGesture {
            if gestureRecognizer == panGesture {
                return selectedBackgroundView.frame.contains(gestureRecognizer.location(in: self))

            } else if gestureRecognizer == tapGesture {
                return super.gestureRecognizerShouldBegin(gestureRecognizer)
            }
        }
        return false
    }
}

