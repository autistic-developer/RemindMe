//
//  AddButtonView.swift
//  Clock
//
//  Created by Lalit Vinde on 01/08/23.
//

import SwiftUI

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(onTab: {
            
        })
    }
}

struct AddButtonView: View {
    
    let onTab: () -> ()
    let reminderManager:ReminderManager = ReminderManager.shared
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.managedObjectContext) private var viewContext
    
    
    let strokeStyle1:StrokeStyle = StrokeStyle(
        lineWidth: 14.w,
        miterLimit: 4.w
    )
    let strokeStyle2:StrokeStyle = StrokeStyle(
        lineWidth: 6.w,
        miterLimit: 4.w
    )
    
    var body: some View {
        addButton
            .onChange(of: scenePhase) { _, newValue in
                if newValue == .active{
                    reminderManager.setIsGrantedStatus()
                }
            }
    }
    
   
    
    private var addButton:some View{
        layer1(shape: Circle())
            .frame(width: 78.w, height: 78.w)
            .overlay{
                Button(role: nil){
                    onTab()
                }label: {
                    layer2(shape: Circle())
                        .frame(width: 60.w, height: 60.w)
                        .overlay{
                            Image("add")
                                .foregroundColor(.white)
                                .font(.system(size: 18.w))
                        }
                    
                }.buttonStyle(PressButtonStyle())
            }
    }
    
 
    private func layer1(shape: some Shape)->some View{
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    LinearGradient(
                        colors: [
                            Color(hex: 0xA6B4C8, alpha: 0.5),
                            Color(hex: 0x768FB1),
                        ],
                        startPoint: UnitPoint(x: 0.19166664896325986, y:0.23333334050658633),
                        endPoint: UnitPoint(x: 0.9999999439343832, y:1.124999978207052)
                    )
                )
            }
            .overlay{
                shape.stroke(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.8941176533699036,
                                    green: 0.9098039269447327,
                                    blue: 0.9450980424880981
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.9019607901573181,
                                    green: 0.9137254953384399,
                                    blue: 0.9372549057006836
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 4.107825191113079e-15, y:4.218847493575595e-15),
                        endPoint: UnitPoint(x: 1.0642857105938797, y:1.0785714349333164)
                    ),
                    style: strokeStyle1
                ).clipShape(shape)
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.6509804129600525,
                            green: 0.7058823704719543,
                            blue: 0.7843137383460999,
                            opacity: 0.299999988079071
                        ),
                        radius: 10.w,
                        x: 5.w,
                        y: 5.w
                    )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 1,
                            green: 1,
                            blue: 1,
                            opacity: 0.699999988079071
                        ),
                        radius: 10.w,
                        x: -5.w,
                        y: -5.w
                    )
            }
        
    }
    private func layer2(shape: some Shape)->some View{
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9952887892723083,
                                    green: 0.4488924741744995,
                                    blue: 0.3619353175163269
                                ),
                                location: 0.1510416716337204
                            ),
                            .init(
                                color: Color(
                                    red: 0.9921568632125854,
                                    green: 0.14509804546833038,
                                    blue: 0.11764705926179886
                                ),
                                location: 0.84375
                            )
                        ],
                        startPoint: UnitPoint(x: 0.9999999500931909, y:1.000000049906809),
                        endPoint: UnitPoint(x: -4.990680912975165e-08, y:4.9906808907707045e-08)
                    )
                )
            }.overlay{
                shape.stroke(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.8999999761581421,
                                    green: 0.0688636302947998,
                                    blue: 0.03750002384185791
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.9960784316062927,
                                    green: 0.4470588266849518,
                                    blue: 0.3607843220233917
                                ),
                                location: 0.96875
                            )
                        ],
                        startPoint: UnitPoint(x: 1.000000023706392, y:0.9374999839135197),
                        endPoint: UnitPoint(x: 0.034090966817513, y:0.19886364629261233)
                    ),
                    style: strokeStyle2
                ).clipShape(shape)
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.9921568632125854,
                            green: 0.14509804546833038,
                            blue: 0.11764705926179886,
                            opacity: 0.3499999940395355
                        ),
                        radius: 11.w,
                        x: 4.w,
                        y: 4.w
                    )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.6509804129600525,
                            green: 0.7058823704719543,
                            blue: 0.7843137383460999,
                            opacity: 0.10000000149011612
                        ),
                        radius: 10.w,
                        x: 5.w,
                        y: 5.w
                    )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 1,
                            green: 1,
                            blue: 1,
                            opacity: 0.4000000059604645
                        ),
                        radius: 10.w,
                        x: -5.w,
                        y: -5.w
                    )
            }
        
    }
}

struct PressButtonStyle : ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect( configuration.isPressed ? 0.95 : 1 , anchor: .center)
            .brightness(configuration.isPressed ? -0.06 : 0)
    }
    
}


