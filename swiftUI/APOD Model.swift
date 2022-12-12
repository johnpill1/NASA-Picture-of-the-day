//
//  APOD Model.swift
//  swiftUI
//
//  Created by John Pill on 12/12/2022.
//

import Foundation


struct APODImage: Codable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}

