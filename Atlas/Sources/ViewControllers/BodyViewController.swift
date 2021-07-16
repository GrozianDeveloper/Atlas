//
//  ViewController.swift
//  Atlas
//
//  Created by Bogdan And Lyuba on 14.07.2021.
//

import UIKit

final class BodyViewController: UIViewController {

    private var categoriesView: CategoriesView = {
        let categoriesView = CategoriesView(frame: .zero)
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
//        categoriesView.backgroundColor = .yellow
        return categoriesView
    }()
    
    private var isNowAnimating = false

    private var categoriesViewTopConstraint: NSLayoutConstraint!
    private var layoutType: LayoutType = .small {
        willSet {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [weak self] in
                    self?.categoriesViewTopConstraint.constant = newValue.minY
                    self?.view.layoutIfNeeded()
                } completion: { _ in
//                    self.categoriesView.roundCorners([.topLeft, .topRight], radius: 20)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            isNowAnimating = true
            let currentTouch = touch.location(in: self.view)
            let previousTouch = touch.previousLocation(in: self.view)
            let differentTouch = currentTouch.y - previousTouch.y
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            categoriesViewTopConstraint.constant += differentTouch
            CATransaction.commit()
        }
//        self.categoriesView.roundCorners([.topLeft, .topRight], radius: 20)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkYToChangeCategoriesLayout(yForCheck: categoriesView.frame.minY)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkYToChangeCategoriesLayout(yForCheck: categoriesView.frame.minY)
    }
}

// MARK: CategoriesView
extension BodyViewController {
    private func checkYToChangeCategoriesLayout(yForCheck: CGFloat) {
        layoutType = LayoutType.findClosest(target: yForCheck)
    }
}

// MARK: Setup BodyViewController
private extension BodyViewController {
    private func setupController() {
        setupUI()
        layoutType = .medium
    }

    private func setupUI() {
        view.addSubview(categoriesView)
        addConstraints()
    }

    private func addConstraints() {
        categoriesViewTopConstraint = NSLayoutConstraint(item: categoriesView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin,
                                                         multiplier: 1, constant: 0)
        categoriesViewTopConstraint.isActive = true
        NSLayoutConstraint(item: categoriesView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,
                           multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoriesView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading,
                           multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoriesView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing,
                           multiplier: 1, constant: 0).isActive = true
    }
}

private extension BodyViewController {
    private enum LayoutType: Int {
        case small
        case medium
        case big

        var minY: CGFloat {
            let viewFrame = UIScreen.main.bounds
            switch self {
                case .small:
                    return viewFrame.height - 50
                case .medium:
                    return viewFrame.midY
                case .big:
                    return 10
            }
        }

        static func findClosest(target: CGFloat) -> LayoutType {
            let viewHeight = UIScreen.main.bounds.height
            let allCases = [viewHeight - 50, viewHeight / 2, -50]
            guard let coefficient = allCases.enumerated().min(by: { abs($0.1 - target) < abs($1.1 - target)} )?.offset
            else { return .small }
            return LayoutType.init(rawValue: coefficient) ?? .small
        }
    }
}
