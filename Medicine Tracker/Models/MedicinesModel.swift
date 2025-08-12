//
//  MedicinesModel.swift
//  Medicine Tracker
//
//  Created by admin on 7/2/23.
//

import Foundation
import SwiftUI


struct medicineModel: Identifiable , Codable {
    var id = UUID().uuidString
    let title: String
    let Doasage: String
    let  pillDate: Date
    let totalPill: String
    let remainingPill: String
    let daysOfTheWeek: [String]
    let endDate: Date
    let isMedTaken: Bool
}

