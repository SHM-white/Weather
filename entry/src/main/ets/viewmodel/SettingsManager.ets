import { preferences } from '@kit.ArkData';
import { WeatherModel } from './WeatherModel';
import systemDateTime from '@ohos.systemDateTime';

const name = "UserData"

class PreferenceUtils{
  async get(key:string,defaultValue:preferences.ValueType){
    try {
      const context: Context = getContext(this)
      const preference = await preferences.getPreferences(context, name)
      const result = await preference.get(key, defaultValue)
      console.log(`get key:${key},success`)
      return result
    }
    catch (e){
      console.log(`get key:${key},failed`)
      return defaultValue
    }
  }
  async set(key:string,value:preferences.ValueType){
    try {
      const context: Context = getContext(this)
      const preference = await preferences.getPreferences(context, name)
      await preference.put(key, value)
      await preference.flush()
      console.log(`put key:${key},success`)
    }
    catch (e){
      console.log(`put key:${key},failed`)
    }
  }
  async delete(key:string){
    try {
      const context: Context = getContext(this)
      const preference = await preferences.getPreferences(context, name)
      await preference.delete(key)
      await preference.flush()
      console.log(`delete key:${key},success`)
    }
    catch (e){
      console.log(`delete key:${key},failed`)
    }
  }
}

export const preferenceUtils = new PreferenceUtils() as PreferenceUtils

class SettingsManagerUtils{
  async getCityCodes():Promise<number[]>{
    return new Promise<number[]>((resolve)=>{
      let result = preferenceUtils.get("CityCodes","[]")
      result.then((res)=>{
        resolve(JSON.parse(res.toString()))
      })
    })
  }
  async setCityCodes(codes:number[]){
    await preferenceUtils.set("CityCodes",JSON.stringify(codes))
  }

  async getCityNames():Promise<string[]>{
    return new Promise<string[]>((resolve)=>{
      let result = preferenceUtils.get("CityNames","[]")
      result.then((res)=>{
        resolve(JSON.parse(res.toString()))
      })
    })
  }
  async setCityNames(names:string[]){
    await preferenceUtils.set("CityNames",JSON.stringify(names))
  }

  async setWeatherCache(weathers:Array<WeatherModel>){
    await preferenceUtils.set("Weather",JSON.stringify(weathers))
    let date = new Date(systemDateTime.getTime())
    const year = date.getFullYear();
    const month = ("0" + (date.getMonth() + 1)).slice(-2); // 月份从0开始，需要加1并补0
    const day = ("0" + date.getDate()).slice(-2); // 日期补0
    const hours = ("0" + date.getHours()).slice(-2); // 小时补0
    const minutes = ("0" + date.getMinutes()).slice(-2); // 分钟补0
    const seconds = ("0" + date.getSeconds()).slice(-2); // 秒补0
    const formattedTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    await preferenceUtils.set("UpdateTime",formattedTime)
  }
  async getLastUpdateTime(){
    return await preferenceUtils.get("UpdateTime","")
  }
  async getWeatherCache():Promise<Array<WeatherModel>>{
    return new Promise<Array<WeatherModel>>((resolve)=>{
      let result = preferenceUtils.get("Weather","[]")
      result.then((res)=>{
        resolve(JSON.parse(res.toString()))
      })
    })
  }
}

export const settingsManager = new SettingsManagerUtils() as SettingsManagerUtils