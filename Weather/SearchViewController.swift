//
//  SearchViewController.swift
//  Weather
//
//  Created by sara akram on 8/25/16.
//  Copyright © 2016 sara akram. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

let gApiKey = "7f0e9e9414663fffe17de01640a48a07"


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var locTableView: UITableView!
    @IBOutlet weak var locSearchBar: UISearchBar!
    
    var citySearches : [ (cityName: String, temps: [Double]) ]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locSearchBar.delegate = self
    }
    
    var locationResults = [Location]()
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {
            return
        }
        
        WeatherServer.weatherRequestCall(forCityName: searchBarText) { (response) in
            if let cityName = response["city"]["name"].string,
                let temps = response["list"].array where temps.count >= 0 {
                var temperatures = [Double]()
                for json in temps {
                    if let temp = json["main"]["temp"].double {
                        temperatures.append(temp)
                    }
                }
                
                
                if self.citySearches != nil {
                    self.citySearches?.append((cityName: cityName, temps: temperatures))
                } else {
                    self.citySearches = [(cityName: cityName, temps: temperatures)]
                }
                self.locTableView.reloadData()
            }
        }
    }
    
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citySearches?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell") as! LocationCell
        cell.cityLabel.text = self.citySearches![indexPath.row].cityName
        return cell
    }
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return recognizer
    }()
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
//        let indexPath = tableView.indexPathForSelectedRow!;
        
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
        
        //
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchDetailViewController = storyboard.instantiateViewControllerWithIdentifier("searchDetailViewController") as! SearchDetailViewController
        searchDetailViewController.searchResult = self.citySearches![indexPath.row]
        self.navigationController?.pushViewController(searchDetailViewController, animated: true)
        
    }
    
    
    
    
    
    func updateSearchResults(forCityName: NSData ){
    
            let json = JSON(data: forCityName)
        
            
            if let city = json[0]["name"].string {
                locationResults.append(Location(city: city))
        
            }
            
            else {
                print ("incorrect JSON error")
            }
        }
    
    static let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Indianapolis", "Jacksonville", "San Francisco", "Columbus", "Charlotte", "Fort Worth", "Detroit", "El Paso", "Memphis", "Seattle", "Denver", "Washington", "Boston", "Nashville-Davidson", "Baltimore", "Oklahoma City", "Louisville/Jefferson County", "Portland", "Las Vegas", "Milwaukee", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Long Beach", "Kansas City", "Mesa", "Virginia Beach", "Atlanta", "Colorado Springs", "Omaha", "Raleigh", "Miami", "Oakland", "Minneapolis", "Tulsa", "Cleveland", "Wichita", "Arlington", "New Orleans", "Bakersfield", "Tampa", "Honolulu", "Aurora", "Anaheim", "Santa Ana", "St. Louis", "Riverside", "Corpus Christi", "Lexington-Fayette", "Pittsburgh", "Anchorage", "Stockton", "Cincinnati", "St. Paul", "Toledo", "Greensboro", "Newark", "Plano", "Henderson", "Lincoln", "Buffalo", "Jersey City", "Chula Vista", "Fort Wayne", "Orlando", "St. Petersburg", "Chandler", "Laredo", "Norfolk", "Durham", "Madison", "Lubbock", "Irvine", "Winston-Salem", "Glendale", "Garland", "Hialeah", "Reno", "Chesapeake", "Gilbert", "Baton Rouge", "Irving", "Scottsdale", "North Las Vegas", "Fremont", "Boise City", "Richmond", "San Bernardino", "Birmingham", "Spokane", "Rochester", "Des Moines", "Modesto", "Fayetteville", "Tacoma", "Oxnard", "Fontana", "Columbus", "Montgomery", "Moreno Valley", "Shreveport", "Aurora", "Yonkers", "Akron", "Huntington Beach", "Little Rock", "Augusta-Richmond County", "Amarillo", "Glendale", "Mobile", "Grand Rapids", "Salt Lake City", "Tallahassee", "Huntsville", "Grand Prairie", "Knoxville", "Worcester", "Newport News", "Brownsville", "Overland Park", "Santa Clarita", "Providence", "Garden Grove", "Chattanooga", "Oceanside", "Jackson", "Fort Lauderdale", "Santa Rosa", "Rancho Cucamonga", "Port St. Lucie", "Tempe", "Ontario", "Vancouver", "Cape Coral", "Sioux Falls", "Springfield", "Peoria", "Pembroke Pines", "Elk Grove", "Salem", "Lancaster", "Corona", "Eugene", "Palmdale", "Salinas", "Springfield", "Pasadena", "Fort Collins", "Hayward", "Pomona", "Cary", "Rockford", "Alexandria", "Escondido", "McKinney", "Kansas City", "Joliet", "Sunnyvale", "Torrance", "Bridgeport", "Lakewood", "Hollywood", "Paterson", "Naperville", "Syracuse", "Mesquite", "Dayton", "Savannah", "Clarksville", "Orange", "Pasadena", "Fullerton", "Killeen", "Frisco", "Hampton", "McAllen", "Warren", "Bellevue", "West Valley City", "Columbia", "Olathe", "Sterling Heights", "New Haven", "Miramar", "Waco", "Thousand Oaks", "Cedar Rapids", "Charleston", "Visalia", "Topeka", "Elizabeth", "Gainesville", "Thornton", "Roseville", "Carrollton", "Coral Springs", "Stamford", "Simi Valley", "Concord", "Hartford", "Kent", "Lafayette", "Midland", "Surprise", "Denton", "Victorville", "Evansville", "Santa Clara", "Abilene", "Athens-Clarke County", "Vallejo", "Allentown", "Norman", "Beaumont", "Independence", "Murfreesboro", "Ann Arbor", "Springfield", "Berkeley", "Peoria", "Provo", "El Monte", "Columbia", "Lansing", "Fargo", "Downey", "Costa Mesa", "Wilmington", "Arvada", "Inglewood", "Miami Gardens", "Carlsbad", "Westminster", "Rochester", "Odessa", "Manchester", "Elgin", "West Jordan", "Round Rock", "Clearwater", "Waterbury", "Gresham", "Fairfield", "Billings", "Lowell", "San Buenaventura (Ventura)", "Pueblo", "High Point", "West Covina", "Richmond", "Murrieta", "Cambridge", "Antioch", "Temecula", "Norwalk", "Centennial", "Everett", "Palm Bay", "Wichita Falls", "Green Bay", "Daly City", "Burbank", "Richardson", "Pompano Beach", "North Charleston", "Broken Arrow", "Boulder", "West Palm Beach", "Santa Maria", "El Cajon", "Davenport", "Rialto", "Las Cruces", "San Mateo", "Lewisville", "South Bend", "Lakeland", "Erie", "Tyler", "Pearland", "College Station", "Kenosha", "Sandy Springs", "Clovis", "Flint", "Roanoke", "Albany", "Jurupa Valley", "Compton", "San Angelo", "Hillsboro", "Lawton", "Renton", "Vista", "Davie", "Greeley", "Mission Viejo", "Portsmouth", "Dearborn", "South Gate", "Tuscaloosa", "Livonia", "New Bedford", "Vacaville", "Brockton", "Roswell", "Beaverton", "Quincy", "Sparks", "Yakima", "Lee\'s Summit", "Federal Way", "Carson", "Santa Monica", "Hesperia", "Allen", "Rio Rancho", "Yuma", "Westminster", "Orem", "Lynn", "Redding", "Spokane Valley", "Miami Beach", "League City", "Lawrence", "Santa Barbara", "Plantation", "Sandy", "Sunrise", "Macon", "Longmont", "Boca Raton", "San Marcos", "Greenville", "Waukegan", "Fall River", "Chico", "Newton", "San Leandro", "Reading", "Norwalk", "Fort Smith", "Newport Beach", "Asheville", "Nashua", "Edmond", "Whittier", "Nampa", "Bloomington", "Deltona", "Hawthorne", "Duluth", "Carmel", "Suffolk", "Clifton", "Citrus Heights", "Livermore", "Tracy", "Alhambra", "Kirkland", "Trenton", "Ogden", "Hoover", "Cicero", "Fishers", "Sugar Land", "Danbury", "Meridian", "Indio", "Concord", "Menifee", "Champaign", "Buena Park", "Troy", "O\'Fallon", "Johns Creek", "Bellingham", "Westland", "Bloomington", "Sioux City", "Warwick", "Hemet", "Longview", "Farmington Hills", "Bend", "Lakewood", "Merced", "Mission", "Chino", "Redwood City", "Edinburg", "Cranston", "Parma", "New Rochelle", "Lake Forest", "Napa", "Hammond", "Fayetteville", "Bloomington", "Avondale", "Somerville", "Palm Coast", "Bryan", "Gary", "Largo", "Brooklyn Park", "Tustin", "Racine", "Deerfield Beach", "Lynchburg", "Mountain View", "Medford", "Lawrence", "Bellflower", "Melbourne", "St. Joseph", "Camden", "St. George", "Kennewick", "Baldwin Park", "Chino Hills", "Alameda", "Albany", "Arlington Heights", "Scranton", "Evanston", "Kalamazoo", "Baytown", "Upland", "Springdale", "Bethlehem", "Schaumburg", "Mount Pleasant", "Auburn", "Decatur", "San Ramon", "Pleasanton", "Wyoming", "Lake Charles", "Plymouth", "Bolingbrook", "Pharr", "Appleton", "Gastonia", "Folsom", "Southfield", "Rochester Hills", "New Britain", "Goodyear", "Canton", "Warner Robins", "Union City", "Perris", "Manteca", "Iowa City", "Jonesboro", "Wilmington", "Lynwood", "Loveland", "Pawtucket", "Boynton Beach", "Waukesha", "Gulfport", "Apple Valley", "Passaic", "Rapid City", "Layton", "Lafayette", "Turlock", "Muncie", "Temple", "Missouri City", "Redlands", "Santa Fe", "Lauderhill", "Milpitas", "Palatine", "Missoula", "Rock Hill", "Jacksonville", "Franklin", "Flagstaff", "Flower Mound", "Weston", "Waterloo", "Union City", "Mount Vernon", "Fort Myers", "Dothan", "Rancho Cordova", "Redondo Beach", "Jackson", "Pasco", "St. Charles", "Eau Claire", "North Richland Hills", "Bismarck", "Yorba Linda", "Kenner", "Walnut Creek", "Frederick", "Oshkosh", "Pittsburg", "Palo Alto", "Bossier City", "Portland", "St. Cloud", "Davis", "South San Francisco", "Camarillo", "North Little Rock", "Schenectady", "Gaithersburg", "Harlingen", "Woodbury", "Eagan", "Yuba City", "Maple Grove", "Youngstown", "Skokie", "Kissimmee", "Johnson City", "Victoria", "San Clemente", "Bayonne", "Laguna Niguel", "East Orange", "Shawnee", "Homestead", "Rockville", "Delray Beach", "Janesville", "Conway", "Pico Rivera", "Lorain", "Montebello", "Lodi", "New Braunfels", "Marysville", "Tamarac", "Madera", "Conroe", "Santa Cruz", "Eden Prairie", "Cheyenne", "Daytona Beach", "Alpharetta", "Hamilton", "Waltham", "Coon Rapids", "Haverhill", "Council Bluffs", "Taylor", "Utica", "Ames", "La Habra", "Encinitas", "Bowling Green", "Burnsville", "Greenville", "West Des Moines", "Cedar Park", "Tulare", "Monterey Park", "Vineland", "Terre Haute", "North Miami", "Mansfield", "West Allis", "Bristol", "Taylorsville", "Malden", "Meriden", "Blaine", "Wellington", "Cupertino", "Springfield", "Rogers", "St. Clair Shores", "Gardena", "Pontiac", "National City", "Grand Junction", "Rocklin", "Chapel Hill", "Casper", "Broomfield", "Petaluma", "South Jordan", "Springfield", "Great Falls", "Lancaster", "North Port", "Lakewood", "Marietta", "San Rafael", "Royal Oak", "Des Plaines", "Huntington Park", "La Mesa", "Orland Park", "Auburn", "Lakeville", "Owensboro", "Moore", "Jupiter", "Idaho Falls", "Dubuque", "Bartlett", "Rowlett", "Novi", "White Plains", "Arcadia", "Redmond", "Lake Elsinore", "Ocala", "Tinley Park", "Port Orange", "Medford", "Oak Lawn", "Rocky Mount", "Kokomo", "Coconut Creek", "Bowie", "Berwyn", "Midwest City", "Fountain Valley", "Buckeye", "Dearborn Heights", "Woodland", "Noblesville", "Valdosta", "Diamond Bar", "Manhattan", "Santee", "Taunton", "Sanford", "Kettering", "New Brunswick", "Decatur", "Chicopee", "Anderson", "Margate", "Weymouth Town", "Hempstead", "Corvallis", "Eastvale", "Porterville", "West Haven", "Brentwood", "Paramount", "Grand Forks", "Georgetown", "St. Peters", "Shoreline", "Mount Prospect", "Hanford", "Normal", "Rosemead", "Lehi", "Pocatello", "Highland", "Novato", "Port Arthur", "Carson City", "San Marcos", "Hendersonville", "Elyria", "Revere", "Pflugerville", "Greenwood", "Bellevue", "Wheaton", "Smyrna", "Sarasota", "Blue Springs", "Colton", "Euless", "Castle Rock", "Cathedral City", "Kingsport", "Lake Havasu City", "Pensacola", "Hoboken", "Yucaipa", "Watsonville", "Richland", "Delano", "Hoffman Estates", "Florissant", "Placentia", "West New York", "Dublin", "Oak Park", "Peabody", "Perth Amboy", "Battle Creek", "Bradenton", "Gilroy", "Milford", "Albany", "Ankeny", "La Crosse", "Burlington", "DeSoto", "Harrisonburg", "Minnetonka", "Elkhart", "Lakewood", "Glendora", "Southaven", "Charleston", "Joplin", "Enid", "Palm Beach Gardens", "Brookhaven", "Plainfield", "Grand Island", "Palm Desert", "Huntersville", "Tigard", "Lenexa", "Saginaw", "Kentwood", "Doral", "Apple Valley", "Grapevine", "Aliso Viejo", "Sammamish", "Casa Grande", "Pinellas Park", "Troy", "West Sacramento", "Burien", "Commerce City", "Monroe", "Cerritos", "Downers Grove", "Coral Gables", "Wilson", "Niagara Falls", "Poway", "Edina", "Cuyahoga Falls", "Rancho Santa Margarita", "Harrisburg", "Huntington", "La Mirada", "Cypress", "Caldwell", "Logan", "Galveston", "Sheboygan", "Middletown", "Murray", "Roswell", "Parker", "Bedford", "East Lansing", "Methuen", "Covina", "Alexandria", "Olympia", "Euclid", "Mishawaka", "Salina", "Azusa", "Newark", "Chesterfield", "Leesburg", "Dunwoody", "Hattiesburg", "Roseville", "Bonita Springs", "Portage", "St. Louis Park", "Collierville", "Middletown", "Stillwater", "East Providence", "Lawrence", "Wauwatosa", "Mentor", "Ceres", "Cedar Hill", "Mansfield", "Binghamton", "Coeur d\'Alene", "San Luis Obispo", "Minot", "Palm Springs", "Pine Bluff", "Texas City", "Summerville", "Twin Falls", "Jeffersonville", "San Jacinto", "Madison", "Altoona", "Columbus", "Beavercreek", "Apopka", "Elmhurst", "Maricopa", "Farmington", "Glenview", "Cleveland Heights", "Draper", "Lincoln", "Sierra Vista", "Lacey", "Biloxi", "Strongsville", "Barnstable Town", "Wylie", "Sayreville", "Kannapolis", "Charlottesville", "Littleton", "Titusville", "Hackensack", "Newark", "Pittsfield", "York", "Lombard", "Attleboro", "DeKalb", "Blacksburg", "Dublin", "Haltom City", "Lompoc", "El Centro", "Danville", "Jefferson City", "Cutler Bay", "Oakland Park", "North Miami Beach", "Freeport", "Moline", "Coachella", "Fort Pierce", "Smyrna", "Bountiful", "Fond du Lac", "Everett", "Danville", "Keller", "Belleville", "Bell Gardens", "Cleveland", "North Lauderdale", "Fairfield", "Salem", "Rancho Palos Verdes", "San Bruno", "Concord", "Burlington", "Apex", "Midland", "Altamonte Springs", "Hutchinson", "Buffalo Grove", "Urbandale", "State College", "Urbana", "Plainfield", "Manassas", "Bartlett", "Kearny", "Oro Valley", "Findlay", "Rohnert Park", "Westfield", "Linden", "Sumter", "Wilkes-Barre", "Woonsocket", "Leominster", "Shelton", "Brea", "Covington", "Rockwall", "Meridian", "Riverton", "St. Cloud", "Quincy", "Morgan Hill", "Warren", "Edmonds", "Burleson", "Beverly", "Mankato", "Hagerstown", "Prescott", "Campbell", "Cedar Falls", "Beaumont", "La Puente", "Crystal Lake", "Fitchburg", "Carol Stream", "Hickory", "Streamwood", "Norwich", "Coppell", "San Gabriel", "Holyoke", "Bentonville", "Florence", "Peachtree Corners", "Brentwood", "Bozeman", "New Berlin", "Goose Creek", "Huntsville", "Prescott Valley", "Maplewood", "Romeoville", "Duncanville", "Atlantic City", "Clovis", "The Colony", "Culver City", "Marlborough", "Hilton Head Island", "Moorhead", "Calexico", "Bullhead City", "Germantown", "La Quinta", "Lancaster", "Wausau", "Sherman", "Ocoee", "Shakopee", "Woburn", "Bremerton", "Rock Island", "Muskogee", "Cape Girardeau", "Annapolis", "Greenacres", "Ormond Beach", "Hallandale Beach", "Stanton", "Puyallup", "Pacifica", "Hanover Park", "Hurst", "Lima", "Marana", "Carpentersville", "Oakley", "Huber Heights", "Lancaster", "Montclair", "Wheeling", "Brookfield", "Park Ridge", "Florence", "Roy", "Winter Garden", "Chelsea", "Valley Stream", "Spartanburg", "Lake Oswego", "Friendswood", "Westerville", "Northglenn", "Phenix City", "Grove City", "Texarkana", "Addison", "Dover", "Lincoln Park", "Calumet City", "Muskegon", "Aventura", "Martinez", "Greenfield", "Apache Junction", "Monrovia", "Weslaco", "Keizer", "Spanish Fork", "Beloit", "Panama City"]
    


}
