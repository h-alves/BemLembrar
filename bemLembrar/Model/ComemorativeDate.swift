//
//  ComemorativeDate.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

struct ComemorativeDate {
    let identifier: String
    let date: DateComponents
    let name: String
    
    static var allDates: [ComemorativeDate] = [
        .christmas, .mother, .father, .love
    ]
    
    static var christmas = ComemorativeDate(identifier: "christmas", date: Date().createComponents(day: 20, month: 12), name: "Natal")
    static var mother = ComemorativeDate(identifier: "mother", date: Date().createComponents(day: 6, month: 5), name: "Dia dos pais")
    static var father = ComemorativeDate(identifier: "father", date: Date().createComponents(day: 6, month: 8), name: "Dia das mães")
    static var love = ComemorativeDate(identifier: "love", date: Date().createComponents(day: 8, month: 6), name: "Dia dos namorados")
}
