import { WeatherInfo } from "./WeatherInfo";

export class Forecasts{
  casts : Array<WeatherInfo> = []
  city:string = ""
  province:string = ""
  adcode:number = 0
}