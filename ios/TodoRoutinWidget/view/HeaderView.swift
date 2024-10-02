import WidgetKit
import SwiftUI

struct HeaderView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let header: HeaderModel
    let widgetTheme: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            TagView(widgetFamily: widgetFamily, fontFamily: fontFamily, header: header, widgetTheme: widgetTheme)
            Spacer()
            if(isWidgetML(widgetFamily: widgetFamily)) {
                TextView(text: header.today,
                         fontFamily: fontFamily,
                         fontSize: 11,
                         isBold: true,
                         textColor: widgetTheme == "dark"  ? .white : .gray,
                         lineThroughColor: nil)
            }
            
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 7, trailing: 0))
    }
}
