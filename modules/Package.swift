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
		//
	],
	targets: [
		.target(
			name: "Modules",
			dependencies: [],
			resources: [.copy("Resources/AmuletMock.json")]
		),
		.testTarget(
			name: "ModulesTests",
			dependencies: ["Modules"]
		),
	]
)

