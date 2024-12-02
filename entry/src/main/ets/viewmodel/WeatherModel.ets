import { Forecasts } from "./Forecasts"

export class WeatherModel{
  status:number = 0
  count:number = 0
  infocode:number = 0
  forecasts:Array<Forecasts> = []

}