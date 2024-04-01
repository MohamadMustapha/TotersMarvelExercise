// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = .init(
    name: .network,
    platforms: [.iOS],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .networkProduct
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .swiftLintPackageDependency
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .networkTarget,
        .networkTestTarget
    ]
)

fileprivate extension Product {

    static let networkProduct: Product = .library(name: .network,
                                               targets: [.network])
}

fileprivate extension Package.Dependency {

    static let swiftLintPackageDependency: Package.Dependency = package(url: "https://github.com/realm/SwiftLint",
                                                                        exact: "0.54.0")
}

fileprivate extension String {

    // MARK: Folders
    static let network: String = "Network"

    // MARK: Packages
    static let swiftLint: String = "SwiftLint"

    // MARK: Plugins
    static let swiftLintPlugin: String = "SwiftLintPlugin"

    var testTarget: String { "\(self)Tests" }
}

fileprivate extension SupportedPlatform {

    static let iOS: SupportedPlatform = .iOS(.v15)
}

fileprivate extension Target {

    static let networkTarget: Target = target(name: .network,
                                           plugins: [.swiftLintPlugin])
    static let networkTestTarget: Target = testTarget(name: .network.testTarget,
                                                   dependencies: [.pagesDependency],
                                                   plugins: [.swiftLintPlugin])
}

fileprivate extension Target.Dependency {

    static let pagesDependency: Target.Dependency = byName(name: .network)
}

fileprivate extension Target.PluginUsage {

    static let swiftLintPlugin: Target.PluginUsage = plugin(name: .swiftLintPlugin,
                                                            package: .swiftLint)
}

