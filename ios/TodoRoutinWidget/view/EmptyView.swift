import WidgetKit
import SwiftUI

struct EmptyView: View {
    var widgetFamily: WidgetFamily
    var emptyText: String
    var fontFamily: String
    var widgetTheme: String
    
    var body: some View {
        VStack(){
            Spacer()
            TextView(text: emptyText, fontFamily: fontFamily, fontSize: 14, isBold: false, textColor: widgetTheme == "dark" ? .white : .gray)
            Spacer()
        }
    }
}
