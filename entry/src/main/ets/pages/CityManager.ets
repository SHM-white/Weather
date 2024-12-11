import router from '@ohos.router';
import text from '@ohos.graphics.text';

interface cityInfos{
  names:string[]
  codes:number[]
}
@CustomDialog
@Component
struct InputCityNameDialog{
  @Link input: string
  @Link cityName: string
  @Link adcode?: number
  controller?:CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  build() {
    Column(){
      Text('Change text').fontSize(20).margin({ top: 10, bottom: 10 })
      if (this.adcode !== 0){
        Text(this.adcode?.toString()).fontSize(5).fontColor(Color.Grey)
      }
      TextInput({ placeholder: '', text: this.cityName }).height(60).width('90%')
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
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            if (this.controller != undefined) {
              this.cityName = this.input
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }
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
  @State adcode:number = 0
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: InputCityNameDialog({
      cancel: ()=> { this.onCancel() },
      confirm: ()=> { this.onAccept() },
      input: this.input,
      cityName: this.cityName,
      adcode:this.adcode
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
    cornerRadius: 10,
  })
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }
  onCancel() {
    console.info('Callback when the first button is clicked')
  }
  onAccept() {
    console.info('Callback when the second button is clicked')
  }
  exitApp() {
    console.info('Click the callback in the blank area')
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
          ForEach(this.cityNameList,(name:string)=>{
            Row(){
              Text(name).fontSize(20).margin(10).textAlign(TextAlign.Start)
                .layoutWeight(1)
              Button(){
                SymbolGlyph($r('sys.symbol.trash')).fontSize(20)
              }
              .backgroundColor(Color.Transparent)
              .margin(5)
              .onClick(()=>{
                let index = this.cityNameList.findIndex(obj=>obj===name)
                this.cityNameList.splice(index, 1)
                this.cityCodeList.splice(index, 1)
              })
              Button(){
                SymbolGlyph($r('sys.symbol.gearshape')).fontSize(20)
              }
              .backgroundColor(Color.Transparent)
              .margin(5)
              .onClick(()=>{

              })
            }
            .width("90%")
            .justifyContent(FlexAlign.SpaceEvenly)
          })
          Button(){
            SymbolGlyph($r('sys.symbol.plus'))
          }
          .onClick(()=>{
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