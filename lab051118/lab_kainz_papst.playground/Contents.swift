import Foundation

// Before upload ADD YOUR NAME:
// Patrick Papst and Patrick Kainz
let myname = "Patrick Papst and Patrick Kainz"
print(myname)
// INFO:
// =====
// STATE with version you used: Swift 3 or Swift 4.x
//       and where (linux, online, playground,...)
//       you tested your code

//   Swift on Linux:
//   ===============
//      https://swift.org/getting-started/#installing-swift
//   ONLINE:
//   =======
//      Version: 4.2 e.g. at:
//      http://online.swiftplayground.run
//      https://repl.it/languages/swift
//      Version: 3.1.1 at:
//      https://iswift.org/playground
//
//   Xcode:
//   =======
//      create a Swift Playground


// We used Playground in Xcode

let str = "Make the code work, improve the style and optimise :)"
print(str)

// Swift Basics
//   datatypes: var vs. let, strings, split, numbers, lists, sets, dictionary
//   e.g. var smartphonePasscodeSequence="77,33,1,66".split(separator: ",")
print("Define and output your pets as set")

let pets = ["Luca","Lia","Milo"]

for pet in pets {
    print(pet)
}

print("Define and output your last vacations as dictionaries")

let vacations = [
    "Papst": [2018: "Kroatien", 2017: "Österreich", 2016: "Griechenland"],
    "Kainz": [2018: "Daham", 2017: "Daham", 2016: "London"]
]

for name in vacations.keys {
    print("Vacations of \(name):")
    for year in vacations[name]!.keys {
        let vacation = vacations[name]![year]!
        print("\(year): \(vacation)")
    }
}

//   datatypes: optionals, optional chaining, enums
print("Define and use a dbUrlString which might be nil")
var dbUrlString : String? = nil;
let random = Int.random(in: 0 ..< 10)
if random >= 5 {
    dbUrlString = "jdbc:oracle:thin://IRGENDWOS"
}

if dbUrlString != nil  {
    print("Connected to \(dbUrlString!)")
} else {
    print("no database connection")
}

//   optional chaining:
print("Output the db connection string (lowercase) only if not nil")
//   e.g.: if let txt = dbConnectionStg?.lowercased() { ...

if let conn = dbUrlString?.lowercased() {
    print("Lowercase Connection: \(conn)")
} else {
    print("still no database connection")
}

print("Define life-cyle states of a smartphone app as enum")
//   e.g.: print( SmartPhone.LifeCycle.Paused )
enum LifeCycle {
    case Starting
    case Running
    case Paused
    case Closed
}


let randomState = Int.random(in: 0 ..< 4)


var status = LifeCycle.Starting;
switch(randomState) {
case 0:
    status = LifeCycle.Starting;
case 1:
    status = LifeCycle.Running;
case 2:
    status = LifeCycle.Paused
case 3:
    status = LifeCycle.Closed
default:
    print("Something went wrong, random = \(randomState)")
}

print("Status = \(status)")
//   format strings <= string interpolation
print("The length of \(myname) is \(myname.count) chars.") // TODO fill in your variables

//   functions: inout parameters (to save mem) and variable number of arguments (...)
print("Define a function which modifies every given string by removing a random character...")

func removeRandom(_ text : inout String ) {
    let randomPosition = Int.random(in: 0..<text.count)
    text.remove(at: text.index(text.startIndex, offsetBy: randomPosition))
}

var copyName = myname
removeRandom(&copyName)

print("Removed random char from name \(myname) = \(copyName)")

//   functions: named parameters with default values and multiple return values for more semantics
print("Define and use multiple times a function which moves a player around in 3D space ...")
//   e.g.: player.magicMove(to: acceleratedBy: exploding: reappearWithColor: ....)


//The calculation is incorrect, but thats not the goal of the execise
func movePlayer(x : Double, y : Double, z : Double, degreeXY : Double = 45, degreeYZ : Double = 45, stepsize : Double = 1) -> (Double, Double, Double) {
    let newX = x + sin((degreeXY*Double.pi/180)*stepsize)
    let newY = y + cos((degreeXY*Double.pi/180)*stepsize) + sin((degreeYZ*Double.pi/180)*stepsize)
    let newZ = z + cos((degreeYZ*Double.pi/180)*stepsize)
    
    return (newX, newY, newZ)
}

var position = (0.0,0.0,0.0)

print("Starting at \(position)")

position = movePlayer(x: position.0,y: position.1,z: position.2)
print("Default movement to \(position)")

position = movePlayer(x: position.0,y: position.1,z: position.2, stepsize: -1)
print("Moving back to \(position)")

position = movePlayer(x: position.0,y: position.1,z: position.2, degreeXY: 90,degreeYZ: 0,stepsize: 2)
print("Moving custom to \(position)")


//   oo basics: classes
//   oo basics: properties
//   oo basics: privacy = visibility = (default) access levels <= read "Access Control in the Language Guide)
//   oo advanced: protocols = the API
print("Define a protocol which allows to retrieve location-info from an object")
//   e.g. methods: .getGPSLocation getDistanceFromHere

protocol Locationable {
    func getGPSLocation() -> (Double,Double)
}

//   oo advanced: inheritance
print("Model and create at least 7 point-of-interests (POIs)")
//   e.g.: sight seeing locations in austria with longitude/latidude, image and ...

