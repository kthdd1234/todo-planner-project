import WidgetKit
import SwiftUI

struct TagView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let header: HeaderModel
    let widgetTheme: String
    
    var body: some View {
        TextView(text: header.title,
                 fontFamily: fontFamily,
                 fontSize: 13,
                 isBold: widgetTheme == "dark",
                 textColor: color(rgb: header.textRGB),
                 lineThroughColor: nil)
        .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
        .background(color(rgb: header.bgRGB))
        .cornerRadius(5)
    }
}
