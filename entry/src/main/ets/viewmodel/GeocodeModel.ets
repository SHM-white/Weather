import Geocode from "./Geocode"
export default class GeocodeModel{
  status:number = 0
  count:number = 0
  infocode:number = 0
  geocodes:Array<Geocode> = []
}