//
//  PlayerUIView.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 13/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        let url = URL(string: "https://www.youtube.com/watch?v=4ixsaChnjnc")!
        let player = AVPlayer(url: url)
        player.play()
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
