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
                Spacer()
            TextView(text: emptyText, fontFamily: fontFamily, fontSize: 14, isBold: false, textColor: widgetTheme == "dark" ? .white : .gray, lineThroughColor: nil)
                Spacer()
        } else {
            ForEach(prefixList(widgetFamily: widgetFamily, list: itemList)) { item in
                ItemView(fontFamily: fontFamily, widgetTheme: widgetTheme, item: item).padding(.bottom, 5)
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
            TextView(text: item.name, fontFamily: fontFamily, fontSize: 14, isBold: widgetTheme == "dark", textColor: widgetTheme == "dark" ? .white : .black, lineThroughColor: item.mark != "E" ? color(rgb: item.lineRGB) : nil)
                .padding(item.highlightRGB != nil ? EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3) : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(color(rgb: item.highlightRGB))
                .cornerRadius(5)
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

