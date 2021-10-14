//
//  ClearButton.swift
//  MovieReleaseDateApp
//
//  Created by Jason Bannister on 16/09/2021.
//

import Foundation
import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing)
        {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                })
                {Image(systemName: "xmark.circle")
                    .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
    
    
}
