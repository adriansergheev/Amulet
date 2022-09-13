import Foundation

public struct CharmResponse: Decodable {
	public let charm: [Charm]
}

public struct Charm: Decodable, Identifiable, Equatable {
	public let id: Int
	public let text: String
	public let date: Date
	
	public init(id: Int, text: String, date: Date) {
		self.id = id
		self.text = text
		self.date = date
	}
	
	enum CodingKeys: CodingKey {
		case id
		case text
		case date
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.text = try container.decode(String.self, forKey: .text)
		let dateAsString = try container.decode(String.self, forKey: .date)
		let dateFormatter = ISO8601DateFormatter()
		guard let date = dateFormatter.date(from: dateAsString) else {
			throw NSError() as Error // TODO: Convert to typed error.
		}
		self.date = date
	}
}
