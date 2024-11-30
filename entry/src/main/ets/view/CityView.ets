import {WeatherInfo} from "../viewmodel/WeatherInfo"
@Component
export struct CityView{
  weatherInfos : Array<WeatherInfo> = []
  @Builder weatherImg(weather:string){
    Column(){
      if (weather === "晴") {
        Image($r('app.media.Sunny')).width((30))
      }
      if (weather === "阴") {
        Image($r('app.media.Overcast')).width((30))
      }
      if (weather === "多云") {
        Image($r('app.media.Cloudy')).width((30))
      }
      if (weather.includes("雨")) {
        Image($r('app.media.Rain')).width((30))
      }
    }
  }
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
      })
      Column(){
        ForEach(this.weatherInfos,(weatherInfo:WeatherInfo)=>{
          Row(){
            Text(weatherInfo.date.substring(5)).fontSize(15)
              .fontWeight(FontWeight.Bold).margin(3).width("15%")
            Text(weatherInfo.dayweather).fontSize(15)
              .fontWeight(FontWeight.Bold).margin(3).width("15%")
            this.weatherImg(weatherInfo.nightweather)
            Text(weatherInfo.nighttemp + "℃" + "~" + weatherInfo.daytemp + "℃").fontSize(15)
              .fontWeight(FontWeight.Bold).margin(5).width("30%").align(Alignment.Center).padding({ left:5,right:5 })
            this.weatherImg(weatherInfo.dayweather)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .margin(5)
          .border({ width : 0.5, color : Color.Gray, radius : 10 })
          .width("96%")
          .backgroundColor(0xcccccc)
        })
      }.width("90%")
      .border({ width : 0.5, color : Color.Gray, radius : 10 })
      .padding(5)
      .backgroundColor(0xcccccc)


    }.width("100%")
    .height("100%")
  }
}