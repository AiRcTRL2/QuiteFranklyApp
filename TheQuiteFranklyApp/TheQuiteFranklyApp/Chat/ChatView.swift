//
//  ChatView.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 09/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import AVKit


struct ChatView: View {
    @ObservedObject var chatDataController: ChatDataController = ChatDataController()
    @State var message = ""
    
    private let player = AVPlayer(url: URL(string: "https://5g9s179kfgx9wn8tqwj9-cul47i.p5cdn.com/dlive/transcode-89-197/ariesjrs/1605933895/src/live.m3u8")!)
    
    init() {
        UITableView.appearance().separatorStyle = .none
        chatDataController.getYoutubeLiveStream()
    }
    
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color("Background")
                
                VStack {
//                    GeometryReader { (videoViewSize) in
                        // live stream
//                        YouTubeWebView(url: self.chatDataController.youtubeLink ?? "", screenDimensions: geometry).onTapGesture {
//                        }
//                    }
                    
                    if #available(iOS 14.0, *) {
                        VideoPlayer(player: player)
                    }
                    // messages
                    List {
                        ForEach(self.chatDataController.messages, id: \.id) { message in
                                Text(message.message)
                        }
                    }

                    // search bar
                    TextField("Send a message...", text: self.$message)
                        .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white))
                        .multilineTextAlignment(.center)
                        .frame(width: geometry.size.width * 0.9, height: 20, alignment: .bottom)
                        .overlay(SendButton(delegate: self)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 8))
                        .foregroundColor(Color.white), alignment: .trailing)
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }
    }

}

extension ChatView: SendButtonDelegate {
    func sendMessagePressed() {
        ChatMessage(senderID: 01, senderDisplayName: "Admin", message: self.message, date: Date()).sendMessage()
        self.message = ""
    }
}

extension ChatView {
}

struct PlayerView: UIViewControllerRepresentable {
    @Binding var player: AVPlayer

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<PlayerView>) {
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlayerView>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        return controller
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
