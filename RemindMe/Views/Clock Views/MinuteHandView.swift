//
//  MinuteHandView.swift
//  Clock
//
//  Created by Lalit Vinde on 26/07/23.
//

import SwiftUI

struct MinuteHandView: View {
    let commands:[Command]=[
        .M(x:0.0,y:0.02027027027027027),
        .C(x1:0.0,y1:0.00907531081081081,x2:0.00907531081081081,y2:0.0,x:0.02027027027027027,y:0.0),
        .L(x:0.9797297297297297,y:0.0),
        .C(x1:0.9909243243243243,y1:0.0,x2:1.0,y2:0.00907531081081081,x:1.0,y:0.02027027027027027),
        .L(x:1.0,y:0.02027027027027027),
        .C(x1:1.0,y1:0.03146527027027027,x2:0.9909243243243243,y2:0.04054054054054054,x:0.9797297297297297,y:0.04054054054054054),
        .L(x:0.02027027027027027,y:0.04054054054054054),
        .C(x1:0.009075324324324324,y1:0.04054054054054054,x2:0.0,y2:0.03146527027027027,x:0.0,y:0.02027027027027027),
        .L(x:0.0,y:0.02027027027027027),
        .Z,
    ]

    let size:CGSize=CGSize(width: 74.w, height: 3.w)
    let shape:FigmaShape
    let path:Path
    
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

struct MinuteHandView_Previews: PreviewProvider {
    static var previews: some View {
        MinuteHandView()
            .padding()
            .previewLayout(.sizeThatFits)
            
    }
}

