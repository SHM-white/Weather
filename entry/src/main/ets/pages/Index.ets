import { CityView } from '../view/CityView';
import getweatherUtil from '../viewmodel/getWeatherUtil'
import {WeatherModel} from "../viewmodel/WeatherModel"
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State ToolTmp : ToolbarItem = {'value':'func','action':()=>{}}
  @State ToolItems : ToolbarItem[] = [this.ToolTmp, this.ToolTmp, this.ToolTmp]

  @State cityCodeList : number[] = [110000,120000,130000,140000,130637,370686,371602,540127,652700,810006]
  @State cityNameList : string[] = []
  @State cityWeatherList : Array<WeatherModel> = []
  @State currentCityIndex : number = 0

  tabscontroller : TabsController = new TabsController()

  @Builder tabBuild(index:number){
      Circle({ width: 10, height: 10 })
        .fill(this.currentCityIndex === index ? Color.Black : Color.Grey).opacity(0.4)
  }

  aboutToAppear(){
    this.initDate()
  }
  async initDate(){
    let result : Array<WeatherModel> = await getweatherUtil.getWeathers(this.cityCodeList)
    for (let i = 0; i < result.length; i++) {
      let SingleWeather : WeatherModel = new WeatherModel()
      SingleWeather = result[i]
      this.cityWeatherList.push(SingleWeather)
      this.cityNameList.push(result[i].forecasts[0].city)
    }
  }
  build() {
    Column(){
      Row(){
        Text((this.cityNameList.length === 0)?"Example":this.cityNameList[this.currentCityIndex])
          .margin(10)
          .fontSize(20)
        Row(){
          SymbolGlyph($r('sys.symbol.plus')).margin(5).fontSize(20).onClick(()=>{})
          SymbolGlyph($r('sys.symbol.dot_grid_2x2')).margin(5).fontSize(20)
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("95%")
      //.margin(10)
      Tabs({barPosition:BarPosition.Start,controller:this.tabscontroller}){
        ForEach(this.cityWeatherList,(cityWeather:WeatherModel)=>{
          TabContent(){
            CityView({weatherInfos : cityWeather.forecasts[0].casts})
          }.tabBar(this.tabBuild(this.cityWeatherList.findIndex(obj=>obj === cityWeather)))

        })

      }.barWidth(this.cityNameList.length * 15)
      .barHeight(15)
      .scrollable(true)
      //.barBackgroundBlurStyle(BlurStyle.Regular)
      .onChange((index:number)=>{
        this.currentCityIndex = index
      })
    }.width("100%")
    .height("100%")
    .backgroundColor(0xf6f6f6)

    /*RelativeContainer() {

      Navigation(){

      }
      .mode(NavigationMode.Auto)
      .toolbarConfiguration(this.ToolItems)

    }
    .height('100%')
    .width('100%')
    */
  }
}