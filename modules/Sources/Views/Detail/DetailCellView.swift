//
//  DetailCellView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-31.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI
import Model
import Shared

struct DetailCellView: View {
	
	let charm: Charm
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 4) {
			Text(charm.text)
				.foregroundColor(.black)
				.lineLimit(nil)
				.frame(minHeight: 40, alignment: .leading)
			
			Text(charm.dateFormatted ?? "")
				.foregroundColor(.black)
				.font(AmuletFont.defaultFont(12))
			
			Divider()
				.background(Color.black)
				.frame(height: 2)
		}
		
	}
}
