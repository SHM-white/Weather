import { Forecasts } from "./Forecasts"
import { LiveWeatherInfo } from "./LiveWeatherInfo"

export class WeatherModel{
  status:number = 0
  count:number = 0
  infocode:number = 0
  forecasts:Array<Forecasts> = []
  lives:Array<LiveWeatherInfo> = []
}