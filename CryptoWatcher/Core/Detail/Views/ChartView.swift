//
//  ChartView.swift
//  CryptoWatcher
//
//  Created by Homit Dalia on 19/04/24.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    
    @State private var shownPercentage: CGFloat = 0
    
    init(coin: CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        lineColor = ((data.last ?? 0) - (data.first ?? 0)) > 0 ? Color.theme.green : Color.theme.red
    }
    
    var body: some View {
        VStack {
            GeometryReader(content: { geometry in
                Path { path in
                    for index in data.indices {
                        let xPosition = UIScreen.main.bounds.width / CGFloat(data.count) *  CGFloat(index + 1)
                        
                        let yAxis = maxY - minY
                        let yPosition = (1 - CGFloat((data[index] - minY)) / yAxis) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x:xPosition, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        
                    }
                }
                .trim(from: 0, to: shownPercentage)
                .stroke(lineColor,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            lineJoin: .round))
                
            })
            .frame(height: 200)
            .background(
                VStack {
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                }
            )
            .overlay(alignment: .leading) {
                VStack{
                    Text(maxY.formattedWithAbbreviations())
                    Spacer()
                    Text(((maxY + minY) / 2).formattedWithAbbreviations())
                    Spacer()
                    Text(minY.formattedWithAbbreviations())
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
                withAnimation(.linear(duration: 2.0)) {
                    shownPercentage = 1.0
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}
