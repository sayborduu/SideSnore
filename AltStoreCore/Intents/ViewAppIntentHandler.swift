//
//  ViewAppIntentHandler.swift
//  ViewAppIntentHandler
//
//  Created by Riley Testut on 7/10/20.
//  Copyright © 2020 Riley Testut. All rights reserved.
//

import Intents
import Foundation
import UniformTypeIdentifiers
import AltStoreCore

import Roxas

import AltStoreCore
import AltSign
import minimuxer

@available(iOS 14, *)
public class ViewAppIntentHandler: NSObject, ViewAppIntentHandling
{
    public func provideAppOptionsCollection(for intent: ViewAppIntent, with completion: @escaping (INObjectCollection<App>?, Error?) -> Void)
    {
        DatabaseManager.shared.start { (error) in
            if let error = error
            {
                print("Error starting extension:", error)
            }
            
            DatabaseManager.shared.persistentContainer.performBackgroundTask { (context) in
                let apps = InstalledApp.all(in: context).map { (installedApp) in
                    if UserDefaults.standard.textInputSideJITServerurl ?? "" == "" {
                        return getrequest(from: installedApp.resignedBundleIdentifier, IP: "http://sidejitserver._http._tcp.local:8080")
                    } else {
                        return getrequest(from: installedApp.resignedBundleIdentifier, IP: UserDefaults.standard.textInputSideJITServerurl ?? "")
                    }
                    //return App(identifier: installedApp.bundleIdentifier, display: installedApp.name)
                }
                
                // let collection = INObjectCollection(items: apps)
                // completion(collection, nil)
        }
    }
}



func getrequest(from installedApp: String, IP ipadress: String) -> String? {
        var serverUrl = ipadress ?? ""
        let serverUdid: String = fetch_udid()?.toString() ?? ""
        let appname = installedApp
        let serveradress2 = serverUdid + "/" + appname
    
    
        var combinedString = "\(serverUrl)" + "/" + serveradress2 + "/"
    guard let url = URL(string: combinedString) else {
        print("Invalid URL: " + combinedString)
        return("beans")
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            print("Error fetching data: \(error.localizedDescription)")
            return
        }
        
        if let data = data {
            if let dataString = String(data: data, encoding: .utf8), dataString == "Enabled JIT for '\(installedApp)'!" {
                let content = UNMutableNotificationContent()
                content.title = "JIT Successfully Enabled"
                content.subtitle = "JIT Enabled For \(installedApp)"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: "EnabledJIT", content: content, trigger: nil)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }.resume()
    return("")
}
}
