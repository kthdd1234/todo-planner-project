import SwiftUI

struct TextView: View {
    let text: String
    let fontFamily: String
    let fontSize: CGFloat
    let isBold: Bool
    let textColor: Color?
    let lineThroughColor: Color?
    
    var body: some View {
        Text(text)
            .fontWeight(isBold ? .bold : .regular)
            .font(Font.custom(fontFamily, size: fontSize))
            .foregroundColor(textColor)
            .lineLimit(1)
            .strikethrough(lineThroughColor != nil, pattern: .solid, color: lineThroughColor)
    }
}