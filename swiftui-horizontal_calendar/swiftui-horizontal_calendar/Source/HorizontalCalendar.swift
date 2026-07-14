//
//  HorizontalCalendar.swift
//  swiftui-horizontal_calendar
//
//  Created by Huisoo on 7/14/26.
//

import SwiftUI

struct HorizontalCalendar<Content: View>: View {
    var updatesDateOnScroll: Bool
    
    @Binding var date: Date
    var content: (Day) -> Content
    
    init(updatesDateOnScroll: Bool = true, date: Binding<Date>, @ViewBuilder content: @escaping (Day) -> Content) {
        self.updatesDateOnScroll = updatesDateOnScroll
        self._date = date
        self.content = content
        
        /// Loading intial week content
        let weeks: [Week] = (-1...1).compactMap {
            Week.load(form: date.wrappedValue, value: $0)
        }
        self.weeks = weeks
    }
    
    @State private var weeks: [Week]
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var containerSize: CGSize = .zero
    @State private var isLocked: Bool = false
    @State private var lockedID: String?
    
    @State private var weekIndex: Int = 1
    
    private let calendar = Calendar.current
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(weeks) { week in
                    HStack(spacing: 0) {
                        ForEach(week.days) { day in
                            content(day)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .containerRelativeFrame(.horizontal)
                    .visualEffect { [isLocked, lockedID] content, proxy in
                        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
                        return content
                            .opacity(isLocked ? (lockedID == week.id ? 1 : 0) : 1)
                            .offset(x: isLocked ? -minX : 0)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .scrollPosition($scrollPosition)
        .defaultScrollAnchor(.center, for: .initialOffset) // defaultScrollAnchor 기능이 항상 제대로 작동하지는 않음
        .onAppear {
            // 1. weeks 배열에 인덱스 1(두 번째 항목)이 존재하는지 안전하게 확인합니다.
            if weeks.indices.contains(1) {
                // 2. 조건이 맞다면, 해당 항목의 id를 가진 위치로 스크롤을 이동시킵니다.
                scrollPosition.scrollTo(id: weeks[1].id)
            }
        }
        .onGeometryChange(for: CGSize.self) {
            $0.size
        } action: { newValue in
            containerSize = newValue
        }
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.contentOffset.x + $0.contentInsets.leading
        } action: { oldValue, newValue in
            guard containerSize.width != .zero else { return }
            weekIndex = Int((newValue / containerSize.width).rounded())
            
            let addPreviousWeeks = newValue < 0
            let addNextWeeks = newValue > (containerSize.width * 2)
            
            if (addPreviousWeeks || addNextWeeks) && !isLocked {
                guard let firstWeekDate = weeks.first?.days.first?.date else { return }
                guard let lastWeekDate = weeks.last?.days.first?.date else { return }
                
                let previousTwoWeeks: [Week] = [
                    .load(form: firstWeekDate, value: -2),
                    .load(form: firstWeekDate, value: -1)
                ]
                
                let nextTwoWeeks: [Week] = [
                    .load(form: lastWeekDate, value: 1),
                    .load(form: lastWeekDate, value: 2)
                ]
                
                if addPreviousWeeks {
                    lockedID = weeks.first?.id
                } else {
                    lockedID = weeks.last?.id
                }
                
                isLocked = true

                /// inserting new data and eliminating old data
                if addPreviousWeeks {
                    weeks.insert(contentsOf: previousTwoWeeks, at: 0)
                    weeks.removeLast(2)
                } else {
                    weeks.append(contentsOf: nextTwoWeeks)
                    weeks.removeFirst(2)
                }
            } else {
                if isLocked {
                    var transaction = Transaction()
                    transaction.scrollPositionUpdatePreservesVelocity = true
                    withTransaction(transaction) {
                        if addPreviousWeeks {
                            scrollPosition.scrollTo(x: containerSize.width * 2)
                        } else {
                            scrollPosition.scrollTo(x: -containerSize.width * 2)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        isLocked = false
                        lockedID = nil
                    }
                }
            }
        }
        .onChange(of: weekIndex) { oldValue, newValue in
            if updatesDateOnScroll && weeks.indices.contains(newValue) {
                let symbolIndex = calendar.component(.weekday, from: date) - 1
                date = weeks[newValue].days[symbolIndex].date
            }
        }
    }
}

#Preview {
    ContentView()
}
