// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Modules",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "Modules",
			targets: ["Modules"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-composable-architecture",
			branch: "protocol-beta"
		)
	],
	targets: [
		.target(
			name: "ApiClient",
			dependencies: [
				"Model",
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			],
			resources: [.copy("Resources/AmuletMock.json")]
		),
		.target(name: "Model"),
		.target(
			name: "Modules",
			dependencies: [
				"ApiClient",
				"Model",
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			]
		),
		.testTarget(
			name: "ModulesTests",
			dependencies: ["Modules"]
		),
	]
)

