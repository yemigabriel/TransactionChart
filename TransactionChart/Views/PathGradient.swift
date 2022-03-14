//
//  PathGradient.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

struct PathGradient: View {
    let path: Path
    
    var body: some View {
        LinearGradient(
            colors: [
                Color.blue.opacity(0.5),
                Color.blue.opacity(0.3),
                Color.blue.opacity(0.2),
                Color.blue.opacity(0.1)
            ],
            startPoint: .top,
            endPoint: .bottom)
            .clipShape(path)
    }
}

struct PathGradient_Previews: PreviewProvider {
    static var previews: some View {
        PathGradient(path: Path())
    }
}
