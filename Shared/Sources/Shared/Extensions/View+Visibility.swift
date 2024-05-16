//
//  View+Visibility.swift
//  MarvelApi
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import SwiftUI

public extension View {

    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if !remove {
            if hidden {
                self.hidden()
            } else {
                self
            }
        }
    }
}
