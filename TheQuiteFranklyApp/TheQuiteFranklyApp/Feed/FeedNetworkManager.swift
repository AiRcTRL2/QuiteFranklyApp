//
//  FeedNetworkManager.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 01/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON
import Swifter
import Alamofire

private enum EndPoints {
    static let twitter = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=PoliticalOrgy&count=20"
}

private enum ApiTokensHeaders {
    static let twitterToken: HTTPHeaders = ["Authorization":"Bearer AAAAAAAAAAAAAAAAAAAAADKIDQEAAAAAsMuIo4FV%2FDURteVZZMziR2gCQgU%3Du0DZOLdlGYSFbiKsauMcnC5TvHs1jhYrwv2coMrjMUZSEj2QNE"]
}

private enum Parameters {
    static let twitterParams = ["exclude_replies": "true"]
}

private enum SocialMedias {
    static let twitter = "Twitter"
    static let facebook = "Facebook"
    static let youtube = "Youtube"
}

class FeedNetworkManager: ObservableObject {
    
    @Published var twitterPosts: [Any] = []
    
    var apiEndpoint: String = ""
    var headers: HTTPHeaders = [:]
    var parameters: [String: String] = [:]
}

extension FeedNetworkManager {
    func makeRequest(location: String) {
        // configure the request
        switch location {
        case SocialMedias.twitter:
            self.apiEndpoint = EndPoints.twitter
            self.headers = ApiTokensHeaders.twitterToken
            self.parameters = Parameters.twitterParams
        case SocialMedias.facebook:
            self.apiEndpoint = ""
        case SocialMedias.youtube:
            self.apiEndpoint = ""
        default:
            break
        }
        
        AF.request(self.apiEndpoint,
                   method: .get,
                   parameters: self.parameters,
                   headers: self.headers,
                   interceptor: nil).validate().responseJSON { (response) in

                    switch response.result {
                    case .success(let value):
                        switch location {
                        case SocialMedias.twitter:
                            let json = SwiftyJSON.JSON(value)
//                            print("Twitter's response is: ", json[0])
                        default:
                            break
                        }
//                        print(response)
                    case .failure(_):
                        print()
//                        print(response)
                    }
        }
    }
}
