import Foundation

public enum LogPrintType: String {
    case error = "🟥"
    case warning = "🟧"
    case success = "🟩"
    case action = "⚡️"
    case canceled = "📵"
    
    var print: String {
        return self.rawValue
    }
}

public func logPrint(_ printType: LogPrintType, _ text: String) {
    debugPrint("[\(printTimestamp()) \(printType.print)]: \(text)")
}

private func printTimestamp() -> String {
    let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
    return timestamp
}
  

