import Foundation
import SwiftUI

public struct AmuletFont {
	static public var defaultFont: (CGFloat) -> Font = { Font.system(size: $0) }
}

struct AmuletColors { }

public struct AmuletIcons {
	static public let cancel: some View = Image(systemName: "multiply")
		.resizable()
		.frame(width: 20, height: 20, alignment: .center)
		.foregroundColor(.black)
}

