import {WeatherInfo} from "../viewmodel/WeatherInfo"
@Component
@Preview
export struct CityView{
  weatherinfos : Array<WeatherInfo> = []
  build(){
    Column(){
      ForEach(this.weatherinfos,(weatherInfo:WeatherInfo)=>{
        if(this.weatherinfos[0] === weatherInfo){
          Row(){

          }
        }
      })
    }.width("100%")
    .height("100%")
  }
}