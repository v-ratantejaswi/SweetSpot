//
//  YTVideoView.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/8/24.
//

import SwiftUI
import WebKit

struct YTVideoView: UIViewRepresentable {
    let videoURL: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView:WKWebView, context: Context){
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: videoURL))
    }
    
}

//#Preview {
//    YTVideoView()
//}
