//
//  BackdropCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 15/03/2022.
//

import SwiftUI

struct BackdropCell: View {
    
    let backdropPath: String?
    @Binding var showVideoView: Bool
    let isVideoAnable: Bool
    
    var body: some View {
        VStack {
            if backdropPath != nil {
                ZStack {
                    ZStack(alignment: .bottom) {
                        AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + backdropPath!)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.secondary)
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9 / 1.77777777777778)
                                ProgressView()
                            }
                            
                        }
                        LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .top)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9 / 1.77777777777778 / 2)
                    }
                    if isVideoAnable {
                        Button {
                            showVideoView = true
                        } label: {
                            Image(systemName: "play.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .scaleEffect(1.5)
                        }
                        
                    }
                }
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
}
struct BackdropCell_Previews: PreviewProvider {
    static var previews: some View {
        BackdropCell(backdropPath: "", showVideoView: .constant(true), isVideoAnable: true)
    }
}
