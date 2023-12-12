//
//  ContentView.swift
//  Turtle_Mobile
//
//  Created by Mac2_iparknow on 2023/12/12.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var navigateToQ3 = false
    var body: some View {
        
        NavigationStack {
            
                VStack {
                    // 第一題
                    first()
                    Divider()
                    
                    // 第二題
                    second()
                    Divider()
                    
                    
                    Button("第三題請點這") {
                        navigateToQ3 = true
                    }
                    .navigationDestination(isPresented: $navigateToQ3) {
                        Q3().environmentObject(viewModel)
                    }
                    
                }
                .padding()
            
        }
        
        
    }
}

// MARK: -  第一題
struct first: View {
    @State var N_number : String = ""
    @State var N_Answer : String = ""
    var body: some View {
        VStack {
            Text("第一題")
            HStack{
                Text("請輸入值")
                TextField("Enter Number", text: $N_number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .onReceive(Just(N_number)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.N_number = filtered
                        }
                    }
                Button(action: {
                    if N_number.count == 0{
                        N_Answer = "0"
                    } else {
                        N_Answer = f_calculate(Int(N_number)!)
                    }
                    
                }, label: {
                    Text("Run")
                })
            }
            HStack{
                Text("Answer : ")
                Text(N_Answer)
                    .foregroundColor(Color.red)
                Spacer()
            }
        }
        .padding()
    }
}

// MARK: -  第二題
struct second: View {
    @State var get_prizes : Int = 0
    @State var prizes = [1:1, 2:1, 3:2, 4:5, 5:11]
    @State var prizeDistribution = [
            (1, 0.001),
            (2, 0.023),
            (3, 0.13),
            (4, 0.18),
            (5, 0.25)
        ]
    var body: some View {
        VStack {
            Text("第二題")
            HStack{
                
                Button(action: {
                    prizes = [1:1, 2:1, 3:2, 4:5, 5:11]
                }, label: {
                    Text("重置")
                })
                
                Button(action: {
                    let result = DrawPrize(Input_prizes: prizes, prizeDistribution: prizeDistribution)
                    
                    get_prizes = result.0!
                    prizes = result.1
                }, label: {
                    Text("抽獎")
                })
                
                Text("剩餘獎項數量 \(prizes.values.reduce(0, +))")
            }
            .padding()
            
            HStack{
                Text("恭喜抽到 \(get_prizes) 獎")
                    .foregroundColor(Color.red)
            }
        }
        .padding()
    }
}

// MARK: -  第三題
struct Q3: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showMenu : Bool = false
    @State var SearchText : String = ""
    @State private var isSearching = false
    var body: some View {
        ZStack{
            
            SlideMenu(showMenu:$showMenu)
                .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
            
            if !showMenu {
                VStack {
                    // header
                    HStack{
                        Image("Logo")
                        Spacer()
                        Button(action: {
                            showMenu.toggle()
                        }, label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(Color("#B5CC22"))
                                .padding()
                        })
                    }
                    Divider()
                    
                    // content
                    HStack{
                        Text("站點資訊")
                            .foregroundColor(Color("#B5CC22"))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding()
                        
                        Spacer()
                    }
                    HStack{
            
                        TextField("搜尋站點" ,text: $SearchText, onEditingChanged: { isEditing in
                            isSearching = isEditing
                        })
                        .font(.system(size:16))
                        .foregroundColor(.gray)
                        .padding()
                        
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.black)
                            .padding()
                    }
                    .frame(width: 311, height:40)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .onAppear {
                        viewModel.Get_YouBikeData()
                    }
                    
                    // 下拉列表
                    VStack{
                        if isSearching {
                            List {
                                ForEach(filteredData, id: \.sno) { item in
                                    Text(item.sarea)
                                        .onTapGesture {
                                            SearchText = item.sarea
                                            isSearching = false
                                        }
                                }
                            }
                        }
                    }
                    
                    
                    // data list
                    TableView(SearchText:$SearchText)
                        .frame(width: 311)
                        .padding(.top,10)
                    
                }
                .padding()
            }
            
            
        }
        .navigationBarHidden(true)
        
    }
    
    var filteredData: [Model_YouBike] {
        if SearchText.isEmpty {
            return []
        } else {
            var uniqueAreas = Set<String>()
            return viewModel.youBikeData.filter { item in
                let isUnique = !uniqueAreas.contains(item.sarea)
                if isUnique {
                    uniqueAreas.insert(item.sarea)
                }
                return isUnique && item.sarea.localizedCaseInsensitiveContains(SearchText)
            }
        }
    }
    
}

struct SlideMenu: View {
    @Binding var showMenu : Bool
    @State var MenuArray = ["使用說明", "收費方式", "站點資訊", "最新消息", "活動專區"]
    var body: some View {

        VStack{
            HStack{
                Image("Logo").padding()
                Spacer()
                
                Button(action: {
                    showMenu.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("#B5CC22"))
                        .padding()
                })
            }
            .background(Color.white)
            .padding(.top,20)
            
            ForEach(MenuArray, id: \.self){ item in
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text(item)
                            .font(.system(size: 18))
                            .foregroundColor(Color.white)
                    })
                    Spacer()
                    
                }.padding()
                
            }
            Spacer()
            
            HStack{
                Button(action: {
                }, label: {
                    Text("登入")
                        .padding()
                        .frame(width: 81, height: 40)
                        .foregroundColor(Color("#B5CC22"))
                        .background(Color.white)
                        .cornerRadius(24)
                })
                Spacer()
            }
            .padding()
            .padding(.bottom,20)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("#B5CC22"))
        
        Spacer()
        
    }
}


struct TableView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var SearchText : String
    var body: some View {

        VStack(spacing: 0) {
            HStack {
                Text("縣市")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                Text("區域")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                Text("站點名稱")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
            }
            .frame(width: 311, height: 66)
            .background(Color("#B5CC22"))
            .clipShape(CustomCorners(radius: 8, corners: [.topLeft, .topRight]))
            
            ScrollView{
                ScrollViewReader { scrollViewProxy in
                    LazyVStack(spacing: 0){
                        ForEach(Array(filteredData.enumerated()), id: \.element.self) { index, data in
                            HStack {
                                Text("臺北市").frame(maxWidth: .infinity)
                                Text(data.sarea).frame(maxWidth: .infinity)
                                Text(data.sna).frame(maxWidth: .infinity)
                            }
                            .background(index % 2 == 0 ? Color.gray.opacity(0.1) : Color.clear)
                        }
                    }
                }
                
            }
        }
        
    }
    
    var filteredData: [Model_YouBike] {
        if SearchText.isEmpty {
            return viewModel.youBikeData
        } else {
            return viewModel.youBikeData.filter { data in
                data.sarea.localizedCaseInsensitiveContains(SearchText)
            }
        }
    }
}
