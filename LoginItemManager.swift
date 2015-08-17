//
//  LoginItemManager.swift
//  LeapTest5
//
//  Created by Kametrixom on 20.01.15.
//  Copyright (c) 2015 Kametrixom Tikara. All rights reserved.
//

import Foundation

private var list : LSSharedFileList {
	return LSSharedFileListCreate(nil, kLSSharedFileListSessionLoginItems.takeUnretainedValue(), nil).takeRetainedValue()
}

private func itemExists(action : ((item : LSSharedFileListItem) -> Void)? = nil) -> Bool {
	let loginItemsArray = LSSharedFileListCopySnapshot(list, nil).takeRetainedValue() as! [LSSharedFileListItem]

	for item in loginItemsArray {
		var error : Unmanaged<CFError>? = nil
		let thePath = LSSharedFileListItemCopyResolvedURL(item, 0, &error)?.takeRetainedValue()

		if error == nil {
			let path = (thePath! as NSURL).path!

			if path.hasPrefix(NSBundle.mainBundle().bundlePath) {
				if let action = action {
					action(item: item)
				}
				return true
			}
		} else if let error = error?.takeRetainedValue() {
			print(error)
		}
	}
	return false
}

private func isEnabled() -> Bool {
	return itemExists()
}

private func disable() -> Bool {
	return itemExists { LSSharedFileListItemRemove(list, $0) }
}

private func enable() {
	LSSharedFileListInsertItemURL(list, kLSSharedFileListItemBeforeFirst.takeUnretainedValue(), nil, nil, NSBundle.mainBundle().bundleURL, nil, nil)
}

var startAtLogin : Bool {
get {
	return isEnabled()
}
set {
	if newValue != startAtLogin {
		if newValue {
			enable()
		} else {
			disable()
		}
	}
}
}
