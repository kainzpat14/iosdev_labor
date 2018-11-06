//Authors: Patrick Papst and Patrick Kainz

import Foundation

struct Coordinates {
    let longitude : Double
    let latitude : Double
}

struct Waypoint {
    let coordinates : Coordinates
}

struct Photo {
    let path : String;
}

func getDefaultCategory() -> String {
    //very expensive database lookup to get default category
    return "Default Category"
}

struct Ride {
    let id : String? = nil
    let timestampStart : Date
    var timestampEnd : Date? = nil {
        //feature 3: observers
        didSet {
            if timestampEnd != nil {
                //we would actually register a list of functions here
                print("Finished ride \(self)")
            }
        }
    }
    //feature 5: Lazy property
    lazy var category : String = getDefaultCategory()
    let purpose : String = "Default Purpose"
    let kilometerStart : Int
    var kilometerEnd : Int? = nil
    let coordinatesStart : Coordinates
    var coordinatesEnd : Coordinates? = nil
    var waypoints : [Waypoint] = []
    var photos : [Photo] = []
    
    //feature 1: operator overloading
    static func +(lhs : inout Ride, rhs : Waypoint) -> Ride {
        lhs.waypoints.append(rhs);
        return lhs;
    }
    
    static func +=(lhs : inout Ride, rhs : Waypoint) -> Ride {
        return lhs + rhs
    }
    
    //feature 2: read only computed property
    var finished : Bool {
        return timestampEnd != nil
    }
    
    init(timestampStart : Date, kilometerStart : Int, coordinatesStart : Coordinates) {
        self.timestampStart=timestampStart
        self.kilometerStart=kilometerStart
        self.coordinatesStart = coordinatesStart;
    }
}

var ride = Ride(timestampStart: Date(), kilometerStart: 0, coordinatesStart: Coordinates(longitude:1,latitude:1))

ride+=Waypoint(coordinates: Coordinates(longitude:2,latitude:2))

func getFinishString(_ ride : Ride) -> String {
    //feature 4: guard statements
    guard let finishedAt = ride.timestampEnd else {
        return "Not finished";
    }
    return "finished at \(finishedAt.description)";
}

print(ride)
print("finished before change: \(ride.finished) \(getFinishString(ride))")

ride.timestampEnd = Date()
print("finished after change: \(ride.finished) \(getFinishString(ride))")

print("Ride before lazy init: \(ride)")
print(ride.category)
print("Ride after lazy init: \(ride)")
