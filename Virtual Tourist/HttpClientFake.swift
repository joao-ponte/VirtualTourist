//
//  HttpClientFake.swift
//  Virtual Tourist
//
//  Created by João Ponte on 28/07/2023.
//

import Foundation

class HttpClientFake: HttpClientProtocol {
    
    func taskForGetRequest<ResponseType>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) where ResponseType : Decodable {
        
        
        let data = fakeJson.data(using: .utf8)
        let decoder = JSONDecoder()
        let photoResponse = try! decoder.decode(ResponseType.self, from: data!)
        
        completion(photoResponse, nil)
        
        
    }
    
    let fakeJson = """
{"photos":{"page":2,"pages":131,"perpage":18,"total":2351,"photo":[{"id":"52743937285","owner":"188806011@N04","secret":"c8e28d8015","server":"65535","farm":66,"title":"Private Frederick Goodwin 25908","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743003377","owner":"188806011@N04","secret":"9023a3164e","server":"65535","farm":66,"title":"Memorial inside church","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52729263391","owner":"43033816@N03","secret":"60de5f37d7","server":"65535","farm":66,"title":"Red Kite Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52729740653","owner":"43033816@N03","secret":"ff7676c66f","server":"65535","farm":66,"title":"Red Kite Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52726828696","owner":"43033816@N03","secret":"6a2835fd44","server":"65535","farm":66,"title":"Long Tailed Tit Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52727088354","owner":"43033816@N03","secret":"abe4fe97b3","server":"65535","farm":66,"title":"Long Tailed Tit Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743183277","owner":"188806011@N04","secret":"45fbb14b75","server":"65535","farm":66,"title":"Private A G Page 15708","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743700691","owner":"188806011@N04","secret":"743e581393","server":"65535","farm":66,"title":"Private Robert Percy Palmer 23454","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52744119020","owner":"188806011@N04","secret":"be2ff0bbb9","server":"65535","farm":66,"title":"Gunner John Porter 1781102","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743686076","owner":"188806011@N04","secret":"d4bc8f5f46","server":"65535","farm":66,"title":"Saint Mary Magdelane Church View.","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743939144","owner":"188806011@N04","secret":"479f96290d","server":"65535","farm":66,"title":"Acting Bombardier Albert Edward Gray 133789","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743939064","owner":"188806011@N04","secret":"4072f088b6","server":"65535","farm":66,"title":"Ridlington Church","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743685906","owner":"188806011@N04","secret":"5328a2ecf6","server":"65535","farm":66,"title":"Ridlington Church memorial","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52744015818","owner":"188806011@N04","secret":"f75da44edd","server":"65535","farm":66,"title":"St Peters church view","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743941540","owner":"188806011@N04","secret":"0f3192d816","server":"65535","farm":66,"title":"Corporal John M Butchart 406119","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52743003522","owner":"188806011@N04","secret":"fa79a3d01c","server":"65535","farm":66,"title":"St Marys Church view","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52729740743","owner":"43033816@N03","secret":"49fc22dd9b","server":"65535","farm":66,"title":"Red Kite Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0},{"id":"52727088309","owner":"43033816@N03","secret":"ac110d55cd","server":"65535","farm":66,"title":"Long Tailed Tit Eyebrook Res 26-1-23","ispublic":1,"isfriend":0,"isfamily":0}]},"stat":"ok"}
"""
}
