//
//  VideoView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/03/2022.
//

import SwiftUI
import WebKit

struct VideoView: View {
    
    @State private var youTubeURL: String = "https://www.youtube.com/watch?v=6JnN1DmbqoU"
    @State private var youTubeVideoID: String = ""
    @State private var validYouTubeURL = false
    
    var body: some View {
        VStack {
            if validYouTubeURL {
                WebView(videoID: self.youTubeVideoID)
                    .scaledToFit()
            }
            
        }
        .onAppear {
        if let videoID = self.youTubeURL.extractYoutubeID() {
            self.youTubeURL = ""
            self.youTubeVideoID = videoID
            self.validYouTubeURL = true
        } else {
            self.youTubeURL = ""
        }
    }
    
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}

struct WebView: UIViewRepresentable {

    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youTubeURL = URL(string:"https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youTubeURL))
    }
}



extension String {
    func extractYoutubeID() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)

        guard let result = regex?.firstMatch(in: self, range: range) else { return nil }
        return (self as NSString).substring(with: result.range)
    }
}
