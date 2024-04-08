# flutter-embedding-list-for-vue

一个简单的如何使用 Vue3 + Flutter 混合布局，实现无限滚动瀑布流的示例.

## 相关链接

[web_embedding]<https://github.com/flutter/samples/tree/main/web_embedding>

## 关键点

## Vue3

- 使用`axios`网络请求。
- 使用`vant`进行 UI 绘制。

为了能够与 Flutter 模块一起使用，进行了以下改造：

- `package.json` 有一个 prebuild 构建 Flutter Web 应用程序的自定义脚本，把 Flutter Web 产物打包到 public/flutter/。
- `flutter.js` 使用`script`标签添加到 index.html 中。
- `components/FlutterView.vue`组件负责嵌入 Flutter Web，并通过 Vue 的 emit 以及 expose 方法让外部组件使用。

## Flutter

- Element embedded Flutter 项目位于 /flutter 文件夹中。该项目是一个标准的 Web 应用程序，并不需要知道它将嵌入到另一个框架中。
- Flutter 使用新`@staticInterop`方法允许从`JavaScript`调用某些`Dart`函数。
- 了解如何`createDartExport`把 Flutter 挂载到`window`上给 Vue 调用。

## 如何运行

### 安装

```sh
pnpm install
```

### 启动

```sh
pnpm dev
```

## Flutter 开发

### 重新构建

```sh
pnpm prebuild
```
