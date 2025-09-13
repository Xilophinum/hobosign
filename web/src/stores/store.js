/* eslint-disable no-undef */
import { defineStore } from 'pinia'

export const useStore = defineStore('store', {
    state: () => ({
        resourceName: null,
    }),
})