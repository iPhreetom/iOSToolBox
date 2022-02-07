//
//  ContentView.swift
//  ToolBox
//
//  Created by bytedance on 2022/2/7.
//

import SwiftUI

struct ContentView: View {
    static var countPrint = 0
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SwiftUIView()) {
                    NavigationLineView(lineName: "SwiftUIView")
                }
                NavigationLink(destination: CameraView()) {
                    NavigationLineView(lineName: "CameraView")
                }
                NavigationLink(destination: NetworkView()) {
                    NavigationLineView(lineName: "NetworkView")
                }
            }
            .navigationTitle("ToolBox")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
