//
//  SendButton.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 17/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftUI

protocol SendButtonDelegate {
    func sendMessagePressed()
}

struct SendButton: View {
    var delegate: SendButtonDelegate?
    
    // provide delegate on init with class that utilises this button
    init(delegate: SendButtonDelegate?) {
        self.delegate = delegate
    }
    
    var body: some View {
        Button(action: {
            // if exists, perform delegate action
            if self.delegate != nil {
                self.delegate?.sendMessagePressed()
            }
        }, label: {Image(systemName: "paperplane.fill")})
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton(delegate: nil)
    }
}
