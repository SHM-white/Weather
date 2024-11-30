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
            Image($r('app.media.100')).width((260))
            if(weatherInfo.dayweather === "晴"){
              Image($r('app.media.100')).width((260))
            }
            if (weatherInfo.dayweather === "阴") {
              Image($r('app.media.104')).width((260))
            }
            if (weatherInfo.dayweather === "多云") {
              Image($r('app.media.101')).width((260))
            }
            if (weatherInfo.dayweather.includes("雨")) {
              Image($r('app.media.306')).width((260))
            }
          }.height("30%")
        }
      })
    }.width("100%")
    .height("100%")
  }
}