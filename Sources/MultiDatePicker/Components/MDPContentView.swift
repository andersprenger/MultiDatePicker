//
//  MonthContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * Displays the calendar of MDPDayOfMonth items using MDPDayView views.
 */
struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let columns = Array<GridItem>(
        repeating: GridItem (.flexible(minimum: UIScreen.main.bounds.width * 0.045, maximum: UIScreen.main.bounds.width)),
        count: 7
    )
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].replacingOccurrences(of: ".", with: "").uppercased())
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            
            // The actual days of the month.
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight:  UIScreen.main.bounds.width * 0.05, maxHeight:  UIScreen.main.bounds.width * 0.05)
                } else {
                    MDPDayView(dayOfMonth: monthDataModel.days[index])
                }
            }
        }
        .padding([.bottom, .horizontal], 10)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MDPContentView()
            .environmentObject(MDPModel())
    }
}
