// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ThisAndThat",
    platforms: [
        .macOS(.v15),
    ],
    targets: [    
        .executableTarget(
          name: "ThisAndThat",
          path: ".",
          exclude: ["README.md", "LICENSE", "package.swift"]
        ),
    ]
)