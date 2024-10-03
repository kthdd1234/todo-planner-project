import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TodoRoutinEntry {
        TodoRoutinEntry(date: Date(), header: "", taskList: "", fontFamily: "", emptyText: "", widgetTheme: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (TodoRoutinEntry) -> ()) {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        
        let header = data?.string(forKey: "header") ?? ""
        let taskList = data?.string(forKey: "taskList") ?? ""
        let fontFamily = data?.string(forKey: "fontFamily") ?? "IM_Hyemin"
        let emptyText = data?.string(forKey: "emptyText") ?? "추가된 할 일이 없어요."
        let widgetTheme = data?.string(forKey: "widgetTheme") ?? "light"
        
        let entry = TodoRoutinEntry(date: Date(), header: header, taskList: taskList, fontFamily: fontFamily, emptyText: emptyText, widgetTheme: widgetTheme)
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct TodoRoutinEntry: TimelineEntry {
    let date: Date
    let header: String
    let taskList: String
    let fontFamily: String
    let emptyText: String
    let widgetTheme: String
}

struct TodoRoutinWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var eWidgetFamily
    @State var headerState: HeaderModel
    @State var itemListState: [ItemModel]
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.headerState = entry.header != "" ? loadJson(json: entry.header) : 
        HeaderModel(title: "오늘의 할 일 0", today: "날짜 없음", textRGB: [0, 0, 0], bgRGB: [255, 255, 255])
        self.itemListState = entry.taskList != "" ? loadJson(json: entry.taskList) : []
        
        cutomFont(fontFamily: "IM_Hyemin")
    }

    var body: some View {
        VStack {
            if eWidgetFamily == .systemExtraLarge {
                PadView(widgetFamily: eWidgetFamily, fontFamily: entry.fontFamily, header: headerState, widgetTheme: entry.widgetTheme,  emptyText: entry.emptyText,itemList: itemListState)
            } else {
                PhoneView(widgetFamily: eWidgetFamily, headerState: headerState, fontFamily: entry.fontFamily, emptyText: entry.emptyText, widgetTheme: entry.widgetTheme, itemList: itemListState)
            }
        }
        .widgetURL(URL(string: "todoRoutin://message?message=task&homeWidget"))
        .containerBackground(for: .widget) {
            bgColor(theme: entry.widgetTheme)
        }
    }
}

struct TodoRoutinWidget: Widget {
    let kind: String = "TodoRoutinWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoRoutinWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("할 일, 루틴")
        .description("오늘의 할 일을 보여주는 위젯입니다.")
    }
}

#Preview(as: .systemMedium) {
    TodoRoutinWidget()
} timeline: {
    TodoRoutinEntry(date: .now, header: "", taskList: "", fontFamily: "", emptyText: "", widgetTheme: "")
}




//        HeaderView(widgetFamily: eWidgetFamily, fontFamily:entry.fontFamily, header: headerState, widgetTheme: entry.widgetTheme)
//        Color.clear
//            .overlay(
//                        LazyVStack {
//                            TextView(text: "1", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "2", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "3", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "4", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "5", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "6", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "7", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "8", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "9", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "10", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                            TextView(text: "11", fontFamily: "IM_Hyemin", fontSize: 14, isBold: false, textColor: .red)
//                        },
//                        alignment: .top)
