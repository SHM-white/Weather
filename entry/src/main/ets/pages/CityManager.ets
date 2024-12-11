import router from '@ohos.router';

interface cityInfos{
  names:string[]
  codes:number[]
}
@Entry
@Component
struct CityManager {
  @State message: string = 'Hello World';

  @State cityNameList:string[] = []
  @State cityCodeList:number[] = []
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
            }
          })
        })
      }.width("100%")
      ForEach(this.cityNameList,(name:string)=>{
        Row(){
          Text(name).fontSize(20).margin(10).textAlign(TextAlign.Start)
          Button("删除").fontSize(17).margin(10)
          Button(){
            SymbolGlyph($r('sys.symbol.dot_3_viewfinder'))
          }
          .backgroundColor(Color.Transparent)
        }
        .width("90%")
        .justifyContent(FlexAlign.SpaceBetween)
      })
    }.width("100%")
    .height("100%")
    .backgroundColor(0xf6f6f6)

  }
}