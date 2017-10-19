import Foundation

struct Address {
    var additional_information : String?
    var zip : String?
    var country : String?
    var region : String?
    var area : String?
    var city : String?
    var town : String?
    var street : String?
    var house : String?
    var `case` : String?
    var apartment : String?
    var gps_lat : Float? // 56.233969
    var gps_lng : Float? // 43.388959
    
    init?(json: [String:Any]?) {
        guard let json = json else { return nil }
        self.additional_information = json["additional_information"] as? String
        self.zip = json["zip"] as? String
        self.country = json["country"] as? String
        self.region = json["region"] as? String
        self.area = json["area"] as? String
        self.city = json["city"] as? String
        self.town = json["town"] as? String
        self.street = json["street"] as? String
        self.house = json["house"] as? String
        self.`case` = json["case"] as? String
        self.apartment = json["apartment"] as? String
        self.gps_lat = json["gps_lat"] as? Float
        self.gps_lng = json["gps_lng"] as? Float
    }
}
