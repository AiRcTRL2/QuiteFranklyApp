//
//  ChatNetworkManager.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 09/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire

private enum ChatEndpoints {
    static let youtubeDataApi = "https://www.googleapis.com/youtube/v3/search?"
}

private enum Key {
    static let youtube = "AIzaSyDK22ADqnNb-z3RyZr7eKf8h3WBNMQgVlE"
}

class ChatDataController: ObservableObject {
    
    @Published var query = ChatPathsAndReferences.refs.databaseChats.queryLimited(toLast:100).queryOrdered(byChild: "date")
    @Published var messages = [ChatMessage]()
    @Published var youtubeLink: String?
    
    init() {
        self.query.observe(.childAdded) { snapshot in
           let data = JSON(snapshot.value as Any)
           
           if let chatMessage = ChatMessage.parseFirebaseQuery(dataJSON: data){
            self.messages.append(chatMessage)
           }
        }
    }
    
    func getYoutubeLiveStream() {
        
        makeRequest(eventType: "live") { videoLink, error in
            if let videoId = videoLink {
                self.youtubeLink = videoId
                return
            }
            // if first request failed, searh for upcoming videos
            self.makeRequest(eventType: "upcoming") { videoLink, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }
                
                if let upcomingEvent = videoLink {
                    self.youtubeLink = upcomingEvent
                    return
                }
            }
            
        }
        
    }
    
    func makeRequest(eventType: String, completion: @escaping (_ videoLink: String?, _ error: String?) ->()) {
        let headers: HTTPHeaders = ["X-Ios-Bundle-Identifier": "RebellionMedia.TheQuiteFranklyApp"]
        let parameters: [String: String] = ["part": "snippet",
                                                "channelId": "UCtB5nbKHYsX8EGIk9cOevaQ", "type": "video", "eventType":"\(eventType)", "key": Key.youtube]

            
        AF.request(ChatEndpoints.youtubeDataApi,
                    method: .get,
                    parameters: parameters,
                    headers: headers,
                    interceptor: nil).validate().responseJSON { (response) in
                        
                        switch response.result {
                            
                        case .success(let value):
                            let json = SwiftyJSON.JSON(value)
                            let videoID = json["items"][0]["id"]["videoId"]
                            
                            if videoID != JSON.null {
                                completion(videoID.stringValue, nil)
                                return
                            } else {
                                completion(nil, "No video link found")
                            }
                            
                        case .failure(_):
                            print("Failure Youtube: ", response)
                            completion(nil, response.description)
                            return
                        }
        }
    }
}

//
//"""
//Youtube's Response:  {
//  "items" : [
//    {
//      "etag" : "\"nxOHAKTVB7baOKsQgTtJIyGxcs8\/CXLIOFPuosNZfLbm1CjKiLa1mBY\"",
//      "id" : {
//        "videoId" : "5qap5aO4i9A",
//        "kind" : "youtube#video"
//      },
//      "kind" : "youtube#searchResult",
//      "snippet" : {
//        "channelId" : "UCSJ4gkVC6NrvII8umztf0Ow",
//        "liveBroadcastContent" : "live",
//        "thumbnails" : {
//          "medium" : {
//            "height" : 180,
//            "url" : "https:\/\/i.ytimg.com\/vi\/5qap5aO4i9A\/mqdefault_live.jpg",
//            "width" : 320
//          },
//          "high" : {
//            "url" : "https:\/\/i.ytimg.com\/vi\/5qap5aO4i9A\/hqdefault_live.jpg",
//            "height" : 360,
//            "width" : 480
//          },
//          "default" : {
//            "url" : "https:\/\/i.ytimg.com\/vi\/5qap5aO4i9A\/default_live.jpg",
//            "height" : 90,
//            "width" : 120
//          }
//        },
//        "title" : "lofi hip hop radio - beats to relax\/study to",
//        "publishedAt" : "2020-02-22T19:51:37.000Z",
//        "description" : "Thank you for listening, I hope you will have a good time here :) Listen to the playlist on Spotify, Apple music and more → https:\/\/bit.ly\/chilledcow-playlists ...",
//        "channelTitle" : "ChilledCow"
//      }
//    },
//    {
//      "etag" : "\"nxOHAKTVB7baOKsQgTtJIyGxcs8\/NrDiS3kySkw83auXqaO169cmqYY\"",
//      "id" : {
//        "videoId" : "DWcJFNfaw9c",
//        "kind" : "youtube#video"
//      },
//      "kind" : "youtube#searchResult",
//      "snippet" : {
//        "title" : "lofi hip hop radio - beats to sleep\/chill to",
//        "thumbnails" : {
//          "medium" : {
//            "width" : 320,
//            "url" : "https:\/\/i.ytimg.com\/vi\/DWcJFNfaw9c\/mqdefault_live.jpg",
//            "height" : 180
//          },
//          "high" : {
//            "height" : 360,
//            "width" : 480,
//            "url" : "https:\/\/i.ytimg.com\/vi\/DWcJFNfaw9c\/hqdefault_live.jpg"
//          },
//          "default" : {
//            "height" : 90,
//            "width" : 120,
//            "url" : "https:\/\/i.ytimg.com\/vi\/DWcJFNfaw9c\/default_live.jpg"
//          }
//        },
//        "channelTitle" : "ChilledCow",
//        "liveBroadcastContent" : "live",
//        "description" : "Welcome to the sleepy lofi hip hop radio. This playlist contains the smoothest lofi hip hop beats, perfect to help you chill or fall asleep Check out the ...",
//        "publishedAt" : "2020-02-25T19:00:14.000Z",
//        "channelId" : "UCSJ4gkVC6NrvII8umztf0Ow"
//      }
//    }
//  ],
//  "kind" : "youtube#searchListResponse",
//  "regionCode" : "IE",
//  "etag" : "\"nxOHAKTVB7baOKsQgTtJIyGxcs8\/uIV3PCPOmZ9OfzHtAhTCivZg5Q8\"",
//  "pageInfo" : {
//    "totalResults" : 2,
//    "resultsPerPage" : 5
//  }
//}
//"""
