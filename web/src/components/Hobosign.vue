<!-- eslint-disable vue/multi-word-component-names -->
<template>
	<div id="sign" v-show="showing" :style="{backgroundImage: getBGImage(), width: '256px', height: '256px'}">
		<div class="content-wrapper" v-html="content"></div>
	</div>
</template>

<script>
import { useStore } from '../stores/store'
import img from '../assets/sign_01.png'

export default {
	components: {
		
	},
	setup () {
        const store = useStore();
		return {
            store
		}
	},
	data() {
		return {
			showing: false,
			content: ""
		}
	},
    computed: {

    },
	methods: {
        getBGImage() {
            return `url(${img})`
		}
    },
    mounted() {
		this.eventBus.on('sign', (data) => {
			this.showing = true
			this.content = data.content
		})
    },
    unmounted() {
		this.eventBus.off("sign");
    },
}
</script>

<style scoped>
#sign {
	position: absolute;
	top: 0;
	left: 0;
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
	color: black;
}

.content-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    width: 100%;
    height: 100%;
    padding: 10px;
    box-sizing: border-box;
}
</style>
