# flutter-embedding-list-for-vue

A simple example of how to use Vue3 + Flutter for hybrid layout to implement infinite scrolling waterfall stream.

## Related Links

[web_embedding]<https://github.com/flutter/samples/tree/main/web_embedding>

## Points of Interest

## Vue3

- Using `axios` for network requests.
- Using `vant` for UI rendering.

To be able to use with the Flutter module, the following modifications have been made:

- `package.json` has a prebuild script for building Flutter Web application, which packages the Flutter Web products into public/flutter/.
- `flutter.js` is added to index.html using the `script` tag.
- The `components/FlutterView.vue` component is responsible for embedding Flutter Web, and allows external components to use it through Vue's emit and expose methods.

## Flutter

- The Element embedded Flutter project is located in the /flutter folder. This project is a standard web application and does not need to know that it will be embedded in another framework.
- Flutter uses the new `@staticInterop` method to allow certain `Dart` functions to be called from `JavaScript`.
- Understand how to `createDartExport` mounts Flutter to `window` for Vue to call.

## How to build the app

### Installation

```sh
pnpm install
```

### Start

```sh
pnpm dev
```

## Flutter Development

### Rebuild

```sh
pnpm prebuild
```
