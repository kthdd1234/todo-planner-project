import WidgetKit
import SwiftUI

struct TitleView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let widgetTheme: String
    let count: Int
    
    var body: some View {
        TextView(text: "오늘의 할 일 \(count)",
                     fontFamily: fontFamily,
                     fontSize: 15,
                     isBold: true,
                     textColor: widgetTheme == "dark" ? .white : .black,
                     lineThroughColor: nil)
    }
}
