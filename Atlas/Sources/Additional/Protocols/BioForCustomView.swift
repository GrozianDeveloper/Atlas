//
//  BioForCustomView.swift
//  Atlas
//
//  Created by Bogdan Grozian on 16.07.2021.
//

import UIKit

protocol BioForCustomView: NSObject {
    func nib() -> UINib

    var identifier: String { get }
}
extension BioForCustomView {
    private func getIdentifier() -> String {
        var identifier = Self.description()
        identifier.forEach { _ in
            if identifier.contains(".") { identifier.removeFirst() }
        }
        return identifier
    }
    var identifier: String {
        return getIdentifier()
    }

    func nib() -> UINib {
        return UINib(nibName: getIdentifier(), bundle: Bundle.main)
    }
}
