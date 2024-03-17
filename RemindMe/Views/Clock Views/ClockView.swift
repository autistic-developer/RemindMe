//
//  ClockView.swift
//  Clock
//
//  Created by Lalit Vinde on 26/07/23.
//

import SwiftUI

struct ClockView: View {
    
    //MARK: View
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1))
        { context in
            let components:DateComponents=Calendar.current.dateComponents([.second, .minute, .hour], from: context.date)
            
            ZStack{
                HourHandView()
                    .offset(x:9.w)
                    .rotationEffect(computeHoursAngle(hr: components.hour,min: components.minute ))
                Circle().fill(Color(hex: 0x646E82)).frame(width: 10.w, height: 10.w)
                MinuteHandView()
                    .offset(x:15.w)
                    .rotationEffect(computeMinutesAngle(min: components.minute))
                SecondHandView(angle:computeSecondsAngle(sec: components.second)).offset(x:17.5.w)
            }
            .frame(width: 203.w, height: 203.w)
            .background{
                ClockInnerCircleView().frame(width: 176.w, height: 176.w)

            }.background{
                ClockOuterCircleView()

            }
            

        }
    }
    
    //MARK: Functions
    /// compute minutes hand angle based on currenct minute
    /// - Parameter min: pass the current minute
    /// - Returns: compted angle
    private func computeMinutesAngle(min:Int?) -> Angle{
        return Angle(degrees: 6*Double(min!)-90)
    }
    
    /// compute seconds hand angle based on currenct hour & minute
    /// - Parameter hr: pass the currect hour
    /// - Parameter min: pass the current minute
    /// - Returns: compted angle
    private func computeHoursAngle(hr:Int?, min:Int?) -> Angle {
        return Angle(degrees: Double(30*hr!)+0.5*Double(min!)-90)
    }
    
    /// compute seconds hand angle based on currenct second
    /// - Parameter sec: pass the currect second
    /// - Returns: compted angle
    private func computeSecondsAngle(sec:Int?) -> Angle {
        return Angle(degrees: 6*Double(sec!)-90)
    }
    
}

//MARK: Clock Inner View
struct ClockInnerCircleView: View {
    let shape=Circle()
    var body: some View {
        shape
            .fill(
                LinearGradient(
                    stops:[
                        .init(
                            color: Color(
                                red: 0.9254902005195618,
                                green: 0.9333333373069763,
                                blue: 0.9529411792755127
                            ),
                            location: 0
                        ),
                        .init(
                            color: Color(
                                red: 0.9450980424880981,
                                green: 0.9490196108818054,
                                blue: 0.9686274528503418
                            ),
                            location: 1
                        )
                    ],
                    startPoint: UnitPoint(x: 0.5000000003192715, y:-1.8343574897862964e-14),
                    endPoint: UnitPoint(x: 0.5000000003192698, y:-1.0000000000000184)
                )
            ).overlay{
                shape.innerShadow(
                    color: Color(
                        red: 1,
                        green: 1,
                        blue: 1,
                        opacity: 0.20000000298023224
                    ),
                    radius: 30.w,
                    x: -12.w,
                    y: -12.w
                )
            }.overlay{
                shape.innerShadow(
                    color: Color(
                        red: 0.6509804129600525,
                        green: 0.7058823704719543,
                        blue: 0.7843137383460999,
                        opacity: 0.5199999809265137
                    ),
                    radius: 8.w,
                    x: 7.w,
                    y: 7.w
                )
            }
            .overlay{
                shape.strokeBorder(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9960286617279053,
                                    green: 0.9960286617279053,
                                    blue: 1
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.6484721899032593,
                                    green: 0.6957499384880066,
                                    blue: 0.7666666507720947
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 0.7578125058501057, y:-0.30468753187659114),
                        endPoint: UnitPoint(x: 0.14062499031445647, y:-0.9062500199623453)
                    ),
                    lineWidth: 1.w
                )
            }
    }
}


//MARK: Clock Outer View
struct ClockOuterCircleView: View {
    let commands:[Command]=[
        .M(x:0.0,y:0.5),
        .C(x1:0.0,y1:0.2238576354679803,x2:0.2238576354679803,y2:0.0,x:0.5,y:0.0),
        .L(x:0.5,y:0.0),
        .C(x1:0.7761428571428571,y1:0.0,x2:1.0,y2:0.2238576354679803,x:1.0,y:0.5),
        .L(x:1.0,y:0.5),
        .C(x1:1.0,y1:0.7761428571428571,x2:0.7761428571428571,y2:1.0,x:0.5,y:1.0),
        .L(x:0.5,y:1.0),
        .C(x1:0.2238576354679803,y1:1.0,x2:0.0,y2:0.7761428571428571,x:0.0,y:0.5),
        .L(x:0.0,y:0.5),
        .Z,
    ]
    
    let shape:FigmaShape
    
    init(){
        shape=FigmaShape(commands: commands)
    }
    
    var body: some View {
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9019607901573181,
                                    green: 0.9137254953384399,
                                    blue: 0.9372549057006836
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.9019607901573181,
                                    green: 0.9137254953384399,
                                    blue: 0.9372549057006836
                                ),
                                location: 9.999999747378752e-05
                            ),
                            .init(
                                color: Color(
                                    red: 0.9333333373069763,
                                    green: 0.9411764740943909,
                                    blue: 0.9607843160629272
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 0.03809524621856747, y:0.061904767782780035),
                        endPoint: UnitPoint(x: 0.9500000255191681, y:0.9476190565607581)
                    )
                )
            }.overlay{
                shape.stroke(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 1,
                                    green: 1,
                                    blue: 1
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.729411780834198,
                                    green: 0.7647058963775635,
                                    blue: 0.8117647171020508
                                ),
                                location: 0.852473258972168
                            )
                        ],
                        startPoint: UnitPoint(x: 0.22727277107193827, y:0.2177033299208149),
                        endPoint: UnitPoint(x: 0.9595238886868649, y:0.9714285078279778)
                    ),
                    lineWidth: 1.w
                )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.6509804129600525,
                            green: 0.7058823704719543,
                            blue: 0.7843137383460999,
                            opacity: 0.2599999928474426
                        ),
                        radius: 12.w,
                        x: 13.w,
                        y: 14.w
                    )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 1,
                            green: 1,
                            blue: 1,
                            opacity: 0.5299999713897705
                        ),
                        radius: 61.w,
                        x: -20.w,
                        y: -20.w
                    )
            }
            
    }
}


struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(hex: 0xEEF0F5).ignoresSafeArea()
            ClockView()
        }
        
    }
}

