import { WeatherModel } from './WeatherModel'
import GeocodeModel from './GeocodeModel'
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
      let url = `https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&key=45c5f8fa1fcdc1fe2cb119326f239cec`
      let result = request.request(url)

      result.then((res)=>{
        if(res.responseCode === 200){
          console.log(res.result.toString());
          resolve(JSON.parse(res.result.toString()))
        }
      }).catch()
    })
  }
  private getGeocode(address:string,city?:string){
    return new Promise<GeocodeModel>((resolve,reject)=>{
      let request = http.createHttp()
      let url = `https://restapi.amap.com/v3/geocode/geo?address=${address}&key=45c5f8fa1fcdc1fe2cb119326f239cec${city === null?'':`&city=${city}`}`
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
    let promises2:Array<Promise<WeatherModel>> = []
    let weatherModels :Array<WeatherModel> = []
    for (let i = 0; i < cityCodes.length; i++) {
      promises.push(this.getWeather(cityCodes[i]))
    }
    for (let i = 0; i < cityCodes.length; i++){
      promises2.push(this.getLiveWeather(cityCodes[i]))
    }
    await Promise.all(promises).then(result=>{
      for (const element of result) {
        console.log(element.forecasts[0].city)
      }
      weatherModels = result
    })
    await Promise.all(promises2).then(result=>{
      for (let index = 0; index < result.length; index++) {
        const element = result[index];
        weatherModels[index].lives = element.lives
      }
    })
    return weatherModels
  }
  async getGeoCodes(address:string,city?:string){
    let result = await this.getGeocode(address,city)
    return result.geocodes
  }
}

let getweatherUtil = new getWeatherUtil()
export default getweatherUtil as getWeatherUtil