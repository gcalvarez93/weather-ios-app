//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Gabriel Castro on 3/1/24.
//

import Foundation

// http://api.openweathermap.org/data/2.5/weather?q=barcelona&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es

final class WeatherViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    func getWeather(city: String) async {
        let url = URL(string: "")! //Aquí ponemos la API Key

        do {
            async let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try! await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            
            DispatchQueue.main.async {
                self.weatherModel = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
