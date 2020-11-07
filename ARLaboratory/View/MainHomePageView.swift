//
//  MainHomePageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/3.
//

import SwiftUI


struct MainHomePageView: View {
    @State private var tabSelection = 2
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        let biggerAvatar: Bool = (tabSelection == 3 ? true : false)
        ZStack {
            VStack {
                HStack {
                    if biggerAvatar
                    {Spacer()}
                    Image("avatar").resizable().frame(width: biggerAvatar ? 150 : 40, height: biggerAvatar ? 150 : 40).overlay(RoundedRectangle(cornerRadius: biggerAvatar ? 150 : 40).stroke(Color(#colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.9843137255, alpha: 1)),lineWidth: 1)).onTapGesture(perform: {withAnimation(.easeInOut,{tabSelection = 3})})
                    Spacer()
                }
                Spacer()
            }.ignoresSafeArea().padding(.horizontal, 53).padding(.vertical, biggerAvatar ? 112 : 30 ) .zIndex(1.0)
            
            VStack {
                Image("mainBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.01)
                Spacer()
            }.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HomepageHeaderView(tabSelection: $tabSelection)
                TopRoundedRectangleView()
                    .overlay(
                        ZStack{
                            if tabSelection == 1
                            {
                                ScrollView{StoreMainPage()}.ignoresSafeArea().onAppear(perform: {print("storeMainPage Appeared")})
                                
                            }
                            if tabSelection == 2
                            {
                                ScrollView{MainHomepageContentView()}.ignoresSafeArea().onAppear(perform: {print("mainHomePage Appeared")})
                                
                            }
                            if tabSelection == 3
                            {
                                ScrollView{AccountPageView()}.padding(.vertical, 59).ignoresSafeArea().onAppear(perform: {print("accountPage Appeared")})
                            }
                            
                        }.padding(.vertical,20)
                        
                        
                        
                        //                        TabView(selection: $tabSelection,content:{
                        //                            ScrollView{
                        //                                StoreMainPage()
                        //                            }.ignoresSafeArea().tag(1)
                        //                            ScrollView {
                        //                                MainHomepageContentView()
                        //                            }.ignoresSafeArea().tag(2)
                        //                            AccountPageView().padding(.vertical, 59).ignoresSafeArea().tag(3)
                        //                        }).offset(y: 20)
                    )
                //                    .tabViewStyle(PageTabViewStyle())
                
            }
            
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 35)
                    .frame(width: 310, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(#colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 0.11)), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color(#colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)), radius: 20, x: 0, y: 10)
                    .overlay( HStack {
                        Button(action: {                                withAnimation(.easeOut, {tabSelection=1})
                        }) {
                            Rectangle()
                                .frame(width: 31, height: 31, alignment: .center)
                                .foregroundColor(tabSelection == 1 ? Color(#colorLiteral(red: 0.5647058824, green: 0.3960784314, blue: 0.8666666667, alpha: 1)) : Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)) )
                                .mask(Image("StorePage").resizable().frame(width: 31, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                        }.buttonStyle(ResponsiveButtonStyle())
                        
                        
                        Spacer()
                        Button(action: {                                withAnimation(.easeOut, {tabSelection=2})
                        }) {
                            Rectangle()
                                .frame(width: 31, height: 31, alignment: .center)
                                .foregroundColor(tabSelection == 2 ? Color(#colorLiteral(red: 0.5647058824, green: 0.3960784314, blue: 0.8666666667, alpha: 1)) : Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)) )
                                .mask(Image("HomePage").resizable().frame(width: 31, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                        }.buttonStyle(ResponsiveButtonStyle())
                        Spacer()
                        Button(action: {
                            withAnimation(.easeOut, {tabSelection=3})
                        }) {
                            Rectangle()
                                .frame(width: 31, height: 31, alignment: .center)
                                .foregroundColor(tabSelection == 3 ? Color(#colorLiteral(red: 0.5647058824, green: 0.3960784314, blue: 0.8666666667, alpha: 1)) : Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)) )
                                .mask(Image("AccountPage").resizable().frame(width: 31, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                        }.buttonStyle(ResponsiveButtonStyle())
                    }.padding(.horizontal,45)
                    ).padding(.vertical,20)
            }
            
            
        }.background(Color.white).onAppear(perform: {
            tabSelection = viewModel.selection
        }).onDisappear(perform: {
            viewModel.selection = tabSelection
        })
    }
    
    struct MainHomePageView_Previews: PreviewProvider {
        static var previews: some View {
            MainHomePageView()
        }
    }
    
    
}

