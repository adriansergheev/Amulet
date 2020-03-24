//
//  MainViewModel.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

final class MainViewModel {

}

struct Charm: Identifiable {
	var id: Int
	var text: String
}

public let demoCharmsText: [String] = [
	"Don't keep texting people who don't want to text you back. You deserve so much more than that.",
	"Try to take one action tonight that will make tomorrow morning just a little easier.",
	"Accept that today won't be perfect. And that's ok.",
	"Slow down. The world can begin and end on your freaking temrs today!",
	"Set a goal for this week. Just one!",
	"Remember that you're human and you're allowed to forget, and you'll remember tomorrow.",
	"Today, give yourself permission to cancel one thing that's just too much. You don't have to do everything.",
	"Things have been piling up and you might need a bit more sleep. Pick a night, and get to sleep early!",
	"Put on the right song and allow yourself to drift away.",
	"Give somebody you love a small gift. Nothing special, just a small gift.",
	"Speaking of rituals. Try and create one for your shower or your bath. A ritual of looking after you. It's comforting to have a series of careful steps and actions that you know you're going to take every morning, where each one makes a difference to your personal care. ✨"
]

let demoCharms: [Charm] = demoCharmsText.enumerated().map { Charm(id: $0, text: $1) }
