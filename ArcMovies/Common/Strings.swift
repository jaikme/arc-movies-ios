//
//  Strings.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


struct Strings {
    
    struct Movies {
        
        static let title = NSLocalizedString("Upcoming movies", comment: "List of upcoming movies in theatres")
    }
    
    struct Error {
        
        static let genericTitle = NSLocalizedString("Sorry", comment: "Generic error title")
        static let genericMessage = NSLocalizedString("Something went wrong.", comment: "Generic error message")
        static let okButtonTitle = NSLocalizedString("Ok", comment: "Alert button title")
    }
}
