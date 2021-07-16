//
//  BioForCell.swift
//  Atlas
//
//  Created by Bogdan Grozian on 16.07.2021.
//

import UIKit

protocol BioForCell: NSObject {
    func identifier() -> String

    func nib() -> UINib
}
extension BioForCell {
    static func identifier() -> String {
        var identifier = self.description()
        identifier.forEach { _ in
            if identifier.contains(".") { identifier.removeFirst() }
        }
        return identifier
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier(), bundle: nil)
    }
}

