import getweatherUtil from '../viewmodel/getWeatherUtil'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State ToolTmp : ToolbarItem = {'value':'func','action':()=>{}}
  @State ToolItems : ToolbarItem[] = [this.ToolTmp, this.ToolTmp, this.ToolTmp]

  build() {
    Column(){

    }
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