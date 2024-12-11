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
              Button(){
                SymbolGlyph($r('sys.symbol.gearshape')).fontSize(20)
              }
              .backgroundColor(Color.Transparent)
              .margin(5)
            }
            .width("90%")
            .justifyContent(FlexAlign.SpaceEvenly)
          })
          Button(){
            SymbolGlyph($r('sys.symbol.plus'))
          }
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