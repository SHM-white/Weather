import {WeatherInfo} from "../viewmodel/WeatherInfo"
@Component
export struct CityView{
  weatherInfos : Array<WeatherInfo> = []
  @State headColor : Color = Color.White
  build(){
    Column(){
      ForEach(this.weatherInfos,(weatherInfo:WeatherInfo)=>{
        if(this.weatherInfos[0] === weatherInfo){
          Row(){
            Column(){
              Text(weatherInfo.dayweather).fontSize(45)
                .fontWeight(FontWeight.Bold).margin(5)
              Text(weatherInfo.nighttemp + "~" + weatherInfo.daytemp + "℃").fontSize(20)
                .fontWeight(FontWeight.Bold).margin(3)
              Text(weatherInfo.daywind+"风"+weatherInfo.daypower+"级").fontSize(20)
                .fontWeight(FontWeight.Bold).margin(3)
            }.align(Alignment.Start)
            .margin({left:20})
            if(weatherInfo.dayweather === "晴"){
              Image($r('app.media.Sunny')).width((160))
            }
            if (weatherInfo.dayweather === "阴") {
              Image($r('app.media.Overcast')).width((160))
            }
            if (weatherInfo.dayweather === "多云") {
              Image($r('app.media.Cloudy')).width((160))
            }
            if (weatherInfo.dayweather.includes("雨")) {
              Image($r('app.media.Rain')).width((160))
            }
          }.height("20%")
          .width("90%")
          .justifyContent(FlexAlign.SpaceBetween)
          .margin(20)
          .backgroundColor(weatherInfo.dayweather === "晴" ? 0x60d6ff : 0xcccccc)
          .borderRadius(10)

        }
        Column(){
          ForEach()
        }.width("90%")

      })
    }.width("100%")
    .height("100%")
  }
}