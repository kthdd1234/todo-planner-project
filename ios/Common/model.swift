import Foundation

struct HeaderModel: Hashable, Codable {
    var title: String
    var today: String
    var textRGB: [Double]
    var bgRGB: [Double]
}

struct ItemModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var mark: String
    var barRGB: [Double]
    var lineRGB: [Double]
    var markRGB: [Double]
    var highlightRGB: [Double]
}
