//
//  UIView+Constraints.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 13/03/21.
//

import UIKit


internal extension UIView {
    /// resizing the sub view controllers in accordance to their view
    /// - Parameter view: UI View
    func makeEdgesEqualToSuperView() {
        guard let superView = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}

