//
//  SideJITParingParser.swift
//  SideStore
//
//  Created by Hristos Sfikas on 19/4/2024.
//  Copyright © 2024 SideStore. All rights reserved.
//

import Foundation

public func parsePlist(from installedApp: String) -> String? {
    if let path = Bundle.main.path(forResource: "ALTPairingFile", ofType: "mobiledevicepairing"),
       let xml = FileManager.default.contents(atPath: path) {
        do {
            if let plistData = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
                // Use the plistData dictionary
                print(plistData)
                
                // Find the UDID key and store its value in a variable
                if let udid = plistData["UDID"] as? String {
                    return String(udid)
                    print(udid)
                } else {
                    print("UDID key not found in plist")
                }
            }
        } catch {
            print("Error parsing plist: \(error)")
        }
    }
    return String("")
}
