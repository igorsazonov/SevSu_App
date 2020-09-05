//
//  ContentView.swift
//  customSevsu
//
//  Created by Игорь Сазонов on 05.09.2020.
//  Copyright © 2020 Игорь Сазонов. All rights reserved.
//

import SwiftUI

//MARK: - WeekdayEnum


enum weekdayEnum: String {
    case monday, wednesday, friday // есть пары
    case tuesday, thursday // нет пар
    
    var weekday: String { // день недели
        switch self {
        case .monday: return "Пн"
        case .tuesday: return "Вт"
        case .wednesday: return "Ср"
        case .thursday: return "Чт"
        case .friday: return "Пт"
        }
    }
    
    var oddWeek: AnyView { // нечетная неделя
        
        switch self {
        case .monday:
            return AnyView(Text("Понедельник Нечетная"))
        case .tuesday:
            return AnyView(noСlassesView(noClassesimage: "noClasses_1"))
        case .wednesday:
            return AnyView(Text("Среда Нечетная"))
        case .thursday:
            return AnyView(noСlassesView(noClassesimage: "noClasses_2"))
        case .friday:
            return AnyView(Text("Пятница Нечетная"))
        }
        
    }
    
    var evenWeek: AnyView { // четная неделя
        
        switch self {
        case .monday:
            return AnyView(Text("Четная Понедельник"))
        case .tuesday:
            return AnyView(noСlassesView(noClassesimage: "noClasses_2"))
        case .wednesday:
            return AnyView(Text("Четная Среда"))
        case .thursday:
            return AnyView(noСlassesView(noClassesimage: "noClasses_1"))
        case .friday:
            return AnyView(Text("Четная Пятница"))
        }
    }
}

//MARK: - TypeWeek

let typeWeek = ["Нечетная","Четная"]
let imageName = ["noClasses_1","noClasses_2"]

//MARK: - HomeView


struct ContentView: View {
    var body: some View {
       Home()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State private var selectedWeekday: weekdayEnum = .monday
    @State private var selectedTypeWeekday = "Нечетная"
    
    let buttonsWeekday: [weekdayEnum] = [.monday, .tuesday, .wednesday, .thursday, .friday]
    
    func outputView(selected: String) -> AnyView {
        if selected == "Нечетная" {
            return AnyView(selectedWeekday.oddWeek)
        } else {
            return AnyView(selectedWeekday.evenWeek)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("СевГУ расписание")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                })
                } // шапка
            .padding()
            .padding(.horizontal, 10)
            
            HStack(spacing: 0) {
                ForEach(typeWeek, id: \.self) { title in
                    typeWeekButton(title: title, selected: self.$selectedTypeWeekday)
                }
            }
                .padding(.top, 10)// тип недели
            
            HStack(spacing: 0) {
                ForEach(buttonsWeekday, id: \.self) { button in
                    Button(action: {
                        self.selectedWeekday = button
                    }) {
                        Text(button.weekday)
                            .font(.system(size: 15))
                            .fontWeight(self.selectedWeekday.weekday == button.weekday ? .bold : .none)
                            .foregroundColor(self.selectedWeekday.weekday == button.weekday ? .white : Color.white.opacity(0.7))
                            .padding(.vertical, 13)
                            .padding(.horizontal, 23)
                            .background(self.selectedWeekday.weekday == button.weekday ? Color.init(#colorLiteral(red: 0.418166846, green: 0.6161624789, blue: 0.7903828025, alpha: 0.8040789887)) : Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.top, 15)// дни недели
    
            outputView(selected: selectedTypeWeekday) // вывод выбранного дня недели
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 35)
        .background(Color.init(#colorLiteral(red: 0.0431372549, green: 0.3568627451, blue: 0.6470588235, alpha: 1))).edgesIgnoringSafeArea(.all)
    }
}

//MARK: - TypeWeekButton


struct typeWeekButton: View {
    let title: String
    @Binding var selected: String
    
    var body: some View {
        Button(action: {
            self.selected = self.title
            
            switch self.title {
            case "Нечетная":
                print("Нечетная")
            case "Четная":
                print("Четная")
            default:
                print("")
            }
            
        }, label: {
            Text(title)
                .font(.system(size: 15))
                .fontWeight(selected == title ? .bold : .none)
                .foregroundColor(selected == title ? .black : .white)
                .padding(.vertical, 14)
                .padding(.horizontal, 50)
                .background(selected == title ? Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) : Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
                .cornerRadius(25)
        })
    }
}

//MARK: - ClassesView


struct noСlassesView: View { // нет пар
    
    let noClassesimage: String
    
    let noСlasses = "🤪"
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
               Image.init(noClassesimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 35)
                Text("Пар нет! Отличный повод увидеться с друзьями \(noСlasses)")
                .font(.system(size: 20))
                .padding(.horizontal, 40)
                .foregroundColor(.white)
            }
        }
        .padding() // нет зянятий
    }
}

struct thereClassesView: View { // есть пары
    
    // поля ?
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("")
            }
        }
    }
}


/*
struct weekdayButton: View {
    let title: String
    @Binding var selected: String
    
    var body: some View {
        
        Button(action: {
            self.selected = self.title
        }, label: {
            Text(title)
                .font(.system(size: 15))
                .fontWeight(selected == title ? .bold : .none)
                .foregroundColor(selected == title ? .white : Color.white.opacity(0.7))
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(selected == title ? Color.init(#colorLiteral(red: 0.418166846, green: 0.6161624789, blue: 0.7903828025, alpha: 0.8040789887)) : Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
                .cornerRadius(10)
        })
    }
} */


//MARK: - Model
