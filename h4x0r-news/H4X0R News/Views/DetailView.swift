//
//  DetailView.swift
//  H4X0R News
//
//  Created by Guilherme Cordeiro on 06/02/2020.
//  Copyright © 2020 Tutuland. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        MyWebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.pudim.com.br")
    }
}
