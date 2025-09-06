<!-- eslint-disable vue/multi-word-component-names -->
<template>
	<div id="sign" v-show="showing" :style="{backgroundImage: getBGImage(), width: getWidth(), height: getHeight()}">
		<div class="content-wrapper" v-html="content"></div>
	</div>
</template>

<script>
import { useStore } from '../stores/store'
import img1 from '../assets/sign_01.png'
import img2 from '../assets/sign_02.png'

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
			content: "",
			picTemplate: 1,
			templateMap: {
				1: { width: "256px", height: "256px" },
				2: { width: "256px", height: "256px" }
			}
		}
	},
    computed: {

    },
	methods: {
        getBGImage() {
            switch (this.picTemplate) {
                case 1:
                    return `url(${img1})`
                case 2:
                    return `url(${img2})`
            }
		},
		getWidth() {
            return this.templateMap[this.picTemplate].width
		},
		getHeight() {
            return this.templateMap[this.picTemplate].height
		},
    },
    mounted() {
		this.eventBus.on('sign', (data) => {
			this.showing = true
			this.content = data.content
			this.picTemplate = Number(data.picTemplate)
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
