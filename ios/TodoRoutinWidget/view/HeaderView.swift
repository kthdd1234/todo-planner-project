import WidgetKit
import SwiftUI

struct HeaderView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let title: String
    let today: String
    
    var body: some View {
        HStack{
            TextView(text: title,
                     fontFamily: fontFamily,
                     isBold: true,
                     textColor: nil,
                     isLineThrough: nil,
                     lineThroughColor: nil)
            Spacer()
            if(isWidgetML(widgetFamily: widgetFamily)) {
                TextView(text: today,
                         fontFamily: fontFamily,
                         isBold: true,
                         textColor: .gray,
                         isLineThrough: nil,
                         lineThroughColor: nil)
            }
            
        }
    }
}

#Preview {
    HeaderView(widgetFamily: .systemSmall, fontFamily: "", title: "", today: "")
}
