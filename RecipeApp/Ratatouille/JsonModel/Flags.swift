//
//  Flags.swift
//  Ratatouille



import Foundation
import SwiftData

func setFlag(for selectedArea: String) -> String {
    var flagQuery = ""
    switch selectedArea {
    case "American" :
        flagQuery = "US"
    case "British" :
        flagQuery = "GB"
    case "Canadian" :
        flagQuery = "CA"
    case "Chinese" :
        flagQuery = "CN"
    case "Croatian" :
        flagQuery = "HR"
    case "Dutch" :
        flagQuery = "NL"
    case "French" :
        flagQuery = "FR"
    case "Egyptian" :
        flagQuery = "EG"
    case "Filipino" :
        flagQuery = "PH"
    case "Greek" :
        flagQuery = "GR"
    case "Indian" :
        flagQuery = "IN"
    case "Irish" :
        flagQuery = "IR"
    case "Italian" :
        flagQuery = "IT"
    case "Jamaican" :
        flagQuery = "JM"
    case "Japanese" :
        flagQuery = "JP"
    case "Kenyan" :
        flagQuery = "KE"
    case "Malaysian" :
        flagQuery = "MY"
    case "Mexican" :
        flagQuery = "MX"
    case "Morrocan" :
        flagQuery = "ME"
    case "Polish" :
        flagQuery = "PL"
    case "Portugese" :
        flagQuery = "PT"
    case "Russian" :
        flagQuery = "RU"
    case "Spanish" :
        flagQuery = "ES"
    case "Thai" :
        flagQuery = "TH"
    case "Tunisian" :
        flagQuery = "TN"
    case "Turkish" :
        flagQuery = "TR"
    case "Unknown" :
        flagQuery = "NO"
    case "Vietnamese" :
        flagQuery = "VN"
    default:
        flagQuery = "NO"
    }
    return "https://flagsapi.com/\(flagQuery)/flat/64.png"
    
    
}


