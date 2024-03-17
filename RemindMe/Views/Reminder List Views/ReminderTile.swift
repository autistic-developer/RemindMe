

import SwiftUI
import EventKit

struct ReminderTile: View{
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return "Today,\n" + dateFormatter.string(from: date)
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow,\n" + dateFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday,\n" + dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "dd/MM/yyyy,\nh:mm a"
            return dateFormatter.string(from: date)
        }
    }
    private var model: EKReminder
    
    @State private var xOffset:CGFloat=0
    private let commands:[Command]=[
        .M(x:0.0,y:0.04153354632587859),
        .C(x1:0.0,y1:0.01859520766773163,x2:0.01859520766773163,y2:0.0,x:0.04153354632587859,y:0.0),
        .L(x:0.9584664536741214,y:0.0),
        .C(x1:0.981405750798722,y1:0.0,x2:1.0,y2:0.01859520766773163,x:1.0,y:0.04153354632587859),
        .L(x:1.0,y:0.17252396166134185),
        .C(x1:1.0,y1:0.1954623003194888,x2:0.981405750798722,y2:0.21405750798722045,x:0.9584664536741214,y:0.21405750798722045),
        .L(x:0.04153354632587859,y:0.21405750798722045),
        .C(x1:0.01859517571884984,y1:0.21405750798722045,x2:0.0,y2:0.1954623003194888,x:0.0,y:0.17252396166134185),
        .L(x:0.0,y:0.04153354632587859),
        .Z,
    ]
    
    private let size:CGSize=CGSize(width: 313.w, height: 67.w)
    private let shape:FigmaShape
    
    init(model: EKReminder){
        
        shape=FigmaShape(commands: commands)
        self.model=model
    }
    
    //MARK: View
    var body: some View {
           
            tile
                .overlay{
                    HStack(spacing: 20.w){
                       
                        VStack(alignment:.leading){
                            Spacer()

                            Text(model.title)
                                .font(.custom("CascadiaCodePL-Regular", size: 15.w))
                                .bold()
                                .foregroundColor(
                                    Color.black.opacity(0.8)
                                )
                            Text(model.notes ?? "")
                                .font(.custom("CascadiaCodePL-Regular", size: 15.w))
                                .foregroundColor(
                                    Color(hex: 0x677185)
                                )
                            Spacer()

                        }
                        Spacer()

                        Text(formattedDate(date: model.dueDateComponents?.date ?? .now))
                            .lineLimit(2)
                            .multilineTextAlignment(.trailing)
                            .font(.custom("CascadiaCodePL-Regular", size: 15.w))
                            .bold()
                            .foregroundColor(
                                Color(hex: 0x677185)
                            )

                        
                    }
                    .padding(.horizontal, 16.w)
                }
                .offset(x:xOffset)
                .animation(.spring(), value: xOffset)
                
        
    }
    
    //MARK: Functions
    
  
    
   
    
    //MARK: Tile Background View
    var tile :some View{
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    Color(
                        red: 0.9333333373069763,
                        green: 0.9411764740943909,
                        blue: 0.9607843160629272
                    )
                )
            }.overlay{
                shape.innerShadow(
                    color: Color(
                        red: 0.6509804129600525,
                        green: 0.7058823704719543,
                        blue: 0.7843137383460999,
                        opacity: 0.3
                    ),
                    radius: 5.w,
                    x: 3.w,
                    y: 3.w
                )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.9750000238418579,
                            green: 0.9750000238418579,
                            blue: 0.9750000238418579
                        ),
                        radius: 5.w,
                        x: 2.w,
                        y: 2.w
                    )
            }
            .frame(width: size.width, height: size.height)
        
    }
}


struct ReminderTile_Previews: PreviewProvider {
    struct Container : View{
        @Environment(\.managedObjectContext) var viewContext
        var body: some View{
            let reminder = EKReminder()
            reminder.title = "hello"
            reminder.dueDateComponents = Calendar.current.dateComponents([.year,.day,.hour,.minute], from: .now)
            return ReminderTile(model: reminder)
        }
    }
    static var previews: some View {
        Container()
    }
}
