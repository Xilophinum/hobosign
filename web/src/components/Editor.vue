<!-- eslint-disable vue/multi-word-component-names -->
<template>
	<div id="editor" v-show="showing">
		<q-editor
            dark
            v-model="content"
            style="height: 35%;"
            :definitions="{
                save: {
                    tip: 'Save!',
                    icon: 'fa-solid fa-save',
                    label: 'Save',
                    handler: saveWork
                },
                sign1: {
                    tip: 'Sign 1',
                    icon: 'fa-solid fa-chalkboard',
                    label: 'Sign 1',
                    handler: changeTemplate(1)
                },
                sign2: {
                    tip: 'Sign 2',
                    icon: 'fa-solid fa-chalkboard',
                    label: 'Sign 2',
                    handler: changeTemplate(2)
                },
            }"
            :toolbar="[
                ['bold', 'italic', 'underline', 'strike'],
                [
                    {
                        label: $q.lang.editor.formatting,
                        icon: $q.iconSet.editor.formatting,
                        list: 'no-icons',
                        options: [
                            'p',
                            'h1',
                            'h2',
                            'h3',
                            'h4',
                            'h5',
                            'h6',
                            'code'
                        ]
                    },
                    {
                        label: $q.lang.editor.fontSize,
                        icon: $q.iconSet.editor.fontSize,
                        fixedLabel: true,
                        fixedIcon: true,
                        list: 'no-icons',
                        options: [
                            'size-1',
                            'size-2',
                            'size-3',
                            'size-4',
                            'size-5',
                            'size-6',
                            'size-7'
                        ]
                    },
                    {
                        label: $q.lang.editor.defaultFont,
                        icon: $q.iconSet.editor.font,
                        fixedIcon: true,
                        list: 'no-icons',
                        options: [
                            'font_1',
                            'font_2',
                            'font_3',
                            'font_4',
                            'font_5',
                            'font_6'
                        ]
                    },
                ],
                ['save', 'sign1', 'sign2']
            ]"
            :fonts="{
                font_1: 'PermanentMarker',
                font_2: 'VtksAnimal2',
                font_3: 'Haveagreatdaydemo',
                font_4: 'MarkerFont',
                font_5: 'Exposition',
                font_6: 'Dearkatienbp'
            }"
        />
        <div id="preview" :style="{backgroundImage: getBGImage(), width: getWidth(), height: getHeight()}">
            <div class="content-wrapper" v-html="content"></div>
        </div>
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

		}
	},
    computed: {

    },
	methods: {
        saveWork: function() {
            this.showing = false
            this.store.SendMessage("savesign", {content: this.content, picTemplate: String(this.picTemplate)})
        },
        getBGImage() {
            switch (this.picTemplate) {
                case 1:
                    return `url(${img1})`
                case 2:
                    return `url(${img2})`
            }
		},
		getWidth() {
            switch (this.picTemplate) {
                case 1:
                    return "256px"
                case 2:
                    return "256px"
            }
		},
		getHeight() {
            switch (this.picTemplate) {
                case 1:
                    return "256px"
                case 2:
                    return "256px"
            }
		},
        changeTemplate: function(temp) {
            return () => this.picTemplate = temp
        }
    },
    mounted() {
		this.eventBus.on('editSign', (data) => {
			this.showing = true
		})
    },
    unmounted() {
		this.eventBus.off("editSign");
    },
}
</script>

<style scoped>
#editor {
	position: absolute;
	top: 50%;
	left: 50%;
    transform: translate(-50%, -50%);
    width: 80%;
    height: 80%;
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-around;
    align-items: center;
    color: black;
}

#preview {
    display: flex;
    align-items: center;
    justify-content: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
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
