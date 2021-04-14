//
//  RCNativeRedirectHandler.swift
//  RCNativeiOSSDK
//
//  Created by user on 12.04.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import Foundation
import UIKit

struct RCNativeRedirectHandler {
  static func handleURL(_ url: URL, supportedDomains: [String]?) {
    URLSession.shared.dataTask(with: url) { (_, response, error) in
      DispatchQueue.main.async {
        if let httpResponse = response as? HTTPURLResponse,
           let redirectedUrl = httpResponse.url,
           let urlComponents = URLComponents(url: redirectedUrl, resolvingAgainstBaseURL: false),
           let host = urlComponents.host,
           let supportedDomains = supportedDomains,
           supportedDomains.contains(host) {
          let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
          activity.webpageURL = redirectedUrl
          let _ = UIApplication.shared.delegate?.application?(UIApplication.shared, continue: activity, restorationHandler: { (_) in
          })
          return
        }
        UIApplication.shared.open(url)
      }
    }.resume()
  }
}
