//
//  LottieLoaderView.swift
//
//
//  Created by Mohamad Mustapha on 01/04/2024.
//

import Lottie
import SwiftUI

public struct LottieLoaderView: View {

    public enum Heroes: String {
        case ironMan = "iron_man"
        case thor = "thor"
    }

    private let animation: Heroes

    public init(animation: Heroes) {
        self.animation = animation
    }

    public var body: some View {
        LottieView(animation: LottieAnimation.asset(animation.rawValue,
                                                    bundle: .module))
        .playing(loopMode: .loop)
    }
}

#Preview {

    LottieLoaderView(animation: .ironMan)
}
