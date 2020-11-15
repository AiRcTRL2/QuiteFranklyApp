//
//  SwiftUIView.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 29/03/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    
    var body: some View {
        TabView {
            Feed()
                .tabItem {
                Text("Feed")
            }
            
            BlogPostView()
                .tabItem {
                    Text("Blog")
            }
            
            ChatView()
                .tabItem {
                    Text("Chat")
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

extension UITabBarController {
    override open func viewDidLoad() {
        let standardAppearance = UITabBarAppearance()
        let fontColor = UIColor(named: "ImageTints")!

        standardAppearance.backgroundColor = UIColor(named: "TabBarColour")

        standardAppearance.stackedLayoutAppearance.focused.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: fontColor]
        
        standardAppearance.inlineLayoutAppearance.focused.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: fontColor]
        
        standardAppearance.compactInlineLayoutAppearance.focused.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: fontColor]
        standardAppearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: fontColor]
        
        
        tabBar.standardAppearance = standardAppearance
    }
}
