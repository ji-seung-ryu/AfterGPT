/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailEditView: View {
    @Binding var conversation: Conversation
    @State private var selectedDate: Date

       init(conversation: Binding<Conversation>) {
           self._conversation = conversation
           // 초기화 시 selectedDate를 conversation.date로 설정
           self._selectedDate = State(initialValue: conversation.wrappedValue.date)
       }

    var body: some View {
        Form {
            Section(header: Text("대화 정보")) {
                TextField("Title", text: $conversation.title)
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .onChange(of: selectedDate, perform: { value in
                                        conversation.date = selectedDate
                                    })
                ThemePicker(selection: $conversation.theme)
            }
            
            
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(conversation: .constant(Conversation.sampleData[0]))
    }
}
