//
//  YouTubeWebView.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 18/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

private enum deviceHeights {
    // these heights exclude safe areas/bars
    static let fourInchDevice = 500.0
    static let fourPointSevenInchDevice = 600.0
    static let fivePointFiveInchDevice = 670.0
    static let sixAndAHalfInchDevice = 770.0
}

struct YouTubeWebView: UIViewRepresentable {
    var url: String?
    var screenDimension: GeometryProxy?
    
    init(url: String, screenDimensions: GeometryProxy) {
        self.screenDimension = screenDimensions
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url!) else {
            return WKWebView()
        }
        
        guard let screenDimensions = screenDimension else {
            return WKWebView()
        }
        
        
        let intendedVideoHeight = getCalculatedVideoSize(height: Double(screenDimensions.size.height))
        
        let htmlString =
        """
        <!DOCTYPE html>
        <html>
            <body style="background-color: black;">
        <iframe style="min-width:100%; min-height:100%; max-width:100%;" width=\"1920\" height=\"\(intendedVideoHeight)\" src=\"https://www.youtube.com/embed/\(url)?playsinline=1\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen>
                </iframe>
            </body>
        </html>
        """

        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        let videoDimensions = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        let wkWebView = WKWebView(frame: videoDimensions, configuration: webConfiguration)
        wkWebView.scrollView.isScrollEnabled = false
        wkWebView.contentMode = UIView.ContentMode.scaleToFill
        wkWebView.loadHTMLString(htmlString, baseURL: URL(string: "http://www.youtube.com")!)
        return wkWebView
    }
    
    func getCalculatedVideoSize(height: Double) -> Double {
        print(height)
        if height <= deviceHeights.fourInchDevice {
            return deviceHeights.fourInchDevice * 1.4
        } else if height <= deviceHeights.fourPointSevenInchDevice{
            return deviceHeights.sixAndAHalfInchDevice * 0.95
        }  else if height <= deviceHeights.fivePointFiveInchDevice{
            return deviceHeights.sixAndAHalfInchDevice * 0.97
        } else if height <= deviceHeights.sixAndAHalfInchDevice{
            return deviceHeights.sixAndAHalfInchDevice * 1.1
        } else {
            return 500
        }
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<YouTubeWebView>) {
    }
    
}
