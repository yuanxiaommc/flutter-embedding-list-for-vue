<template>
  <div>
    <SearchInput @search="onSearch" />
    <FlutterView
      ref="flutterListView"
      @initialized="onInitialized"
      @refresh="onRefresh"
      @load-more="onLoadMore"
    />
  </div>
</template>

<script setup lang="ts">
import SearchInput from '../components/SearchInput.vue'
import FlutterView, { type FlutterAppState } from '../components/FlutterView.vue'
import { ref } from 'vue'
import { searchTemplateList } from '@/services/request'

const flutterListView = ref<FlutterAppState | null>(null)

var currentNum = ref<number>(1)
var textInput = ref<string>('')

const onInitialized = () => {
  loadData()
}

const onSearch = (text: string) => {
  flutterListView.value?.clear()
  textInput.value = text
  currentNum.value = 1
  loadData()
}

const onRefresh = () => {
  currentNum.value = 1
  loadData()
}

const onLoadMore = () => {
  currentNum.value++
  loadData()
}

const loadData = async () => {
  const res = await searchTemplateList(textInput.value, currentNum.value)
  flutterListView.value?.load(JSON.stringify(res))
}
</script>
