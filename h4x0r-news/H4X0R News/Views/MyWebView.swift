//
//  MyWebView.swift
//  H4X0R News
//
//  Created by Guilherme Cordeiro on 06/02/2020.
//  Copyright © 2020 Tutuland. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct MyWebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}

struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        MyWebView(urlString: "https://www.pudim.com.br")
    }
}
