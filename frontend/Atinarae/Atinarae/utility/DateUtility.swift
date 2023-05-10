//
//  DateUtility.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/09.
//

import Foundation

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

func parseDate(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
}
func calculateDDay(targetDate: Date) -> Int? {
    let calendar = Calendar.current
    let currentDate = calendar.startOfDay(for: Date())
    let targetDate = calendar.startOfDay(for: targetDate)
    let components = calendar.dateComponents([.day], from: currentDate, to: targetDate)
    return components.day
}
