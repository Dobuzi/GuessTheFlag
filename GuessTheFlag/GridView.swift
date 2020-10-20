//
//  PlayGround.swift
//  GuessTheFlag
//
//  Created by 김종원 on 2020/10/19.
//

import SwiftUI

struct PlayGround: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row*4+col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct PlayGround_Previews: PreviewProvider {
    static var previews: some View {
        PlayGround()
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { col in
                        self.content(row, col)
                    }
                }
            }
        }
    }
}
