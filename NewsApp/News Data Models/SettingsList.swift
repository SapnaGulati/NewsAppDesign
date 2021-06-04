//
//  SettingsList.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class SettingsList {
    static func getSettings() -> [Settings] {
        let settings = [
            Settings(name: "Update Preferences"),
            Settings(name: "Sources"),
            Settings(name: "Bookmarks"),
            Settings(name: "Manage Subscriptions"),
            Settings(name: "Logout")
        ]
        return settings
    }
}
