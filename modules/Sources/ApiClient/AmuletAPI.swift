import Foundation
import Model
import XCTestDynamicOverlay

struct AmuletClient {
	var getCharms: @Sendable () async throws -> CharmResponse
	
	enum AmuletError: LocalizedError, Identifiable {
		
		case addressUnreachable(URL)
		case invalidResponse
		case invalidMock
		
		var errorDescription: String? {
			switch self {
			case .invalidResponse:
				return "The server responded with garbage."
			case .addressUnreachable(let url):
				return "\(url.absoluteString) is unreachable."
			case .invalidMock:
				return "Can't load the mock json"
			}
		}
		
		var id: String { localizedDescription }
	}
}

extension AmuletClient {
	static let live = Self {
//		let url = AmuletBaseURL.url.appendingPathComponent(".json/")
//		let (data, _) = try await URLSession.shared
//			.data(from: url)
//		let parsed = try JSONDecoder().decode(CharmResponse.self, from: data)
//		return parsed
		fatalError()
	}
}

extension AmuletClient {
	static let mock = Self {
		guard let filePath = Bundle.module.path(forResource: "AmuletMock", ofType: "json") else {
			throw AmuletError.invalidMock
		}
		let url = URL(fileURLWithPath: filePath)
		let data = try Data(contentsOf: url)
		let parsed = try JSONDecoder().decode(CharmResponse.self, from: data)
		return parsed
	}
}
