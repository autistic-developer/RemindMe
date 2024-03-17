//
//  HourHandView.swift
//  Clock
//
//  Created by Lalit Vinde on 26/07/23.
//

import SwiftUI

struct HourHandView: View {
    let commands:[Command]=[
        .M(x:0.0,y:0.03),
        .C(x1:0.0,y1:0.01343146,x2:0.01343146,y2:0.0,x:0.03,y:0.0),
        .L(x:0.97,y:0.0),
        .C(x1:0.986568,y1:0.0,x2:1.0,y2:0.01343146,x:1.0,y:0.03),
        .L(x:1.0,y:0.03),
        .C(x1:1.0,y1:0.0465686,x2:0.986568,y2:0.06,x:0.97,y:0.06),
        .L(x:0.03,y:0.06),
        .C(x1:0.013431420000000001,y1:0.06,x2:0.0,y2:0.0465686,x:0.0,y:0.03),
        .L(x:0.0,y:0.03),
        .Z,
    ]
    
    let size:CGSize=CGSize(width: 50.w, height: 3.w)
    let shape:FigmaShape
    let path:Path
    let strokeStyle:StrokeStyle = StrokeStyle(
                                              miterLimit: 4.w
    )
    init(){
        shape=FigmaShape(commands: commands)
        path=shape.path(in: CGRect(origin: .zero, size: size))
    }
    
    var body: some View {
        shape
            .fill(.clear)
            .overlay(
                shape.fill(
                    Color(
                        red: 0.39395833015441895,
                        green: 0.4320833384990692,
                        blue: 0.5083333253860474
                    )
                )
            )
            .frame(width: size.width, height: size.height)
    }
}
struct HourHandView_Previews: PreviewProvider {
    static var previews: some View {
        HourHandView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
