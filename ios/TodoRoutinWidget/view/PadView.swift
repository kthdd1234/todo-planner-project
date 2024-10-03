import WidgetKit
import SwiftUI

struct PadView: View {
    let widgetFamily: WidgetFamily
    let fontFamily: String
    let header: HeaderModel
    let widgetTheme: String
    let emptyText: String
    let itemList: [ItemModel]
    
    var body: some View {
        if itemList.isEmpty {
            EmptyView(widgetFamily: widgetFamily, emptyText: emptyText, fontFamily: fontFamily, widgetTheme: widgetTheme)
        } else {
            VStack {
                HeaderView(widgetFamily: widgetFamily, fontFamily: fontFamily, header: header, widgetTheme: widgetTheme)
                HStack(alignment: .top) {
                    VStack{
                        ForEach(prefixList(widgetFamily: widgetFamily, list: itemList)) { item in
                            ItemView(fontFamily: fontFamily, widgetTheme: widgetTheme, item: item).padding(.vertical, 2.5)
                        }
                    }.padding(.trailing, itemList.count > 9 ? 5 : 0)
                    if itemList.count > 9 {
                        Spacer()
                        VStack() {
                            ForEach(itemList[9...].prefix(9)) { item in
                                ItemView(fontFamily: fontFamily, widgetTheme: widgetTheme, item: item).padding(.vertical, 2.5)
                            }
                        }.padding(.leading, 5)
                    }
          
                }
                Spacer()
            }
            
        }
    }
}
