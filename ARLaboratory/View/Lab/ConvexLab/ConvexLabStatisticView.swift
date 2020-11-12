//
//  ConvexLabStatisticView.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/6/20.
//

import SwiftUI

struct ConvexLabStatisticView: View {
    @State var collaborationEnabled = false
    @State var username: String = UIDevice.current.name
    @State var statisticType: StatisticType = .recordsTable
    
    @ObservedObject var convexLabViewModel : ConvexLabViewModel
    
    static func calculateHintLabel(focus: Float, distance: Float) -> String {
        if distance < focus {
            return "<f"
        } else if focus <= distance, distance < focus * 2 * 0.95 {
            return "(f,2f)"
        } else if focus * 2 * 0.95 <= distance, distance < focus * 2 * 1.05 {
            return "~2f"
        } else if focus * 2 * 1.05 <= distance {
            return ">2f"
        } else {
            return ""
        }
    }
    
    var body: some View {
        VStack {
            Label("Statistics", systemImage: "chart.bar.xaxis")
                .font(.title)
            
            
            Picker("Statistic Type", selection: $statisticType) {
                ForEach(StatisticType.allCases) { statisticType in
                    Text(statisticType.rawValue.capitalized).tag(statisticType)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 8)
            
            VStack {
                HStack {
                    Text("No.")
                        .frame(maxWidth: .infinity)
                    Text("焦距(cm)")
                        .frame(maxWidth: .infinity)
                    Text("物距(cm)")
                        .frame(maxWidth: .infinity)
                    Text("像距(cm)")
                        .frame(maxWidth: .infinity)
                    Text("正倒")
                        .frame(maxWidth: .infinity)
                    Text("比例")
                        .frame(maxWidth: .infinity)
                    Text("虚实")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                
                Divider()
                
                ScrollView {
                    ForEach(convexLabViewModel.records) { record in
                        HStack {
                            Text("\(record.id)")
                                .font(Font.callout.bold())
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%.2f", record.focusDistance * 100))
//                                .background(Color.white)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Text("f")
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .font(Font.caption2.bold())
                                        .offset(y: 15)
                                )
                            Text(String(format: "%.2f", record.objectDistance * 100))
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Text(Self.calculateHintLabel(focus: record.focusDistance, distance: record.objectDistance))
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .font(Font.caption2.bold())
                                        .offset(y: 15)
                                )
                            Text(String(format: "%.2f", record.virtualImageBoardDistance * 100))
                                .foregroundColor(record.isInaccurateRecord ? Color.red : Color.white)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Text(Self.calculateHintLabel(focus: record.focusDistance, distance: record.virtualImageBoardDistance))
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .font(Font.caption2.bold())
                                        .offset(y: 15)
                                )
                            Text(record.virtualImageDirection.rawValue)
                                .foregroundColor(record.isInaccurateRecord ? Color.red : Color.white)
                                .frame(maxWidth: .infinity)
                            Text("\(record.virtualImageScale == .almostEqualLarge ? "几乎\n等大" : record.virtualImageScale.rawValue)")
                                .foregroundColor(record.isInaccurateRecord ? Color.red : Color.white)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity)
                            Text(record.virtualImageType.rawValue)
                                .foregroundColor(record.isInaccurateRecord ? Color.red : Color.white)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 50)
                        .font(.subheadline)
//                        .background(Color.white)
                        .overlay(
                            Divider()
                                .padding(.horizontal, 8)
//                                .background(Color.blue)
                            , alignment: .bottom
                        )
                        
                    }
                    .padding(.bottom, 12)
                }

//                List {
//                    HStack {
//                        Text("No.")
//                            .frame(maxWidth: .infinity)
//                        Text("焦距(cm)")
//                            .frame(maxWidth: .infinity)
//                        Text("物距(cm)")
//                            .frame(maxWidth: .infinity)
//                        Text("像距(cm)")
//                            .frame(maxWidth: .infinity)
//                        Text("正倒")
//                            .frame(maxWidth: .infinity)
//                        Text("比例")
//                            .frame(maxWidth: .infinity)
//                        Text("虚实")
//                            .frame(maxWidth: .infinity)
//                    }
//                    .font(.headline)
//
//                    ForEach(convexLabViewModel.records) { record in
//                        HStack {
//                            Text("\(record.id)")
//                                .frame(maxWidth: .infinity)
//                            Text(String(format: "%.2f", record.focusDistance))
//                                .frame(maxWidth: .infinity)
//                            Text(String(format: "%.2f", record.objectDistance))
//                                .frame(maxWidth: .infinity)
//                            Text(String(format: "%.2f", record.virtualImageDistance))
//                                .frame(maxWidth: .infinity)
//                            Text(record.virtualImageDirection.rawValue)
//                                .frame(maxWidth: .infinity)
//                            Text(record.virtualImageScale.rawValue)
//                                .multilineTextAlignment(.center)
//                                .frame(maxWidth: .infinity)
//                            Text(record.virtualImageType.rawValue)
//                                .frame(maxWidth: .infinity)
//                        }
//                        .font(.subheadline)
//                    }
//                }
//                .cornerRadius(50)
//                .listStyle(GroupedListStyle())
//                .onAppear() {
//                    UITableView.appearance().backgroundColor = .init(red: 0.1058823529, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
//                }
//                .onDisappear() {
//                    UITableView.appearance().backgroundColor = .systemBackground
//                }
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.1058823529, green: 0.1098039216, blue: 0.1176470588, alpha: 1)).opacity(0.5))
            .cornerRadius(50)
            .overlay(
                Text("红色数据为光屏上未得到较为清晰的像时的记录。")
                    .foregroundColor(Color.primary.opacity(0.5))
                    .font(.footnote)
                    .opacity(convexLabViewModel.records.map { $0.isInaccurateRecord} .count > 0 ? 1 : 0)
                    .animation(.easeInOut)
                , alignment: .bottom
            )
        }
        .padding()
        .foregroundColor(.primary)
        .background(
            Blur(style: .systemThinMaterial)
        )
        .cornerRadius(50)
        .frame(width: 450, height: 500)
        .environment(\.colorScheme, .dark)
    }
}

struct ConvexLabStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        ConvexLabStatisticView(convexLabViewModel: ConvexLabViewModel())
    }
}


enum StatisticType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case recordsTable = "Records Table"
    case recordsChart = "Records Chart"
}
