# Weather (天气) for HarmonyOS Next

本项目为参加Codelabs校园挑战赛搓出来的，第一次写HarmonyOS原生程序，一直在摸索界面和功能做的都比较简陋，望海涵。

## 作品介绍

本项目为一个简单的天气预报程序，调用的是相对简单的高德开放平台的天气API，支持输入地名添加城市，使用 `adcode`作为一个城市的唯一标识存储和处理，使用高德开放平台逆地理编码接口实现输入地名获取对应的 `adcode`。

> （其实是因为后来才看到华为提供了一个API，但已经把基本功能做了就懒得管了才都用的高德的，而且以前也用过稍微熟悉点（小声））

进入软件后默认无城市，点击右上角加号进入城市管理页面添加，再点击页面中的加号在弹出的对话框中输入地名可自动获取对应 `adcode`，并自动添加进列表中(*若城市名称显示异常，如空白、重复、地点范围过大可退出该页面再打开即可更新*)。每个城市名称后分别有删除和设置按钮，可对城市列表进行操作（*更改对应位置的城市或直接删除*），此时点击设置后的编辑弹窗会显示对应的`adcode`。

