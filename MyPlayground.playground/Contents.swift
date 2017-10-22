//: Playground - noun: a place where people can play

import UIKit

var srcDateStr = "2014-07-01 00:00:00"

let stringToDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "en_US_POSIX")
    df.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    df.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    df.timeZone = TimeZone(secondsFromGMT: 0)
    return df
}()

let dateToStringFormatter: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "ru_RU")
    df.dateFormat = "dd.MM.yyyy"
    df.timeZone = TimeZone(secondsFromGMT: 0)
    //let string = df.string(from: date!)
    return df
}()

let date = stringToDateFormatter.date(from: srcDateStr)
date
let string = dateToStringFormatter.string(from: date!)
string

