import WidgetKit
import SwiftUI

struct ListView: View {
    var widgetFamily: WidgetFamily
    var emptyText: String
    var fontFamily: String
    var itemList: [ItemModel]
    var widgetTheme: String
    
    var body: some View {
        if itemList.isEmpty {
            EmptyView(widgetFamily: widgetFamily, emptyText: emptyText, fontFamily: fontFamily, widgetTheme: widgetTheme)
        } else {
            ForEach(prefixList(widgetFamily: widgetFamily, list: itemList)) { item in
                ItemView(fontFamily: fontFamily, widgetTheme: widgetTheme, item: item).padding(.vertical, 2.5)
            }
            Spacer()
        }
    }
}

struct ItemView: View {
    var fontFamily: String
    var widgetTheme: String
    var item: ItemModel
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color(rgb: item.barRGB)!)
                .frame(width: 5, height: 16)
                .cornerRadius(2)
            TextView(text: item.name, fontFamily: fontFamily, fontSize: 14, isBold: widgetTheme == "dark", textColor: widgetTheme == "dark" ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, item.highlightRGB != nil ? 3 : 0)
                .background(color(rgb: item.highlightRGB))
                .cornerRadius(2.5)
            Spacer()
            Image("mark-\(item.mark)")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color(rgb: item.lineRGB))
                .frame(width: 15, height: 15)
                .padding(.leading, 5)
        }
    }
}

