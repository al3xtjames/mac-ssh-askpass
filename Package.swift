// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "mac-ssh-askpass",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "mac-ssh-askpass", targets: ["mac-ssh-askpass"])
    ],
    targets: [
        .executableTarget(name: "mac-ssh-askpass")
    ]
)
