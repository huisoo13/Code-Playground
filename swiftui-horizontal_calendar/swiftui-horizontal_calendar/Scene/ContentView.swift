//
//  ContentView.swift
//  swiftui-horizontal_calendar
//
//  Created by Huisoo on 7/14/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Date = .now
    private let calendar = Calendar.current
    
    var body: some View {
        VStack {
            HorizontalCalendar(date: $selection) { day in
                let isSelected = calendar.isDate(selection, inSameDayAs: day.date)
                
                /// Customize the date label
                VStack(spacing: 8) {
                    Text(day.weekdaySymbol)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("\(day.value)")
                        .fontWeight(isSelected ? .semibold : .regular)
                        .foregroundStyle(isSelected ? .white : (day.notFormThisMonth ? .gray : .primary))
                        .frame(width: 38, height: 38)
                        .background {
                            Circle()
                                .fill(isSelected ? .black : .clear)
                                .scaleEffect(x: isSelected ? 1 : 0.5, y: isSelected ? 1 : 0.5, anchor: .center)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selection = day.date
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
