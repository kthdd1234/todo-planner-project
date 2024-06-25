import WidgetKit
import SwiftUI

struct ListView: View {
    var widgetFamily: WidgetFamily
    var emptyText: String
    var fontFamily: String
    var itemList: [ItemModel]
    
    var body: some View {
        if itemList.isEmpty {
                Spacer()
                TextView(text: emptyText, fontFamily: fontFamily, fontSize: 14, isBold: false, textColor: .gray, isLineThrough: nil, lineThroughColor: nil)
                Spacer()
        } else {
            ForEach(prefixList(widgetFamily: widgetFamily, list: itemList)) { item in
                ItemView(fontFamily: fontFamily, item: item).padding(.bottom, 5)
            }
            Spacer()
        }
    }
}

struct ItemView: View {
    var fontFamily: String
    var item: ItemModel
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color(rgb: item.barRGB))
                .frame(width: 5, height: 14)
                .cornerRadius(2)
            TextView(text: item.name, fontFamily: fontFamily, fontSize: 14, isBold: false, textColor: .black, isLineThrough: item.mark != "E", lineThroughColor: item.mark != "E" ? color(rgb: item.lineRGB) : nil)
            Spacer()
            Image("mark-\(item.mark)")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color(rgb: item.lineRGB))
                .frame(width: 15, height: 15)
        }
    }
}

