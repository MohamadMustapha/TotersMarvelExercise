// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = .init(
    name: .details,
    platforms: [.iOS],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .detailsProduct
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .kingFisherPackageDependency,
        .sharedPackageDependency,
        .swiftLintPackageDependency
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .detailsTarget,
        .detailsTestTarget
    ]
)

fileprivate extension Product {

    static let detailsProduct: Product = .library(name: .details,
                                                  targets: [.details])
}

fileprivate extension Package.Dependency {

    static let kingFisherPackageDependency: Package.Dependency = package(url: "https://github.com/onevcat/Kingfisher.git",
                                                                         exact: "7.10.2")

    static let sharedPackageDependency: Package.Dependency = package(path: "../Shared")


    static let swiftLintPackageDependency: Package.Dependency = package(url: "https://github.com/realm/SwiftLint",
                                                                        exact: "0.54.0")
}

fileprivate extension String {

    // MARK: Folders
    static let details: String = "Details"

    // MARK: Packages
    static let kingFisher: String = "Kingfisher"
    static let shared: String = "Shared"
    static let swiftLint: String = "SwiftLint"

    // MARK: Plugins
    static let swiftLintPlugin: String = "SwiftLintPlugin"

    var testTarget: String { "\(self)Tests" }
}

fileprivate extension SupportedPlatform {

    static let iOS: SupportedPlatform = .iOS(.v15)
}

fileprivate extension Target {

    static let detailsTarget: Target = target(name: .details,
                                              dependencies: [.kingFisherDependency,
                                                             .sharedDependency],
                                              plugins: [.swiftLintPlugin])
    static let detailsTestTarget: Target = testTarget(name: .details.testTarget,
                                                      dependencies: [.detailsDependency],
                                                      plugins: [.swiftLintPlugin])
}

fileprivate extension Target.Dependency {

    static let detailsDependency: Target.Dependency = byName(name: .details)
    static let kingFisherDependency: Target.Dependency = byName(name: .kingFisher)
    static let sharedDependency: Target.Dependency = byName(name: .shared)
}

fileprivate extension Target.PluginUsage {

    static let swiftLintPlugin: Target.PluginUsage = plugin(name: .swiftLintPlugin,
                                                            package: .swiftLint)
}

