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

    }.width("100%")
    .height("100%")
    .backgroundColor(0xf6f6f6)

  }
}