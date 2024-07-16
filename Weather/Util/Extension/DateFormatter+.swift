//
//  DateFormatter+.swift
//  Weather
//
//  Created by NERO on 7/14/24.
//

import Foundation

extension DateFormatter {
    static private let formatter = DateFormatter()
    
    static func convertDateFormat(_ date: Date) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd"
        let convertedString = formatter.string(from: date)
        guard let convertedDate = formatter.date(from: convertedString) else { return nil }
        return convertedDate
    }
    
    static func dateToFormattedString(_ date: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    static func stringToDate(_ string: String) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd"
        guard let convertedDate = formatter.date(from: string) else { return nil }
        return convertedDate
    }
    
    static func dateToWeekday(_ date: Date) -> String {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        let weekday = formatter.string(from: date)
        return weekday
    }
    
//    static func timestampToWeekday(timestamp: Int) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "E"
//        
//        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
//        let day = formatter.string(from: date)
//        return day
//    }
}

extension DateFormatter {
    static func convertKRDate(_ date: String) -> Date? {
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
        let KSTTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let KSTSeconds = KSTTimeZone.secondsFromGMT(for: UTCDate)
        let KRDate = UTCDate.addingTimeInterval(TimeInterval(KSTSeconds))
        return KRDate
    }
    
    static func convertTXDate(_ date: String) -> Date? {
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
        let CSTTimeZone = TimeZone(identifier: "America/Chicago")!
        let CSTSeconds = CSTTimeZone.secondsFromGMT(for: UTCDate)
        let TXDate = UTCDate.addingTimeInterval(TimeInterval(CSTSeconds))
        return TXDate
    }
    
    static func convertCADate(_ date: String) -> Date? {
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
        let PSTTimeZone = TimeZone(identifier: "America/Los_Angeles")!
        let PSTSeconds = PSTTimeZone.secondsFromGMT(for: UTCDate)
        let CADate = UTCDate.addingTimeInterval(TimeInterval(PSTSeconds))
        return CADate
    }
    
    static func convertHKDate(_ date: String) -> Date? {
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
        let HKTTimeZone = TimeZone(identifier: "Asia/Hong_Kong")!
        let HKTSeconds = HKTTimeZone.secondsFromGMT(for: UTCDate)
        let HKDate = UTCDate.addingTimeInterval(TimeInterval(HKTSeconds))
        return HKDate
    }
    
    static func convertJPDate(_ date: String) -> Date? {
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
        let JSTTimeZone = TimeZone(identifier: "Asia/Tokyo")!
        let JSTSeconds = JSTTimeZone.secondsFromGMT(for: UTCDate)
        let JPDate = UTCDate.addingTimeInterval(TimeInterval(JSTSeconds))
        return JPDate
    }
}
