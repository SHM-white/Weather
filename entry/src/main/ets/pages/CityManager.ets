import router from '@ohos.router';
import {settingsManager} from '../viewmodel/SettingsManager'
import getweatherUtil from '../viewmodel/getWeatherUtil'
import Geocode from '../viewmodel/Geocode'
import { promptAction } from '@kit.ArkUI';

interface cityInfos{
  names:string[]
  codes:number[]
}
@Component
struct GeocodeShower{
  @State geocode:Geocode = {} as Geocode
  build() {
    Column(){
      Text(this.geocode.city)
      Text(this.geocode.adcode.toString())
    }
  }
}
@CustomDialog
@Component
struct InputCityNameDialog{
  @Link input: string
  @Link cityName: string
  @Link adcode: number
  @Link index: number
  controller?:CustomDialogController
  cancel: () => void = () => {
  }
  confirm: (index:number) => void = () => {
  }
  build() {
    Column(){
      Text('城市名称').fontSize(20).margin(10).width("90%")
      if (this.adcode !== 0){
        Text(`adcode:${this.adcode.toString()}`).fontSize(10).fontColor(Color.Grey).width("90%")
      }
      TextInput({ placeholder: '', text: this.cityName }).height(45).width('90%').margin(10)
        .onChange((value: string) => {
          this.input = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          }).backgroundColor(0xf6f6f6).fontColor(Color.Black)
          .margin({ left:10,right:10 }).layoutWeight(1)
        Button('确定')
          .onClick(() => {
            if (this.controller != undefined) {
              this.cityName = this.input
              this.controller.close()
              this.confirm(this.index)
            }
          }).backgroundColor(0xf6f6f6).fontColor(Color.Blue)
          .margin({ left:10,right:10 }).layoutWeight(1)
      }.margin(10)
    }

  }
}

@Entry
@Component
struct CityManager {

  @State cityNameList:string[] = []
  @State cityCodeList:number[] = []

  @State input: string = ''
  @State cityName: string = ''
  @State adcode: number = 0
  @State index: number = 0
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: InputCityNameDialog({
      cancel: ()=> { this.onCancel() },
      confirm: (index:number)=> { this.onAccept(index) },
      input: $input,
      cityName: $cityName,
      adcode: $adcode,
      index: $index
    }),
    cancel: this.exitApp,
    autoCancel: true,
    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 20,
  })
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }
  onCancel() {
    console.info('Callback when the first button is clicked')
  }
  async onAccept(index:number) {
    let result = await getweatherUtil.getGeoCodes(this.cityName)
    if(result[0].adcode === 100000 || result[0].adcode.toString() === "100000"){
      promptAction.showToast(({
        message:"请输入具体地点"
      }))
      return
    }
    if(this.cityCodeList.findIndex(obj=>obj===result[0].adcode) !== -1){
      promptAction.showToast({
        message:`重复添加：${result[0].city},${result[0].adcode}`
      })
      return
    }
    if(index >= this.cityNameList.length){
      this.cityNameList.push(result[0].city)
      this.cityCodeList.push(result[0].adcode)
      try {
        promptAction.showToast({
          message:`添加：${result[0].province}${result[0].city}${result[0].formatted_address},${result[0].adcode}`
        })
      } catch (e) {

      }
    }
    else {
      this.cityNameList[index] = result[0].city
      this.cityCodeList[index] = result[0].adcode
      promptAction.showToast({
        message:`修改为：${result[0].city},${result[0].adcode}`
      })
    }
    settingsManager.setCityCodes(this.cityCodeList)
  }
  exitApp() {

  }
  onPageShow(): void {
    let param = (router.getParams()|| {}) as cityInfos
    this.cityNameList = param.names || []
    this.cityCodeList = param.codes || []
  }
  build() {
    Column(){
      Row(){
        Button(){
          SymbolGlyph($r('sys.symbol.arrow_left')).margin(5).fontSize(20)
        }
        .margin({ left:10, top:5})
        .backgroundColor(Color.Transparent)
        .onClick(()=>{
          router.back({
            url:"pages/Index",
            params:{
              names:this.cityNameList,
              codes:this.cityCodeList
            } as cityInfos
          })
        })
      }.width("95%")
      .margin({bottom:10})

      Scroll(){
        Column(){
          ForEach(this.cityCodeList,(code:number)=>{
            Row(){
              Text(this.cityNameList[this.cityCodeList.findIndex(obj=>obj===code)]).fontSize(20).margin(10).textAlign(TextAlign.Start)
                .layoutWeight(1)
              Button(){
                SymbolGlyph($r('sys.symbol.trash')).fontSize(20).fontColor([Color.Red])
              }
              .backgroundColor(Color.Transparent)
              .margin(5)
              .onClick(()=>{
                let index = this.cityCodeList.findIndex(obj=>obj===code)
                promptAction.showDialog({
                  title:"你确定要删除吗？",
                  message:`${this.cityNameList[index]} ${this.cityCodeList[index]}`,
                  isModal:true,
                  showInSubWindow:true,
                  alignment:DialogAlignment.Bottom,
                  buttons:[
                    {
                      text:"取消",
                      color:Color.Black.toString()
                    },
                    {
                      text:"确定",
                      color:Color.Red.toString()
                    }
                  ]
                },(err,data)=>{
                  if(err){
                    console.warn(err.message)
                    return
                  }
                  if(data.index == 1){
                    this.cityNameList.splice(index, 1)
                    this.cityCodeList.splice(index, 1)
                    settingsManager.setCityCodes(this.cityCodeList)
                  }
                })
              })
              Button(){
                SymbolGlyph($r('sys.symbol.gearshape')).fontSize(20)
              }
              .backgroundColor(Color.Transparent)
              .margin(5)
              .onClick(()=>{
                this.index = this.cityCodeList.findIndex(obj=>obj===code)
                this.cityName = this.cityNameList[this.index]
                this.adcode = this.cityCodeList[this.index]
                if(this.dialogController !== null){
                  this.dialogController.open()
                }
              })
            }
            .width("90%")
            .justifyContent(FlexAlign.SpaceEvenly)
            .borderRadius(30).backgroundColor(Color.White)
            .margin(5)
            .padding({left:5,right:7})
          })
          Button(){
            SymbolGlyph($r('sys.symbol.plus'))
          }
          .onClick(()=>{
            this.index = this.cityNameList.length
            this.cityName = ""
            this.adcode = 0
            if(this.dialogController !== null){
              this.dialogController.open()
            }
          })
          .width("90%")
          .height(40)
          .backgroundColor(Color.Transparent)
          .border({style:BorderStyle.Dashed,color:Color.Grey,radius:5,width:2})
          .margin(5)
        }
        .width("90%")
      }.scrollable(ScrollDirection.Vertical)
      .width("100%")
      .height("93%")
      .align(Alignment.Top)

    }.width("100%")
    .height("100%")
    .backgroundColor(0xf6f6f6)
  }
}