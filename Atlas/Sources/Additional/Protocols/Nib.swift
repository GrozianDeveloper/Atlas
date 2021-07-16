//
//  Nib.swift
//  Atlas
//
//  Created by Bogdan Grozian on 16.07.2021.
//

import UIKit

protocol Nib {

    func registerNib() -> Any

}

extension Nib where Self : UIView {

    func registerNib() -> Any {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return UIView(frame: bounds) }
        // ** Check if resource is used in Interface Builder first to avoid crash during compile
        #if !TARGET_INTERFACE_BUILDER
        let bundle = Bundle(for: type(of: self))
        guard let _ = bundle.path(forResource: nibName, ofType: "nib")
            else { fatalError("can't find \(nibName) xib resource in current bundle") }
        #endif
        guard let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
            else { return UIView(frame: bounds) }
        // ** Another way to write it but do not work if xib is bundled with framework
        //guard let view = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        //    else { return }
        view.frame = bounds
//        addSubview(view)

        return view
    }

}
