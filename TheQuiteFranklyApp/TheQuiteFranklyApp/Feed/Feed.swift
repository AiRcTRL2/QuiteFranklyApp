//
//  Feed.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 29/03/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var twitterNetworkManager = FeedNetworkManager()
    
    var body: some View {
        ZStack {
            Color("Background")
            
            Text("Hello World")
        }.onAppear {
            self.twitterNetworkManager.makeRequest(location: "Twitter")
            print(self.twitterNetworkManager)
        }
        
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
