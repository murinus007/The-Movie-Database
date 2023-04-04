//
//  MovieService.swift
//  Movie
//
//  Created by Alex Serhiiev on 08.03.2023.
//

import Foundation
import Alamofire


class MovieService {
    
    static var shared: MovieService = {
            let instance = MovieService()
            return instance
        }()
    
    let urlMovies = "https://api.themoviedb.org/3/trending/movie/week?api_key=d6bb029f551109d308371d9f913ac830&page=3"
    
    let urlSeries = "https://api.themoviedb.org/3/trending/tv/week?api_key=d6bb029f551109d308371d9f913ac830"

    
    func getMovies(closure: @escaping (Result) -> ()) {
        AF.request(urlMovies).responseDecodable (of: Result.self) { responce  in
            closure(responce.value!)
        }
    }
    
    func getSeries(closure: @escaping (Result) -> ()) {
        AF.request(urlSeries).responseDecodable (of: Result.self) { responce  in
            closure(responce.value!)
        }
    }
    
    func searh(text: String, type: MediaType, closure: @escaping (Result) -> ()) {
        let url = "https://api.themoviedb.org/3/search/\(type.rawValue)?api_key=d6bb029f551109d308371d9f913ac830&language=en-US&query=\(text)&page=1&include_adult=false"
        AF.request(url).responseDecodable (of: Result.self) { responce  in
            if responce.value != nil { closure(responce.value!) }
        }
    }
    
    func getTrailer(movieId: String, closure: @escaping (Trailer) -> ())  {
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=d6bb029f551109d308371d9f913ac830&language=en-US"
        
        AF.request(url).responseDecodable (of: Trailer.self) { responce  in
            print(responce)
            if responce.value != nil { closure(responce.value!) }
        
        }
    }
    
}
