//
//  NavigationLine.swift
//  ToolBox
//
//  Created by bytedance on 2022/2/7.
//

import SwiftUI

struct NavigationLineView: View {
    var lineName: String
    
    var body: some View {
        HStack {
            Text("👉🏻")
            Spacer()
            Text("\(lineName)")
            Spacer()
            Text("👈🏻")
        }
        .padding()
    }
}

struct NavigationLine_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLineView(lineName: "Undefine")
    }
}
