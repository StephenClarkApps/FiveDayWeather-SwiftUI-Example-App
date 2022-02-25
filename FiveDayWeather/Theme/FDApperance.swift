//
//  FDApperance.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import UIKit
import Foundation

// To demostrate a mixture of approaches combining UIKit with SwiftUI
// this is an apperance Proxy class which taps into the appearance of
// the UIKit object which SwiftUI uses under the hood.

class FDAppearance {

    /// This method will trigger all the appearance methods
    static func setUpApperance() {
        setupTableView()
        setupTabBarApperance()
        setupNavigationBar()
    }
    
    static func setupTableView() {
        let tableViewApperance = UITableView.appearance()
        tableViewApperance.separatorInset = UIEdgeInsets.zero
        tableViewApperance.separatorColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.00)
    }
    
    static func setupTabBarApperance() {
        let appearance = UITabBar.appearance()
        
        appearance.isOpaque = true
        appearance.tintColor = UIColor.white
        appearance.barTintColor = UIColor.systemBackground
        appearance.backgroundColor = UIColor.systemBackground
        
        // Code extends bar color under top data / time area
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes =  [.foregroundColor: UIColor.white,
                                               NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 10)]
            appearance.backgroundColor = UIColor.systemBackground
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
        
        appearance.barStyle = .black
        appearance.isTranslucent = false
    }
    
    static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
        ]

        appearance.largeTitleTextAttributes = attrs

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
