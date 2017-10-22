import Foundation

/*
 id : "365828"
 name : "Object 218"
 type : "OWN"
 date_opened : "2014-07-01 00:00:00"
 date_closed : null
 address
     additional_information : null
     zip : null
     country : "RUS"
     region : "22"
     area : null
     city : "Some city"
     town : null
     street : "Lenina st"
     house : null
     case : null
     apartment : null
     gps_lat : 56.233969
     gps_lng : 43.388959
 phone : "84991234567"
 status : "258"
 products
     0 : "SHOP"
     1 : "CAFE"
 */

class PoinfOfSale: NSObject {

    var id: String
    var name: String
    var type: String
    var dateOpened: Date?
    var dateClosed: Date?
    var address: Address?
    var phone: String?
    var status: String?
    var products: [String]?
    
    public init(id: String,
                name: String,
                type: String,
                dateOpened: Date?,
                dateClosed: Date?,
                address: Address?,
                phone: String?,
                status: String?,
                products: [String]?) {
        
        self.id = id
        self.name = name
        self.type = type
        self.dateOpened = dateOpened
        self.dateClosed = dateClosed
        self.address = address
        self.phone = phone
        self.status = status
    }
}

extension PoinfOfSale {
    struct ApiKeys {
        static let id = "id"
        static let name = "name"
        static let type = "type"
        static let dateOpened = "date_opened"
        static let dateClosed = "date_closed"
        static let address = "address"
        static let phone = "phone"
        static let status = "status"
        static let products = "products"
    }
}

extension PoinfOfSale {
    
    
    
    public convenience init?(json:[String:Any]) {
        
        guard
            let id = json[ApiKeys.id] as? String,
            let name = json[ApiKeys.name] as? String,
            let type = json[ApiKeys.type] as? String
            else { return nil }
        
        let dateOpenedString = json[ApiKeys.dateOpened] as? String
        let dateOpened = PoinfOfSale.stringToDateFormatter.date(from: dateOpenedString ?? "")
        let dateClosed = PoinfOfSale.stringToDateFormatter.date(from: json[ApiKeys.dateClosed] as? String ?? "")
        let address = Address(json:json[ApiKeys.address] as? [String:Any])
        let phone = json[ApiKeys.phone] as? String
        let status = json[PoinfOfSale.ApiKeys.status] as? String
        let products = json[PoinfOfSale.ApiKeys.products] as? [String]
        
        self.init(id: id, name: name, type: type, dateOpened: dateOpened, dateClosed: dateClosed, address: address, phone: phone, status: status, products: products)
    }
}

extension PoinfOfSale {
    static let stringToDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        return df
        //let date = df.date(from: str)
    }()
    
    static let dateToStringFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "dd.MM.yyyy"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        //let string = df.string(from: date!)
        return df
    }()
    
    var dateOpenedString: String {
        return self.dateOpened != nil
            ? PoinfOfSale.dateToStringFormatter.string(from: self.dateOpened!)
            : ""
    }
}
