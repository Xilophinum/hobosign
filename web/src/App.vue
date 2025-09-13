<template>
    <div id="app">
		<Editor />
		<Hobosign />
    </div>
</template>

<script>
import { useStore } from './stores/store'
import Hobosign from './components/Hobosign.vue'
import Editor from './components/Editor.vue';

export default {
	name: 'App',
	components: {
		Hobosign,
		Editor
	},
	setup () {
        const store = useStore();
        return { store }
	},
	methods: {
		eventHandler: function(event) {
			this.eventBus.emit(event.data.action, event.data)
		},
	},
	mounted() {
		window.addEventListener("message", this.eventHandler);
		fetch(`https://hobosign/loaded`, { method: 'POST', headers: { 'Content-Type': 'application/json; charset=UTF-8' }, body: JSON.stringify({}) })
	},
	unmounted() {
		window.removeEventListener("message", this.eventHandler);
	}
}
</script>

<style>

@font-face {
  font-family: 'VtksAnimal2';
  src: url('./assets/VtksAnimal2.ttf') format('truetype');
}
@font-face {
  font-family: 'PermanentMarker';
  src: url('./assets/PermanentMarker.ttf') format('truetype');
}
@font-face {
  font-family: 'Haveagreatdaydemo';
  src: url('./assets/Haveagreatdaydemo.ttf') format('truetype');
}
@font-face {
  font-family: 'MarkerFont';
  src: url('./assets/MarkerFont.ttf') format('truetype');
}
@font-face {
  font-family: 'Exposition';
  src: url('./assets/Exposition.ttf') format('truetype');
}
@font-face {
  font-family: 'Dearkatienbp';
  src: url('./assets/Dearkatienbp.ttf') format('truetype');
}

body, html {
	width: 100%;
	height: 100%;
}

::-webkit-scrollbar {
	width: 0px;
	background: transparent;
}
</style>