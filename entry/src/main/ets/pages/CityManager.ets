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
    RelativeContainer() {
      Text(this.message)
        .id('CityManagerHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}