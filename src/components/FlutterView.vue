<template>
  <div class="template-list" ref="flutterTarget"></div>
</template>

<script setup lang="ts">
import { onUnmounted, ref } from 'vue'

const emits = defineEmits(['loadMore', 'initialized', 'refresh'])

declare var _flutter: any

export interface FlutterAppState {
  load(listString: string): void
  clear(): void
}

declare global {
  interface Window {
    _appState: FlutterAppState
  }
}

const flutterTarget = ref<HTMLElement>()

const flutterDir = (import.meta as any).env.VITE_FLUTTER_DIR

const initFlutterApp = async () => {
  const engineInitializer = await new Promise<any>((resolve) => {
    console.log('setup Flutter engine initializer...')
    _flutter.loader.loadEntrypoint({
      entrypointUrl: `${flutterDir}main.dart.js`,
      onEntrypointLoaded: resolve
    })
  })

  console.log('initialize Flutter engine...')
  const appRunner = await engineInitializer?.initializeEngine({
    hostElement: flutterTarget.value,
    assetBase: flutterDir
  })

  console.log('run Flutter engine...')
  await appRunner?.runApp()
}

initFlutterApp()

const load = (listString: string) => {
  window._appState.load(listString)
}

const clear = () => {
  window._appState.clear()
}

const onInitialized = () => {
  emits('initialized')
}

const onLoadMore = () => {
  emits('loadMore')
}

const onRefresh = () => {
  emits('refresh')
}

window.addEventListener('flutter-initialized', onInitialized)
window.addEventListener('flutter-list-load-more', onLoadMore)
window.addEventListener('flutter-list-refresh', onRefresh)

onUnmounted(() => {
  window.removeEventListener('flutter-initialized', onInitialized)
  window.removeEventListener('flutter-list-load-more', onLoadMore)
  window.removeEventListener('flutter-list-refresh', onRefresh)
})

defineExpose<FlutterAppState>({
  load,
  clear
})
</script>

<style>
.template-list {
  width: 100%;
  height: calc(100vh - 54px);
}
</style>
