import {WeatherInfo} from "../viewmodel/WeatherInfo"
import {LiveWeatherInfo} from "../viewmodel/LiveWeatherInfo"
interface LinearGradientInterface {
  angle?: number | string
  direction?: GradientDirection
  colors: Array<[ResourceColor, number]>
  repeating?: boolean;
}

@Component
export struct CityView{
  weatherInfos : Array<WeatherInfo> = []
  liveWeatherInfo : LiveWeatherInfo = new LiveWeatherInfo()
  @Builder weatherImg(weather:string,width:number = 30){
    Column(){
      if (weather === "晴") {
        Image($r('app.media.Sunny')).width(width)
      }
      else if (weather === "阴") {
        Image($r('app.media.104')).width(width)
      }
      else if (weather === "多云") {
        Image($r('app.media.Cloudy')).width(width)
      }
      else if (weather === "雨夹雪") {
        Image($r('app.media.404')).width(width)
      }
      else if (weather.includes("雨")) {
        Image($r('app.media.Rain')).width(width)
      }
      else if(weather.includes("雪")){
        Image($r('app.media.Snow')).width(width)
      }
      else if(weather.includes("雾")){
        Image($r('app.media.Foggy')).width(width)
      }
      else if(weather.includes("霾")){
        Image($r('app.media.502')).width(width)
      }
    }
  }

  viewBackground(weather:string){
    if (weather === "晴") {
      return ({ angle: 270, colors:[[0xfdbc4c,0],[0xff8300,1]] } as LinearGradientInterface)
    }
    else if (weather === "阴") {
      return ({ angle: 270, colors:[[0x9DAFC1,0],[0x2d5879,1]] } as LinearGradientInterface)
    }
    else if (weather === "多云") {
      return ({ angle: 270, colors:[[0x00a5d9,0],[0x1762ac,1]] } as LinearGradientInterface)
    }
    else if (weather === "雨夹雪") {
      return ({ angle: 270, colors:[[0x68baff,0],[0x0071ff,1]] } as LinearGradientInterface)
    }
    else if (weather.includes("雨")) {
      return ({ angle: 270, colors:[[0x4297e7,0],[0x3a4d80,1]] } as LinearGradientInterface)
    }
    else if(weather.includes("雪")){
      return ({ angle: 270, colors:[[0x68baff,0],[0x225fb6,1]] } as LinearGradientInterface)
    }
    else if(weather.includes("雾") || weather.includes("霾")){
      return ({ angle: 270, colors:[[0xD7DDE8,0],[0x757F9A,1]] } as LinearGradientInterface)
    }
    else if(weather.includes("雹")){
      return ({ angle: 270, colors:[[0x68baff,0],[0x225fb6,1]] } as LinearGradientInterface)
    }
    return ({} as LinearGradientInterface)
  }

  build(){
    Column(){
      Column(){
        Row() {
          Column() {
            Text(this.liveWeatherInfo.temperature.toString() + "℃").fontSize(50).fontWeight(FontWeight.Bold).margin(5).textAlign(TextAlign.Start)
            Row(){
              Text(this.liveWeatherInfo.weather).fontSize(15).margin(5).border({radius:20}).backgroundBlurStyle(BlurStyle.Regular).padding(5)
              Text("湿度："+this.liveWeatherInfo.humidity.toString()+"%").fontSize(15).margin(5).border({radius:20}).backgroundBlurStyle(BlurStyle.Regular).padding(5)
            }
            Row(){
              Text(this.liveWeatherInfo.winddirection.toString() + "风 风力等级" + this.liveWeatherInfo.windpower.toString()).fontSize(15).margin(5).border({radius:20}).backgroundBlurStyle(BlurStyle.Regular).padding(5)
            }
          }.align(Alignment.Start)
          .margin({ left: 20 })
          this.weatherImg(this.liveWeatherInfo.weather,180)
        }.justifyContent(FlexAlign.SpaceBetween)

        /*Column(){
          Text(this.weatherInfos[0].nighttemp + "~" + this.weatherInfos[0].daytemp + "℃").fontSize(20)
            .margin(10)
          Text(this.weatherInfos[0].daywind + "风" + this.weatherInfos[0].daypower + "级").fontSize(20)
            .margin(10)
          Text(this.weatherInfos[0].nightwind + "风" + this.weatherInfos[0].nightpower + "级").fontSize(20)
            .margin({ bottom:20 })
        }
        .margin({top:20})
        */
      }
      .width("90%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin(20)
      .borderRadius(10)
      .layoutWeight(2)
      .linearGradient(this.viewBackground(this.liveWeatherInfo.weather))

      Column(){
        ForEach(this.weatherInfos,(weatherInfo:WeatherInfo)=>{
          Row(){
            Text(weatherInfo.date.substring(5))
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .margin(3)
              .width("18%")
            Text(weatherInfo.dayweather)
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .margin(3)
              .width("15%")
            this.weatherImg(weatherInfo.nightweather)
            Text(weatherInfo.nighttemp + "℃" + "~" + weatherInfo.daytemp + "℃")
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .margin(5)
              .layoutWeight(2)
              .textAlign(TextAlign.Center)
            this.weatherImg(weatherInfo.dayweather)
          }
          .justifyContent(FlexAlign.SpaceAround)
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