//
//  MonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * MDPMonthView is really the crux of the control. This displays everything and handles the interactions
 * and selections. MulitDatePicker is the public interface that sets up the model and this view.
 */
struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                MDPMonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                Spacer()
                
                Button {
                    showPrevMonth()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22))
                }
                .padding()
                
                Button {
                    showNextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 22))
                }
                .padding()
            }
            .padding(.leading, 18)
            
            if showMonthYearPicker {
                MDPMonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                    self.monthDataModel.show(month: month, year: year)
                }
                .padding(.horizontal)
            }
            else {
                MDPContentView()
            }
        }
      
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthView()
            .environmentObject(MDPModel())
    }
}
