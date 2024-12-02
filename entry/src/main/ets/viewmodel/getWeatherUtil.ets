import { WeatherModel } from './WeatherModel'
import http from  '@ohos.net.http'

class getWeatherUtil{
  getWeather(cityCode : number){
    return new Promise<WeatherModel>((resolve,reject)=>{
      let request = http.createHttp()
      let url = `https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&key=45c5f8fa1fcdc1fe2cb119326f239cec&extensions=all`
      let result = request.request(url)

      result.then((res)=>{
        if(res.responseCode === 200){
          console.log(res.result.toString());
          resolve(JSON.parse(res.result.toString()))
        }
      }).catch()
    })
  }
  getLiveWeather(cityCode : number){
    return new Promise<WeatherModel>((resolve,reject)=>{
      let request = http.createHttp()
      let url = `https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&key=45c5f8fa1fcdc1fe2cb119326f239cec&extensions=base`
      let result = request.request(url)

      result.then((res)=>{
        if(res.responseCode === 200){
          console.log(res.result.toString());
          resolve(JSON.parse(res.result.toString()))
        }
      }).catch()
    })
  }

  async getWeathers(cityCodes : Array<number>){
    let promises:Array<Promise<WeatherModel>> = []
    let weatherModels :Array<WeatherModel> = []
    for (let i = 0; i < cityCodes.length; i++) {
      promises.push(this.getWeather(cityCodes[i]))
    }
    await Promise.all(promises).then(result=>{
      for (const element of result) {
        console.log(element.forecasts[0].city)
      }
      weatherModels = result
    })
    return weatherModels
  }
}

let getweatherUtil = new getWeatherUtil()
export default getweatherUtil as getWeatherUtil