//
//  CategoriesView.swift
//  Atlas
//
//  Created by Bogdan Grozian on 14.07.2021.
//

import UIKit

final class CategoriesView: UIView, Nib {
    lazy var view: UIView = {
        return subviews.first!
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        postInit()
    }

    func postInit() {
        registerNib()
        print(subviews)
    }
}

//extension CategoriesView: UICollectionViewDataSource {
//
//}

//extension CategoriesView: UICollectionViewDelegateFlowLayout {
//
//}
