import SwiftUI

struct TextView: View {
    let text: String
    let fontFamily: String
    let isBold: Bool
    let textColor: Color?
    let isLineThrough: Bool?
    let lineThroughColor: Color?
    
    var body: some View {
        Text(text)
            .fontWeight(isBold ? .bold : .regular)
            .font(Font.custom(fontFamily, size: isBold ? 15 : 13))
            .foregroundColor(textColor)
            .lineLimit(1)
            .strikethrough(isLineThrough == true, pattern: .solid, color: lineThroughColor)
        
    }
}

