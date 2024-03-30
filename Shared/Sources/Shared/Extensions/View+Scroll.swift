//
//  View+Scroll.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import SwiftUI

public extension View {

    @ViewBuilder
    func scrollIfNeeded(axes: Axis.Set) -> some View {
        if #available(iOS 16.4, *) {
            self.scrollBounceBehavior(.basedOnSize, axes: axes)
        } else {
            self
        }
    }
}
