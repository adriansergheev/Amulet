import Foundation
import UIKit

public extension UIApplication {
	static var appVersion: String {
		let versionNumber = Bundle.main.infoDictionary?[IdentifierConstants.InfoPlist.versionNumber] as? String
		let buildNumber = Bundle.main.infoDictionary?[IdentifierConstants.InfoPlist.buildNumber] as? String
		
		let formattedBuildNumber = buildNumber.map {
			return "(\($0))"
		}
		
		return [versionNumber, formattedBuildNumber].compactMap { $0 }.joined(separator: " ")
	}
}

struct IdentifierConstants {
	struct InfoPlist {
		static let versionNumber = "CFBundleShortVersionString"
		static let buildNumber = "CFBundleVersion"
	}
}
