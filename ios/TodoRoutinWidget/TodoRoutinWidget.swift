import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TodoRoutinEntry {
        TodoRoutinEntry(date: Date(), header: "", taskList: "", fontFamily: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (TodoRoutinEntry) -> ()) {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        let header = data?.string(forKey: "header") ?? ""
        let taskList = data?.string(forKey: "taskList") ?? ""
        let fontFamily = data?.string(forKey: "fontFamily") ?? ""
        
        let entry = TodoRoutinEntry(date: Date(), header: header, taskList: taskList, fontFamily: fontFamily)
        
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
}

struct TodoRoutinWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var eWidgetFamily
//    @State var headerState: HeaderModel
//    @State var taskListState: [TaskModel]
    
    init(entry: Provider.Entry) {
        self.entry = entry
//        self.headerState = loadJson(json: entry.header)
//        self.taskListState = loadJson(json: entry.taskList)
        
        cutomFont(fontFamily: entry.fontFamily)
    }

    var body: some View {
        VStack {
            HeaderView(widgetFamily: eWidgetFamily, fontFamily: "", title: "할 일, 루틴 리스트", today: "6월 24일 (월)")
            Spacer()
        }
        .widgetURL(URL(string: "todoRoutin://message?message=task&homeWidget"))
        .containerBackground(for: .widget) {
//            .background(widgetBgColor)
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
        .description("오늘의 할 일과 루틴을 보여주는 위젯입니다.")
    }
}

#Preview(as: .systemSmall) {
    TodoRoutinWidget()
} timeline: {
    TodoRoutinEntry(date: .now, header: "", taskList: "", fontFamily: "")
}
