import { CityView } from '../view/CityView';
import getweatherUtil from '../viewmodel/getWeatherUtil'
import {WeatherModel} from "../viewmodel/WeatherModel"
import { promptAction, router, SymbolGlyphModifier } from '@kit.ArkUI';
import { settingsManager } from '../viewmodel/SettingsManager'

interface cityInfos{
  names:string[]
  codes:number[]
}
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State ToolTmp : ToolbarItem = {'value':'func','action':()=>{}}
  @State ToolItems : ToolbarItem[] = [this.ToolTmp, this.ToolTmp, this.ToolTmp]

  @State cityCodeList : number[] = []
  @State cityNameList : string[] = []
  @State cityWeatherList : Array<WeatherModel> = []
  @State currentCityIndex : number = 0
  @State lastUpdateTime: string = ""

  tabscontroller : TabsController = new TabsController()

  @Builder tabBuild(index:number){
      Circle({ width: 10, height: 10 })
        .fill(this.currentCityIndex === index ? Color.Black : Color.Grey).opacity(0.4)
  }
  @Builder MenuBuild(){
    Menu(){
      MenuItem({
        symbolStartIcon: new SymbolGlyphModifier(($r('sys.symbol.arrow_clockwise'))),
        content:"刷新"
      })
        .onClick(()=>{
          this.initData()
        })
      MenuItem({
        symbolStartIcon: new SymbolGlyphModifier($r('sys.symbol.info_circle')),
        content:"关于"
      })
        .onClick(()=>{
          promptAction.showToast({
            message:"SHM_white Weather v0.1 NUAA"
          })

        })
    }
    .backgroundBlurStyle(BlurStyle.Regular)
    .backgroundColor(Color.Transparent)
  }
  onPageShow(): void {
    let params = router.getParams()
    if(params !== null){
      this.cityCodeList = (params as cityInfos)?.codes || []
      this.cityNameList = (params as cityInfos)?.names || []
      this.initData()
    }
  }
  aboutToAppear(){
    this.initData(true)
  }
  async readData(){
    //await settingsManager.setCityCodes([110000,120000,130000,140000,130637,370686,371602,540127,652700,810006])
    let r1 : number[] = await settingsManager.getCityCodes()
    let r2 = await settingsManager.getWeatherCache()
    this.cityWeatherList = r2
    this.cityCodeList = r1
  }
  async initData(start?:boolean){
    let r1 = await settingsManager.getLastUpdateTime()
    this.lastUpdateTime = r1
    await (start?this.readData():null)
    let result : Array<WeatherModel> = await getweatherUtil.getWeathers(this.cityCodeList)
    settingsManager.setWeatherCache(result)
    this.cityNameList = []
    this.cityWeatherList = []
    for (let i = 0; i < result.length; i++) {
      let SingleWeather : WeatherModel = new WeatherModel()
      SingleWeather = result[i]
      this.cityWeatherList.push(SingleWeather)
      this.cityNameList.push(result[i].forecasts[0].city)
    }
    //let r : number[] = await settingsManager.getCityCodes()
  }
  build() {
    Column(){
      Row(){
        Row(){
          Text((this.cityNameList.length === 0) ? "Example" : this.cityNameList[this.currentCityIndex])
            .margin(10)
            .fontSize(20)
          Text(`上次更新：${this.lastUpdateTime.substring(5, 16)}`).fontSize(13).margin({ top: 5 }).fontColor(Color.Grey)
        }
        Row(){
          Button(){
            SymbolGlyph($r('sys.symbol.plus')).margin(5).fontSize(20)
          }
            .backgroundColor(Color.Transparent)
            .onClick(()=>{
              router.pushUrl({
                url:"pages/CityManager",
                params:{
                  codes:this.cityCodeList,
                  names:this.cityNameList
                } as cityInfos
              })
            })
          Button(){
            SymbolGlyph($r('sys.symbol.dot_grid_2x2')).margin(5).fontSize(20)
          }
          .backgroundColor(Color.Transparent)
          .bindMenu(this.MenuBuild())

        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("95%")
      //.margin(10)
      Tabs({barPosition:BarPosition.Start,controller:this.tabscontroller}){
        ForEach(this.cityWeatherList,(cityWeather:WeatherModel)=>{
          TabContent(){
            CityView({weatherInfos : cityWeather.forecasts[0].casts,liveWeatherInfo:cityWeather.lives[0]})
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
  }
}