//
//  TermsDetailView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct TermsDetailView: View {
    var body: some View {
        Text("TERMS DETAIL")
            .navigationStyle("TERMS DETAIL", leftToolBarItems: [.back])
    }
}

#Preview {
    TermsDetailView()
}
