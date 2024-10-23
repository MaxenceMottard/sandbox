//
//  UIView+Extensions.swift
//  Sandbox
//
//  Created by Maxence Mottard on 14/10/2024.
//

import UIKit

public extension UIView {
    @discardableResult @inline(__always)
    func pin(
        _ view: UIView,
        top: CGFloat = 0,
        trailing: CGFloat = 0,
        bottom: CGFloat = 0,
        leading: CGFloat = 0,
        priority: UILayoutPriority = .required,
        relativeToSafeArea: Bool = false
    ) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        if relativeToSafeArea {
            constraints = [
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -trailing),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottom),
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading)
            ]
        } else {
            constraints = [
                topAnchor.constraint(equalTo: view.topAnchor, constant: top),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom),
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading)
            ]
        }

        constraints.forEach { $0.isActive = true }
        return constraints
    }
}
