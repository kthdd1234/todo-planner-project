import Foundation

struct HeaderModel: Hashable, Codable {
    var title: String
    var textRGB: [Int]
    var bgRGB: [Int]
}

struct TaskModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var mark: String
    var lineRGB: [Int]
    var markRGB: [Int]
    var highlightRGB: [Int]
}
