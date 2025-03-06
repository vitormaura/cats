import Foundation

public extension String {
    func toCurrency() -> String? {
        guard let number = Double(self) else {
            return nil
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number))
    }

    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }

    func toFormattedDate(from dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                         to dateFormatted: String = "yyyy/MM/dd 'at' HH:mm:ss") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.current
        guard let date = formatter.date(from: self) else {
            return nil
        }

        formatter.dateFormat = dateFormatted
        return formatter.string(from: date)
    }
}
