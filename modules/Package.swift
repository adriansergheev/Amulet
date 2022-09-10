// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "modules",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "modules",
			targets: ["modules"]
		),
	],
	dependencies: [
		//
	],
	targets: [
		.target(
			name: "modules",
			dependencies: [],
			resources: [.copy("Resources/AmuletMock.json")]
		),
		.testTarget(
			name: "modulesTests",
			dependencies: ["modules"]
		),
	]
)

