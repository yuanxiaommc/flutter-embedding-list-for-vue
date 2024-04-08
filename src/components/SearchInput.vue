<template>
  <div class="search-input">
    <Search v-model="textInput" show-action placeholder="请输入搜索关键词" @search="onSearch">
      <template #action>
        <div @click="onSearch">搜索</div>
      </template>
    </Search>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Search } from 'vant'

const emits = defineEmits(['search'])

const textInput = ref<string>('')

const onSearch = () => {
  emits('search', textInput.value)
}
</script>

<style>
.search-input {
  height: 54px;
}
</style>
