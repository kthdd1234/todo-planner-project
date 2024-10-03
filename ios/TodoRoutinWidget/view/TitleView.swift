import WidgetKit
import SwiftUI

struct TitleView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let header: HeaderModel
    let widgetTheme: String
    
    var body: some View {
        TextView(text: header.title,
                     fontFamily: fontFamily,
                     fontSize: 15,
                     isBold: true,
                     textColor: widgetTheme == "dark" ? .white : .black)
    }
}
