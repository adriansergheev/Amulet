import Foundation
import SwiftUI
import Model

public struct AmuletFont {
	static public var defaultFont: (CGFloat) -> Font = { Font.system(size: $0) }
}

struct AmuletColors { }

public struct AmuletIcons {
	static public let cancel: some View = Image(systemName: "multiply")
		.resizable()
		.frame(width: 20, height: 20, alignment: .center)
		.foregroundColor(.black)
	
	// Crashes as of iOS 13.4 Xcode 11.4 when used in external views
	
	//	static let more: some View = Image(systemName: "heart")
	//		.resizable()
	//		.frame(width: 20, height: 20, alignment: .center)
	//
	//	static let settings: some View = Image(systemName: "ellipsis.circle")
	//		.resizable()
	//		.frame(width: 20, height: 20, alignment: .center)
}