class POI : Locationable {
    
    let name : String
    let latitute : Double
    let longitute : Double
    
    init(name: String, latitute : Double, longitute : Double) {
        self.name = name
        self.latitute = latitute
        self.longitute = longitute
    }
    
    func getGPSLocation() -> (Double, Double) {
        return (latitute,longitute)
    }
    
    func toString() -> String {
        return "\(self.name) is at \(self.latitute) \(self.longitute)"
    }
}

var pois : [POI] = [];

pois.append(POI(name:"Irgendwo 1",latitute:0,longitute:0))
pois.append(POI(name:"Irgendwo 2",latitute:1,longitute:0))
pois.append(POI(name:"Irgendwo 3",latitute:0,longitute:1))
pois.append(POI(name:"Irgendwo 4",latitute:1,longitute:1))
pois.append(POI(name:"Irgendwo 5",latitute:2,longitute:1))
pois.append(POI(name:"Irgendwo 6",latitute:1,longitute:2))
pois.append(POI(name:"Irgendwo 7",latitute:2,longitute:2))

for poi in pois {
    print("POI \(poi.toString())")
}

print("Specialise Pub-POIs with convenience initialisers (list of available drinks)...")
//   e.g.: irish pubs in graz with longitude/latidude, image and available drinks...

class PubPOI : POI {
    var availableDrinks : [String]
    
    init(name : String, latitute: Double, longitute: Double, availableDrinks : [String]) {
        self.availableDrinks = availableDrinks
        super.init(name: name, latitute: latitute, longitute: longitute)
    }
    
    override func toString() -> String {
        var result = "Pub \(super.toString()) serves:"
        for drink in availableDrinks {
            result+=" "+drink
        }
        return result
    }
}

pois.append(PubPOI(name: "Queen Victorias Pub",latitute: 3,longitute: 3,availableDrinks: ["Soda","Beer","Ale","Wine","Guiness"]))
for poi in pois {
    print("POI \(poi.toString())")
}


//   oo advanced: extend class
print("Extend the String class with a new function padding (allow to specify indent and char)")
//   e.g.: print( myname.padding(indent:3, char:"_") )

extension String {
    func padding(indent : Int, char: String) -> String{
        var result = self
        for _ in 0..<indent {
            result = char + result + char
        }
        return result
    }
}

print( myname.padding(indent:3, char:"_") )

//   docu <= see https://www.appcoda.com/swift-markdown/
/// This is helpful if you ALT-Click on the varialbe or fumction:
let author=myname;
/** Returns a last modified string in the format year by author
 - parameter bA: The author
 - parameter lm: Year of last modification
 */
func about(lastmodified lm: Int = 2017, byAuthor bA: String  )->String{
    return "\(lm) by \(bA)" }
print( about( lastmodified: 2018, byAuthor: myname) )



//   functional: closures, map, reduce, filter, joined sorted ...
//  see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html where you learn that
//  ... Closures are self-contained blocks of functionality that can be passed around... { (parameters) -> return type in statements } ...
//  e.g. a rather long version (TODO learn to shorten it!):
func backward(_ s1: String, _ s2: String) -> Bool { return s1 > s2 }
var reversedNames = ["Hello","IMS"].sorted(by: backward)
print("Create and output list of image-names sorted by png, jpg, gif .. suffix")
let images = ["test.png", "hallo.gif", "something.jpg", "morejpg.jpg", "more.bmp", "s.png","a.png","d.png","s.jpg","s.gif"]
func sortByExtension(_ s1: String, _ s2: String) -> Bool {
    let ext1 = s1[s1.lastIndex(of: ".")!..<s1.endIndex];
    let ext2 = s2[s2.lastIndex(of: ".")!..<s2.endIndex];
    return ext1 < ext2;
}

print(images.sorted(by: sortByExtension))

print("Then output list of gif image-names")

print(images.filter({(s) -> Bool in
   return s.hasSuffix(".gif")
}))


print("Then output the overall char-count of the jpg image-names")
let count = images.filter({(s) -> Bool in
    return s.hasSuffix(".jpg")
}).reduce(0, {x,y in x+y.count})
print("Total count of jpg: \(count)")
//with 3 characters postfix, 1 for the point and at least 1 for the name, such a filename is not possible, i am doing <= 5 instead....
print("Then output sorted list of very short (<5 chars) png image-names uppercased")

print(images.filter({(s) -> Bool in
    return s.hasSuffix(".png") && s.count<=5
}).sorted().map({s in s.uppercased()}))




//
// Swift Advanced will be covered in the next lab session:
//   simple regex (pattern matching)
//   code quality -- assert
//   code quality -- guard
//   code quality -- exception handling try catch
//   oo advanced: lazy properties
//   oo observers
//   oo operator overloading
//   generics
//   closures - nested functions
//   concurrency
//   modules and libraries



// MUST READ = The Quick Tour and API Style Guide
//  https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html
//  https://swift.org/documentation/api-design-guidelines/


// OPTIONAL Coding Style Guide, Swift eBook & Language Guide and more:
//  https://github.com/raywenderlich/swift-style-guide
//  https://swift.org/documentation/#the-swift-programming-language
//  https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language
//  ... https://developer.apple.com/swift/resources/ ...



// Swift3 vs. Swift 4: only "minor" differences, see
//  https://swift.org/blog/swift-4-0-released/
