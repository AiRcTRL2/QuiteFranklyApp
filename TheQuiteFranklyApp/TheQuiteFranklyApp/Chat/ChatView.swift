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
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color("Background")
                
                VStack {
                    if #available(iOS 14.0, *) {
                        VideoPlayer(player: player)
                    }
                    
                    
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }.onAppear {
            player.play()
        }.onDisappear {
            player.pause()
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
