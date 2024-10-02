import WidgetKit
import SwiftUI

struct PhoneView: View {
    var widgetFamily: WidgetFamily
    var headerState: HeaderModel
    var fontFamily: String
    var emptyText: String
    var widgetTheme: String
    var itemList: [ItemModel]
    
    var body: some View {
        VStack {
           HeaderView(widgetFamily: widgetFamily, fontFamily: fontFamily, header: headerState, widgetTheme: widgetTheme)
           ListView(widgetFamily: widgetFamily,emptyText: emptyText != "" ? emptyText : "추가된 할 일이 없어요." , fontFamily: fontFamily, itemList: itemList, widgetTheme: widgetTheme)
       }
    }
}
