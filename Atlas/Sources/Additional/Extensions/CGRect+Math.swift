//
//  CGRect+Math.swift
//  Atlas
//
//  Created by Bogdan Grozian on 14.07.2021.
//

import UIKit

extension CGRect {
    static func -(lhs: CGRect, rhs: CGPoint) -> CGRect {
        let origin = CGPoint(x: lhs.minX - rhs.x, y: lhs.minY - rhs.y)
        return CGRect(origin: origin, size: lhs.size)
    }
    static func +(lhs: CGRect, rhs: CGPoint) -> CGRect {
        let origin = CGPoint(x: lhs.minX + rhs.x, y: lhs.minY + rhs.y)
        return CGRect(origin: origin, size: lhs.size)
    }
}
