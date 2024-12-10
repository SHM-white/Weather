import { preferences } from '@kit.ArkData';

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

export const preferenceUtils = new PreferenceUtils()

class SettingsManagerUtils{
  async getCityCodes():Promise<number[]>{

    return new Promise<number[]>((resolve)=>{
      let result = preferenceUtils.get("CityCodes","")
      result.then((res)=>{
        resolve(JSON.parse(res.toString()))
      })
    })
  }
  async setCityCodes(codes:number[]){
    await preferenceUtils.set("CityCodes",JSON.stringify(codes))
  }
}

export const settingsManager = new SettingsManagerUtils()