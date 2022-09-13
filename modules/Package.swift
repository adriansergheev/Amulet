// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Modules",
	platforms: [.iOS(.v15)],
	products: [
		.library(name: "Views", targets: ["Views"]),
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
		.target(name: "Extensions"),
		.target(name: "Model"),
		.target(
			name: "Views",
			dependencies: [
				"ApiClient",
				"Extensions",
				"Model",
				"Shared",
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			]
		),
		.testTarget(
			name: "ViewsTests",
			dependencies: ["Views"]
		),
		.target(name: "Shared")
	]
)

