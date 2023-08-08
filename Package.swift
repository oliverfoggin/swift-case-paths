// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "swift-case-paths",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "CasePaths",
      targets: ["CasePaths"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-syntax.git",
      from: "509.0.0-swift-DEVELOPMENT-SNAPSHOT-2023-08-07-a"
    ),
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
//    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", branch: "swift-syntax"),
    .package(path: "../swift-snapshot-testing"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "CasePaths",
      dependencies: [
        "CasePathsMacros",
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
      ]
    ),
    .testTarget(
      name: "CasePathsTests",
      dependencies: ["CasePaths"]
    ),
    .macro(
      name: "CasePathsMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .testTarget(
      name: "CasePathsMacrosTests",
      dependencies: [
        "CasePathsMacros",
        .product(name: "MacroSnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
    .executableTarget(
      name: "swift-case-paths-benchmark",
      dependencies: [
        "CasePaths",
        .product(name: "Benchmark", package: "swift-benchmark"),
      ]
    ),
  ]
)

#if swift(>=5.6)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
