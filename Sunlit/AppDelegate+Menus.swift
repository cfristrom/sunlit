//
//  AppDelegate+Menus.swift
//  Sunlit
//
//  Created by Manton Reece on 5/12/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit

extension AppDelegate {

	override func buildMenu(with builder: UIMenuBuilder) {
		// only look at main menu, not contextual menus
		guard builder.system == .main else { return }
		
		// remove Format menu
		builder.remove(menu: .format)

		// add File -> New Post
		let newpost_item = UIKeyCommand(title: "New Post", action: #selector(AppDelegate.newPost), input: "n", modifierFlags: [ .command ])

		let newpost_menu = UIMenu(title: "", options: .displayInline, children: [ newpost_item ])
		builder.insertChild(newpost_menu, atStartOfMenu: .file)

		// add File -> Sign Out
		let signout_item = UIKeyCommand(title: "Sign Out", action: #selector(AppDelegate.signOut), input: "", modifierFlags: [])

		let signout_menu = UIMenu(title: "", options: .displayInline, children: [ signout_item ])
		builder.insertChild(signout_menu, atEndOfMenu: .file)

		// TODO: get current username and profile photo
		var profile_username = "username"
		var profile_image: UIImage?

		// add View -> Timeline, Discover, profile
		let timeline_item = UIKeyCommand(title: "Timeline", action: #selector(AppDelegate.showTimeline), input: "1", modifierFlags: .command)
		let discover_item = UIKeyCommand(title: "Discover", action: #selector(AppDelegate.showDiscover), input: "2", modifierFlags: .command)
		let profile_item = UIKeyCommand(title: "@\(profile_username)", image: profile_image, action: #selector(AppDelegate.showProfile), input: "3", modifierFlags: .command)

		let view_menu = UIMenu(title: "", options: .displayInline, children: [ timeline_item, discover_item, profile_item ])
		builder.insertChild(view_menu, atStartOfMenu: .view)
	}

	@objc func newPost() {
	}

	@objc func signOut() {
	}

	@objc func showTimeline() {
	}

	@objc func showDiscover() {
	}

	@objc func showProfile() {
	}

}
