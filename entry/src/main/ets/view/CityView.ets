import {WeatherInfo} from "../viewmodel/WeatherInfo"

interface LinearGradientInterface {
  angle?: number | string
  direction?: GradientDirection
  colors: Array<[ResourceColor, number]>
  repeating?: boolean;
}

@Component
export struct CityView{
  weatherInfos : Array<WeatherInfo> = []
  @Builder weatherImg(weather:string,width:number = 30){
    Column(){
      if (weather === "晴") {
        Image($r('app.media.Sunny')).width(width)
      }
      if (weather === "阴") {
        Image($r('app.media.Overcast')).width(width)
      }
      if (weather === "多云") {
        Image($r('app.media.Cloudy')).width(width)
      }
      if (weather.includes("雨")) {
        Image($r('app.media.Rain')).width(width)
      }
      if(weather.includes("雪")){
        Image($r('app.media.Snow')).width(width)
      }
    }
  }

  viewBackground(weather:string){
    if (weather === "晴") {
      return ({ angle: 270, colors:[[0xfdbc4c,0],[0xff8300,1]] } as LinearGradientInterface)
    }
    if (weather === "阴") {
      return ({ angle: 270, colors:[[0xfdbc4c,0],[0xff8300,1]] } as LinearGradientInterface)
    }
    if (weather === "多云") {
      return ({ angle: 270, colors:[[0x9DAFC1,0],[0x2d5879,1]] } as LinearGradientInterface)
    }
    if (weather.includes("雨")) {
      return ({ angle: 270, colors:[[0x4297e7,0],[0x3a4d80,1]] } as LinearGradientInterface)
    }
    if(weather.includes("雪")){
      return ({ angle: 270, colors:[[0x68baff,0],[0x225fb6,1]] } as LinearGradientInterface)
    }
    if(weather.includes("雾") || weather.includes("霾")){
      return ({ angle: 270, colors:[[0xD7DDE8,0],[0x757F9A,1]] } as LinearGradientInterface)
    }
    return ({} as LinearGradientInterface)
  }

  build(){
    Column(){
      ForEach(this.weatherInfos,(weatherInfo:WeatherInfo)=>{
        if(this.weatherInfos[0] === weatherInfo){
          Column(){
            Row() {
              Column() {
                Text(weatherInfo.dayweather).fontSize(45)
                  .fontWeight(FontWeight.Bold).margin(5)
              }.align(Alignment.Start)
              .margin({ left: 20 })
              this.weatherImg(weatherInfo.dayweather,160)
            }.justifyContent(FlexAlign.SpaceBetween)

            Column(){
              Text(weatherInfo.nighttemp + "~" + weatherInfo.daytemp + "℃").fontSize(30)
                .fontWeight(FontWeight.Bold).margin(10)
              Text(weatherInfo.daywind + "风" + weatherInfo.daypower + "级").fontSize(30)
                .fontWeight(FontWeight.Bold).margin(10)
            }.layoutWeight(2)
            .margin({top:20})
          }
          .width("90%")
          .justifyContent(FlexAlign.SpaceBetween)
          .margin(20)
          .borderRadius(10)
          .layoutWeight(2)
          .linearGradient(this.viewBackground(weatherInfo.dayweather))

        }
      })

      Column(){
        ForEach(this.weatherInfos,(weatherInfo:WeatherInfo)=>{
          Row(){
            Text(weatherInfo.date.substring(5)).fontSize(17)
              .fontWeight(FontWeight.Bold).margin(3).width("18%")
            Text(weatherInfo.dayweather).fontSize(17)
              .fontWeight(FontWeight.Bold).margin(3).width("15%")
            this.weatherImg(weatherInfo.nightweather)
            Text(weatherInfo.nighttemp + "℃" + "~" + weatherInfo.daytemp + "℃").fontSize(17)
              .fontWeight(FontWeight.Bold).margin(5).width("30%").align(Alignment.Center).padding({ left:5,right:5 })
            this.weatherImg(weatherInfo.dayweather)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .margin(10)
          .width("96%")
        })
      }.width("90%")
      .border({ width : 0.5, color : Color.White, radius : 10 })
      .padding(5)
      .backgroundColor(0xffffff)
    }.width("100%")
    .height("100%")
    .padding({bottom:65})
    .justifyContent(FlexAlign.SpaceBetween)

  }
}