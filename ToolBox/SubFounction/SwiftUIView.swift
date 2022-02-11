//
//  SwiftUIView.swift
//  ToolBox
//
//  Created by bytedance on 2022/2/7.
//

import SwiftUI

struct SwiftUIView: View {
    @State var counter:Int = 0
    
    var body: some View {
        VStack {
            Button(action: {
                self.counter += 1
            }, label: {
                Text("Counter: \(counter)")
            })
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                self.counter = 0
            }, label: {
                Text("Reset counter")
            })
        }.onAppear {
            let db = UserDefaults.init()
            counter = db.integer(forKey: "counter")
        }.onDisappear(perform: {
            let db = UserDefaults.init()
            db.set(counter, forKey: "counter")
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
